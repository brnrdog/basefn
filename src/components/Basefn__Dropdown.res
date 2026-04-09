%%raw(`import './Basefn__Dropdown.css'`)

open Xote

type menuItem = {
  label: string,
  onClick: unit => unit,
  disabled?: bool,
  danger?: bool,
}

type menuContent =
  | Item(menuItem)
  | Separator

let getKey: Dom.event => string = %raw(`function(e) { return e.key || "" }`)
let focusIndex: (Dom.element, int) => unit = %raw(`function(menu, idx) {
  var items = menu.querySelectorAll('.basefn-dropdown__item:not([disabled])');
  if (items[idx]) items[idx].focus();
}`)
let countItems: Dom.element => int = %raw(`function(menu) {
  return menu.querySelectorAll('.basefn-dropdown__item:not([disabled])').length;
}`)
let queryMenu: unit => Nullable.t<Dom.element> = %raw(`function() {
  return document.querySelector('.basefn-dropdown__menu');
}`)

@jsx.component
let make = (
  ~trigger: Component.node,
  ~items: array<menuContent>,
  ~align: [#left | #right]=#left,
) => {
  let isOpen = Signal.make(false)
  let activeIdx = Signal.make(0)

  let close = () => {
    Signal.set(isOpen, false)
    Signal.set(activeIdx, 0)
  }

  let handleToggle = _ => {
    let opening = !Signal.peek(isOpen)
    Signal.set(isOpen, opening)
    if opening {
      Signal.set(activeIdx, 0)
      let _ = %raw(`requestAnimationFrame(() => {
        var menu = document.querySelector('.basefn-dropdown__menu');
        if (menu) focusIndex(menu, 0);
      })`)
    }
  }

  let handleItemClick = (onClick: unit => unit, disabled: bool) => {
    switch disabled {
    | true => ()
    | _ => {
        onClick()
        close()
      }
    }
  }

  let handleKeyDown = (evt: Dom.event) => {
    let key = getKey(evt)
    switch key {
    | "ArrowDown" => {
        let _ = Basefn__Dom.preventDefault(evt)
        let menu = queryMenu()
        switch Nullable.toOption(menu) {
        | Some(m) => {
            let total = countItems(m)
            Signal.update(activeIdx, i => i < total - 1 ? i + 1 : 0)
            focusIndex(m, Signal.peek(activeIdx))
          }
        | None => ()
        }
      }
    | "ArrowUp" => {
        let _ = Basefn__Dom.preventDefault(evt)
        let menu = queryMenu()
        switch Nullable.toOption(menu) {
        | Some(m) => {
            let total = countItems(m)
            Signal.update(activeIdx, i => i > 0 ? i - 1 : total - 1)
            focusIndex(m, Signal.peek(activeIdx))
          }
        | None => ()
        }
      }
    | "Escape" => close()
    | _ => ()
    }
  }

  let getMenuClass = () => {
    let baseClass = "basefn-dropdown__menu"
    let alignClass = switch align {
    | #right => " basefn-dropdown__menu--right"
    | #left => ""
    }
    baseClass ++ alignClass
  }

  let handleBackdropClick = _ => close()

  let menuContent = Computed.make(() => {
    if Signal.get(isOpen) {
      [
        <div class="basefn-dropdown__backdrop" onClick={handleBackdropClick} />,
        <div class={getMenuClass()} role="menu" onKeyDown={handleKeyDown}>
          {items
          ->Array.mapWithIndex((item, index) => {
            switch item {
            | Item({label, onClick, ?disabled, ?danger}) => {
                let disabled = disabled->Option.getOr(false)
                let danger = danger->Option.getOr(false)
                let className =
                  "basefn-dropdown__item" ++
                  (disabled ? " basefn-dropdown__item--disabled" : "") ++ (
                    danger ? " basefn-dropdown__item--danger" : ""
                  )

                <button
                  key={Int.toString(index)}
                  class={className}
                  onClick={_ => handleItemClick(onClick, disabled)}
                  disabled={disabled}
                  role="menuitem"
                  tabIndex={0}
                >
                  {Component.text(label)}
                </button>
              }
            | Separator => <div key={Int.toString(index)} class="basefn-dropdown__separator" />
            }
          })
          ->Component.fragment}
        </div>,
      ]
    } else {
      []
    }
  })

  <div class="basefn-dropdown">
    <div onClick={handleToggle}> {trigger} </div>
    {Component.signalFragment(menuContent)}
  </div>
}

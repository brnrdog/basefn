%%raw(`import './Eita__Dropdown.css'`)

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

@jsx.component
let make = (
  ~trigger: Component.node,
  ~items: array<menuContent>,
  ~align: [#left | #right]=#left,
) => {
  let isOpen = Signal.make(false)

  let handleToggle = _ => {
    Signal.update(isOpen, prev => !prev)
  }

  let handleItemClick = (onClick: unit => unit, disabled: bool) => {
    switch disabled {
    | true => ()
    | _ => {
        onClick()
        Signal.set(isOpen, false)
      }
    }
  }

  let getMenuClass = () => {
    let baseClass = "eita-dropdown__menu"
    let alignClass = switch align {
    | #right => " eita-dropdown__menu--right"
    | #left => ""
    }
    baseClass ++ alignClass
  }

  let menuContent = Computed.make(() => {
    if Signal.get(isOpen) {
      [
        <div class={getMenuClass()}>
          {items
          ->Array.mapWithIndex((item, index) => {
            switch item {
            | Item({label, onClick, disabled, danger}) => {
                let className =
                  "eita-dropdown__item" ++
                  (disabled ? " eita-dropdown__item--disabled" : "") ++ (
                    danger ? " eita-dropdown__item--danger" : ""
                  )

                <button
                  key={Int.toString(index)}
                  class={className}
                  onClick={_ => handleItemClick(onClick, disabled)}
                  disabled={disabled}
                >
                  {Component.text(label)}
                </button>
              }
            | Separator => <div key={Int.toString(index)} class="eita-dropdown__separator" />
            }
          })
          ->Component.fragment}
        </div>,
      ]
    } else {
      []
    }
  })

  <div class="eita-dropdown">
    <div onClick={handleToggle}> {trigger} </div>
    {Component.signalFragment(menuContent)}
  </div>
}

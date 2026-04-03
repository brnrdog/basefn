%%raw(`import './Basefn__Combobox.css'`)

open Xote

type comboboxOption = {
  value: string,
  label: string,
}

@jsx.component
let make = (
  ~value: Signal.t<string>,
  ~options: array<comboboxOption>,
  ~onChange: option<string => unit>=?,
  ~placeholder: string="Search...",
  ~disabled: bool=false,
  ~emptyMessage: string="No results found.",
) => {
  let query = Signal.make("")
  let isOpen = Signal.make(false)
  let activeIndex = Signal.make(0)

  let filteredOptions = Computed.make(() => {
    let q = Signal.get(query)->String.toLowerCase
    if q === "" {
      options
    } else {
      options->Array.filter(opt => opt.label->String.toLowerCase->String.includes(q))
    }
  })

  let handleSelect = (opt: comboboxOption) => {
    Signal.set(value, opt.value)
    Signal.set(query, opt.label)
    Signal.set(isOpen, false)
    Signal.set(activeIndex, 0)
    switch onChange {
    | Some(cb) => cb(opt.value)
    | None => ()
    }
  }

  let handleInput = (evt: Dom.event) => {
    let v: string = Basefn__Dom.target(evt)["value"]
    Signal.set(query, v)
    Signal.set(activeIndex, 0)
    if !Signal.peek(isOpen) {
      Signal.set(isOpen, true)
    }
  }

  let handleKeyDown = (evt: Dom.event) => {
    let key: string = %raw(`evt.key`)
    let items = Signal.peek(filteredOptions)
    let len = Array.length(items)

    switch key {
    | "ArrowDown" => {
        let _ = Basefn__Dom.preventDefault(evt)
        Signal.update(activeIndex, i => mod(i + 1, max(len, 1)))
        if !Signal.peek(isOpen) {
          Signal.set(isOpen, true)
        }
      }
    | "ArrowUp" => {
        let _ = Basefn__Dom.preventDefault(evt)
        Signal.update(activeIndex, i => mod(i - 1 + max(len, 1), max(len, 1)))
      }
    | "Enter" =>
      if Signal.peek(isOpen) && len > 0 {
        let _ = Basefn__Dom.preventDefault(evt)
        let idx = Signal.peek(activeIndex)
        switch items->Array.get(idx) {
        | Some(opt) => handleSelect(opt)
        | None => ()
        }
      }
    | "Escape" => {
        Signal.set(isOpen, false)
        Signal.set(activeIndex, 0)
      }
    | _ => ()
    }
  }

  let handleFocus = _ => {
    Signal.set(isOpen, true)
  }

  let handleBackdropClick = _ => {
    Signal.set(isOpen, false)
  }

  // Sync display text when value changes externally
  let _ = Effect.run(() => {
    let v = Signal.get(value)
    let current = Signal.peek(query)
    // Only sync if query is empty or matches a different option
    if current === "" {
      switch options->Array.find(opt => opt.value === v) {
      | Some(opt) => Signal.set(query, opt.label)
      | None => ()
      }
    }
    None
  })

  let dropdownContent = Computed.make(() => {
    if Signal.get(isOpen) {
      let items = Signal.get(filteredOptions)
      let idx = Signal.get(activeIndex)
      [
        <div class="basefn-combobox__backdrop" onClick={handleBackdropClick} />,
        <div class="basefn-combobox__dropdown" role="listbox">
          {if Array.length(items) === 0 {
            <div class="basefn-combobox__empty"> {Component.text(emptyMessage)} </div>
          } else {
            items
            ->Array.mapWithIndex((opt, i) => {
              let isActive = i === idx
              let isSelected = opt.value === Signal.get(value)
              let className =
                "basefn-combobox__option" ++
                (isActive ? " basefn-combobox__option--active" : "") ++
                (isSelected ? " basefn-combobox__option--selected" : "")
              <div
                key={opt.value}
                class={className}
                onClick={_ => handleSelect(opt)}
                role="option"
              >
                {Component.text(opt.label)}
                {isSelected
                  ? <span class="basefn-combobox__check">
                      {Basefn__Icon.make({name: Check, size: Sm})}
                    </span>
                  : <> </>}
              </div>
            })
            ->Component.fragment
          }}
        </div>,
      ]
    } else {
      []
    }
  })

  <div class="basefn-combobox">
    <div class="basefn-combobox__input-wrapper">
      {Basefn__Icon.make({name: Search, size: Sm})}
      <input
        class="basefn-combobox__input"
        type_="text"
        placeholder
        value={ReactiveProp.reactive(query)}
        disabled
        onInput={handleInput}
        onFocus={handleFocus}
        onKeyDown={handleKeyDown}
      />
      {Component.signalFragment(
        Computed.make(() => {
          if Signal.get(query) !== "" {
            [
              <button
                class="basefn-combobox__clear"
                onClick={_ => {
                  Signal.set(query, "")
                  Signal.set(value, "")
                  Signal.set(isOpen, true)
                  switch onChange {
                  | Some(cb) => cb("")
                  | None => ()
                  }
                }}
              >
                {Basefn__Icon.make({name: X, size: Sm})}
              </button>,
            ]
          } else {
            []
          }
        }),
      )}
    </div>
    {Component.signalFragment(dropdownContent)}
  </div>
}

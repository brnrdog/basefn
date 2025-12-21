%%raw(`import './Eita__Accordion.css'`)

open Xote

type accordionItem = {
  value: string,
  title: string,
  content: Component.node,
  disabled: option<bool>,
}

@jsx.component
let make = (
  ~items: array<accordionItem>,
  ~defaultOpen: option<array<string>>=?,
  ~multiple: bool=false,
) => {
  let openItems = Signal.make(defaultOpen->Option.getOr([]))

  let isOpen = (value: string) => {
    Signal.get(openItems)->Array.includes(value)
  }

  let toggleItem = (value: string, disabled: option<bool>) => {
    switch disabled {
    | Some(true) => ()
    | _ =>
      Signal.update(openItems, current => {
        if current->Array.includes(value) {
          // Close item
          current->Array.filter(item => item != value)
        } else {
          // Open item
          if multiple {
            current->Array.concat([value])
          } else {
            [value]
          }
        }
      })
    }
  }

  <div class="eita-accordion">
    {items
    ->Array.map(item => {
      let itemIsOpen = Computed.make(() => isOpen(item.value))

      <div key={item.value} class="eita-accordion__item">
        <button
          class="eita-accordion__trigger"
          onClick={_ => toggleItem(item.value, item.disabled)}
          disabled={item.disabled->Option.getOr(false)}
        >
          <span> {Component.text(item.title)} </span>
          <span
            class={Computed.make(() => {
              let baseClass = "eita-accordion__icon"
              let openClass = Signal.get(itemIsOpen) ? " eita-accordion__icon--open" : ""
              baseClass ++ openClass
            })}
          >
            {Component.text("\u25bc")}
          </span>
        </button>
        <div
          class={Computed.make(() => {
            let baseClass = "eita-accordion__content"
            let stateClass = Signal.get(itemIsOpen)
              ? " eita-accordion__content--expanded"
              : " eita-accordion__content--collapsed"
            baseClass ++ stateClass
          })}
        >
          <div class="eita-accordion__content-inner"> {item.content} </div>
        </div>
      </div>
    })
    ->Component.fragment}
  </div>
}

%%raw(`import './Basefn__Accordion.css'`)

module Signal = Xote.Signal
module Computed = Xote.Computed
module Node = Xote.Node

type accordionItem = {
  value: string,
  title: string,
  content: Node.node,
  disabled?: bool,
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
        } // Open item
        else if multiple {
          current->Array.concat([value])
        } else {
          [value]
        }
      })
    }
  }

  <div class="basefn-accordion">
    {items
    ->Array.map(item => {
      let itemIsOpen = Computed.make(() => isOpen(item.value))

      <div key={item.value} class="basefn-accordion__item">
        <button
          class="basefn-accordion__trigger"
          onClick={_ => toggleItem(item.value, item.disabled)}
          disabled={item.disabled->Option.getOr(false)}
        >
          <span> {Node.text(item.title)} </span>
          <span
            class={Computed.make(() => {
              let baseClass = "basefn-accordion__icon"
              let openClass = Signal.get(itemIsOpen) ? " basefn-accordion__icon--open" : ""
              baseClass ++ openClass
            })}
          >
            {Node.text("\u25bc")}
          </span>
        </button>
        <div
          class={Computed.make(() => {
            let baseClass = "basefn-accordion__content"
            let stateClass = Signal.get(itemIsOpen)
              ? " basefn-accordion__content--expanded"
              : " basefn-accordion__content--collapsed"
            baseClass ++ stateClass
          })}
        >
          <div class="basefn-accordion__content-inner"> {item.content} </div>
        </div>
      </div>
    })
    ->Node.fragment}
  </div>
}

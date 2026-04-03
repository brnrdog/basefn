%%raw(`import './Basefn__Collapsible.css'`)

open Xote

@jsx.component
let make = (
  ~isOpen: Signal.t<bool>,
  ~onOpenChange: option<bool => unit>=?,
  ~children: Component.node,
) => {
  let toggle = () => {
    Signal.update(isOpen, prev => {
      let next = !prev
      switch onOpenChange {
      | Some(cb) => cb(next)
      | None => ()
      }
      next
    })
  }

  {children}
}

module Trigger = {
  @jsx.component
  let make = (~isOpen: Signal.t<bool>, ~onToggle: unit => unit, ~children: Component.node) => {
    <div class="basefn-collapsible__trigger" onClick={_ => onToggle()}>
      {children}
      <span class="basefn-collapsible__indicator">
        {Component.signalFragment(
          Computed.make(() => {
            if Signal.get(isOpen) {
              [Basefn__Icon.make({name: ChevronUp, size: Sm})]
            } else {
              [Basefn__Icon.make({name: ChevronDown, size: Sm})]
            }
          }),
        )}
      </span>
    </div>
  }
}

module Content = {
  @jsx.component
  let make = (~isOpen: Signal.t<bool>, ~children: Component.node) => {
    let contentClass = Computed.make(() => {
      "basefn-collapsible__content" ++
      (Signal.get(isOpen) ? " basefn-collapsible__content--open" : "")
    })

    <div class={contentClass}> {children} </div>
  }
}

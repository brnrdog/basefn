%%raw(`import './Eita__Button.css'`)

open Xote

type variant = Primary | Secondary | Ghost

let variantToString = (variant: variant) => {
  switch variant {
  | Primary => "primary"
  | Secondary => "secondary"
  | Ghost => "ghost"
  }
}

@jsx.component
let make = (
  ~label: Signal.t<string>,
  ~onClick: option<Dom.event => unit>=?,
  ~variant: variant=Primary,
  ~disabled: bool=false,
) => {
  let getClassName = () => {
    let variantClass = "eita-button--" ++ variantToString(variant)
    "eita-button " ++ variantClass
  }

  <button
    class={getClassName()}
    disabled
    ?onClick>
    {Component.SignalText(label)}
  </button>
}

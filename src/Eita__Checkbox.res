%%raw(`import './Eita__Checkbox.css'`)

open Xote

@jsx.component
let make = (
  ~checked: Signal.t<bool>,
  ~onChange: option<Dom.event => unit>=?,
  ~label: string,
  ~disabled: bool=false,
) => {
  let getWrapperClassName = () => {
    let base = "eita-checkbox-wrapper"
    if disabled {
      base ++ " eita-checkbox-wrapper--disabled"
    } else {
      base
    }
  }

  <label class={getWrapperClassName()}>
    <input type_="checkbox" class="eita-checkbox-input" checked={checked} disabled ?onChange />
    <span class="eita-checkbox-label"> {Component.text(label)} </span>
  </label>
}

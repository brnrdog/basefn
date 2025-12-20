%%raw(`import './Eita__Radio.css'`)

open Xote

@jsx.component
let make = (
  ~checked: Signal.t<bool>,
  ~onChange: option<Dom.event => unit>=?,
  ~value: string,
  ~label: string,
  ~disabled: bool=false,
  ~name: string,
) => {
  let getWrapperClassName = () => {
    let base = "eita-radio-wrapper"
    if disabled {
      base ++ " eita-radio-wrapper--disabled"
    } else {
      base
    }
  }

  <label class={getWrapperClassName()}>
    <input
      type_="radio"
      class="eita-radio-input"
      name
      value
      checked={checked}
      disabled={disabled}
      ?onChange
    />
    <span class="eita-radio-label"> {Component.text(label)} </span>
  </label>
}

%%raw(`import './Eita__Select.css'`)

open Xote

type selectOption = {
  value: string,
  label: string,
}

@jsx.component
let make = (
  ~value: Signal.t<string>,
  ~onChange: option<Dom.event => unit>=?,
  ~options: Signal.t<array<selectOption>>,
  ~disabled: bool=false,
) => {
  <select name="test" class="eita-select" value={value} disabled ?onChange>
    {Component.list(options, opt =>
      <option value={opt.value}> {Component.text(opt.label)} </option>
    )}
  </select>
}

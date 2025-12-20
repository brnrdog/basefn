%%raw(`import './Eita__Textarea.css'`)

open Xote

@jsx.component
let make = (
  ~value: Signal.t<string>,
  ~onInput: option<Dom.event => unit>=?,
  ~placeholder: string="",
  ~disabled: bool=false,
) => {
  <textarea class="eita-textarea" placeholder value={value} disabled ?onInput />
}

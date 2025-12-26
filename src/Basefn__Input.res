open Xote

%%raw(`import './Basefn__Input.css'`)

type inputType = Text | Email | Password | Number | Tel | Url | Search | Date | Time

let inputTypeToString = (type_: inputType) => {
  switch type_ {
  | Text => "text"
  | Email => "email"
  | Password => "password"
  | Number => "number"
  | Tel => "tel"
  | Url => "url"
  | Search => "search"
  | Date => "date"
  | Time => "time"
  }
}

@jsx.component
let make = (
  ~value: Signal.t<string>,
  ~onInput: option<Dom.event => unit>=?,
  ~type_: inputType=Text,
  ~placeholder: string="",
  ~disabled: bool=false,
  ~name=?,
) => {
  <input
    class="basefn-input"
    type_={inputTypeToString(type_)}
    placeholder
    value={value}
    disabled={false}
    name
    ?onInput
  />
}

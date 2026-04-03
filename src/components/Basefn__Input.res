open Xote

%%raw(`import './Basefn__Input.css'`)

type inputType = Text | Email | Password | Number | Tel | Url | Search | Date | Time

type inputSize = Sm | Md | Lg

type radius = Full | Md

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

let sizeToString = (size: inputSize) => {
  switch size {
  | Sm => "sm"
  | Md => "md"
  | Lg => "lg"
  }
}

@jsx.component
let make = (
  ~value: ReactiveProp.t<string>,
  ~onInput: option<Dom.event => unit>=?,
  ~type_: inputType=Text,
  ~placeholder: string="",
  ~disabled=ReactiveProp.static(false),
  ~readOnly: bool=false,
  ~size: inputSize=Md,
  ~radius: radius=Md,
  ~error: bool=false,
  ~name=?,
  ~style=?,
) => {
  let class = {
    let sizeClass = " basefn-input--" ++ sizeToString(size)
    let radiusClass = switch radius {
    | Full => " basefn-input--radius-full"
    | _ => ""
    }
    let errorClass = error ? " basefn-input--error" : ""
    "basefn-input" ++ sizeClass ++ radiusClass ++ errorClass
  }
  <input
    class ?style type_={inputTypeToString(type_)} placeholder value={value} disabled readOnly name
    ?onInput
  />
}

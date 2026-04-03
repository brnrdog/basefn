%%raw(`import './Basefn__Textarea.css'`)

open Xote

@jsx.component
let make = (
  ~value: ReactiveProp.t<string>,
  ~onInput: option<Dom.event => unit>=?,
  ~placeholder: string="",
  ~disabled: bool=false,
  ~readOnly: bool=false,
  ~rows: int=3,
  ~maxLength: option<int>=?,
  ~error: bool=false,
) => {
  let onInput = (e: Dom.event) => {
    let t = Basefn__Dom.target(e)
    let v = t["value"]

    switch value {
    | Reactive(signal) => Signal.set(signal, v)
    | _ => ()
    }

    switch onInput {
    | Some(cb) => cb(e)
    | None => ()
    }
  }

  let class = {
    "basefn-textarea" ++ (error ? " basefn-textarea--error" : "")
  }

  <textarea class placeholder value disabled readOnly rows ?maxLength onInput />
}

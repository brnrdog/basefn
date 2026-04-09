%%raw(`import './Basefn__Select.css'`)

open Xote

type selectOption = {
  value: string,
  label: string,
}

type size = Sm | Md | Lg

let sizeToString = (size: size) => {
  switch size {
  | Sm => "sm"
  | Md => "md"
  | Lg => "lg"
  }
}

@jsx.component
let make = (
  ~value: Signal.t<string>,
  ~onChange: option<Dom.event => unit>=?,
  ~options: Signal.t<array<selectOption>>,
  ~disabled: bool=false,
  ~name: option<string>=?,
  ~placeholder: option<string>=?,
  ~size: size=Md,
) => {
  let onChange = (e: Dom.event) => {
    let t = Obj.magic(e)["target"]
    let v = t["value"]

    Signal.set(value, v)

    switch onChange {
    | Some(onChange) => onChange(v)
    | None => ()
    }
  }

  let class = {
    let sizeClass = " basefn-select--" ++ sizeToString(size)
    "basefn-select" ++ sizeClass
  }

  <select ?name class value={value} disabled onChange>
    {switch placeholder {
    | Some(text) => <option value="" disabled={true}> {Component.text(text)} </option>
    | None => <empty />
    }}
    {Component.list(options, opt =>
      <option value={opt.value}> {Component.text(opt.label)} </option>
    )}
  </select>
}

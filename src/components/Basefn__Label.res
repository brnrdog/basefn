%%raw(`import './Basefn__Label.css'`)

open Xote

@jsx.component
let make = (~text: string, ~required: bool=false, ~htmlFor: option<string>=?) => {
  let getClassName = () => {
    let base = "basefn-label"
    if required {
      base ++ " basefn-label--required"
    } else {
      base
    }
  }

  let attrs = [Component.attr("class", getClassName())]
  let attrs = switch htmlFor {
  | Some(id) => Array.concat(attrs, [Component.attr("for", id)])
  | None => attrs
  }

  Component.element(
    "label",
    ~attrs,
    ~children=[Component.text(text)],
    (),
  )
}

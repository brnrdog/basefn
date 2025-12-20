%%raw(`import './Eita__Typography.css'`)

open Xote

type variant = H1 | H2 | H3 | H4 | H5 | H6 | P | Small | Lead | Muted | Code

type align = Left | Center | Right | Justify

let variantToTag = (variant: variant) => {
  switch variant {
  | H1 => "h1"
  | H2 => "h2"
  | H3 => "h3"
  | H4 => "h4"
  | H5 => "h5"
  | H6 => "h6"
  | P => "p"
  | Small => "small"
  | Lead => "p"
  | Muted => "p"
  | Code => "code"
  }
}

let variantToClass = (variant: variant) => {
  switch variant {
  | H1 => "eita-typography--h1"
  | H2 => "eita-typography--h2"
  | H3 => "eita-typography--h3"
  | H4 => "eita-typography--h4"
  | H5 => "eita-typography--h5"
  | H6 => "eita-typography--h6"
  | P => "eita-typography--p"
  | Small => "eita-typography--small"
  | Lead => "eita-typography--lead"
  | Muted => "eita-typography--muted"
  | Code => "eita-typography--code"
  }
}

let alignToString = (align: align) => {
  switch align {
  | Left => "left"
  | Center => "center"
  | Right => "right"
  | Justify => "justify"
  }
}

@jsx.component
let make = (
  ~text: Signal.t<string>,
  ~variant: variant=P,
  ~align: option<align>=?,
  ~className: string="",
) => {
  let variantClass = variantToClass(variant)

  let getClassName = () => {
    let baseClass = "eita-typography " ++ variantClass
    let alignClass = switch align {
    | Some(a) => " eita-typography--" ++ alignToString(a)
    | None => ""
    }
    let customClass = if className !== "" { " " ++ className } else { "" }
    baseClass ++ alignClass ++ customClass
  }

  switch variant {
  | H1 => <h1 class={getClassName()}>{Component.SignalText(text)}</h1>
  | H2 => <h2 class={getClassName()}>{Component.SignalText(text)}</h2>
  | H3 => <h3 class={getClassName()}>{Component.SignalText(text)}</h3>
  | H4 => <h4 class={getClassName()}>{Component.SignalText(text)}</h4>
  | H5 => <h5 class={getClassName()}>{Component.SignalText(text)}</h5>
  | H6 => <h6 class={getClassName()}>{Component.SignalText(text)}</h6>
  | P => <p class={getClassName()}>{Component.SignalText(text)}</p>
  | Small => <small class={getClassName()}>{Component.SignalText(text)}</small>
  | Lead => <p class={getClassName()}>{Component.SignalText(text)}</p>
  | Muted => <p class={getClassName()}>{Component.SignalText(text)}</p>
  | Code => <code class={getClassName()}>{Component.SignalText(text)}</code>
  }
}

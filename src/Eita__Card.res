%%raw(`import './Eita__Card.css'`)

open Xote

type variant = Default | Outlined | Elevated

let variantToString = (variant: variant) => {
  switch variant {
  | Default => "default"
  | Outlined => "outlined"
  | Elevated => "elevated"
  }
}

@jsx.component
let make = (
  ~children: Xote__JSX.element,
  ~variant: variant=Default,
  ~header: option<string>=?,
  ~footer: option<string>=?,
  ~style: string="",
  ~className: string="",
) => {
  let getClassName = () => {
    let variantClass = "eita-card--" ++ variantToString(variant)
    let customClass = if className !== "" {
      " " ++ className
    } else {
      ""
    }
    "eita-card " ++ variantClass ++ customClass
  }

  <div class={getClassName()} style>
    {switch header {
    | Some(text) => <div class="eita-card__header"> {Component.text(text)} </div>
    | None => <empty />
    }}
    <div class="eita-card__body"> {children} </div>
    {switch footer {
    | Some(text) => <div class="eita-card__footer"> {Component.text(text)} </div>
    | None => <empty />
    }}
  </div>
}

%%raw(`import './Basefn__Card.css'`)

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
  ~padding: bool=true,
) => {
  let getClassName = () => {
    let variantClass = "basefn-card--" ++ variantToString(variant)
    let paddingClass = if !padding {
      " basefn-card--no-padding"
    } else {
      ""
    }
    let customClass = if className !== "" {
      " " ++ className
    } else {
      ""
    }
    "basefn-card " ++ variantClass ++ paddingClass ++ customClass
  }

  <div class={getClassName()} style>
    {switch header {
    | Some(text) => <div class="basefn-card__header"> {Component.text(text)} </div>
    | None => <empty />
    }}
    <div class="basefn-card__body"> {children} </div>
    {switch footer {
    | Some(text) => <div class="basefn-card__footer"> {Component.text(text)} </div>
    | None => <empty />
    }}
  </div>
}

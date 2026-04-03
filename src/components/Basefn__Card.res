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
  ~header: option<Component.node>=?,
  ~footer: option<Component.node>=?,
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
    | Some(content) => <div class="basefn-card__header"> {content} </div>
    | None => <empty />
    }}
    <div class="basefn-card__body"> {children} </div>
    {switch footer {
    | Some(content) => <div class="basefn-card__footer"> {content} </div>
    | None => <empty />
    }}
  </div>
}

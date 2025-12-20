%%raw(`import './Eita__Spinner.css'`)

open Xote

type size = Sm | Md | Lg | Xl

type variant = Default | Primary | Secondary

let sizeToString = (size: size) => {
  switch size {
  | Sm => "sm"
  | Md => "md"
  | Lg => "lg"
  | Xl => "xl"
  }
}

let variantToString = (variant: variant) => {
  switch variant {
  | Default => "default"
  | Primary => "primary"
  | Secondary => "secondary"
  }
}

@jsx.component
let make = (
  ~size: size=Md,
  ~variant: variant=Default,
  ~label: string="",
) => {
  let getClassName = () => {
    let sizeClass = "eita-spinner--" ++ sizeToString(size)
    let variantClass = "eita-spinner--" ++ variantToString(variant)
    "eita-spinner " ++ sizeClass ++ " " ++ variantClass
  }

  let showLabel = label !== ""

  <div class="eita-spinner-container">
    <div class={getClassName()} role="status" ariaLabel="Loading" />
    {if showLabel {
      <span class="eita-spinner__label">{Component.text(label)}</span>
    } else {
      <empty />
    }}
  </div>
}

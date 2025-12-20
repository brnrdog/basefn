%%raw(`import './Eita__Separator.css'`)

open Xote

type orientation = Horizontal | Vertical

type variant = Solid | Dashed | Dotted

let orientationToString = (orientation: orientation) => {
  switch orientation {
  | Horizontal => "horizontal"
  | Vertical => "vertical"
  }
}

let variantToString = (variant: variant) => {
  switch variant {
  | Solid => "solid"
  | Dashed => "dashed"
  | Dotted => "dotted"
  }
}

@jsx.component
let make = (
  ~orientation: orientation=Horizontal,
  ~variant: variant=Solid,
  ~label: option<string>=?,
) => {
  let getClassName = () => {
    let orientationClass = "eita-separator--" ++ orientationToString(orientation)
    let variantClass = "eita-separator--" ++ variantToString(variant)
    "eita-separator " ++ orientationClass ++ " " ++ variantClass
  }

  switch label {
  | Some(text) =>
    <div class={getClassName() ++ " eita-separator--with-label"}>
      <div class="eita-separator__line" />
      <span class="eita-separator__label"> {Component.text(text)} </span>
      <div class="eita-separator__line" />
    </div>
  | None => <div class={getClassName()} role="separator" />
  }
}

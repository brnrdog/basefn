%%raw(`import './Basefn__Button.css'`)

open Xote

type variant = Primary | Secondary | Ghost

let variantToString = (variant: variant) => {
  switch variant {
  | Primary => "primary"
  | Secondary => "secondary"
  | Ghost => "ghost"
  }
}

type reactive<'a> = Reactive(Signal.t<'a>) | Static('a)

@jsx.component
let make = (
  ~label: option<reactive<string>>=Static(""),
  ~onClick: option<Dom.event => unit>=?,
  ~variant: variant=Primary,
  ~disabled=Signal.make(false),
  ~children: option<Xote__JSX.element>=Xote__JSX.null(),
  ~class=Signal.make(""),
) => {
  let class = Computed.make(() => {
    let variantClass = "basefn-button--" ++ variantToString(variant)
    "basefn-button " ++ variantClass ++ " " ++ class->Signal.get
  })

  <button class disabled ?onClick> {children} </button>
}

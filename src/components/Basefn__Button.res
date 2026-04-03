open Xote

%%raw(`import './Basefn__Button.css'`)

type variant = Primary | Secondary | Ghost

type size = Sm | Md | Lg

let variantToString = (variant: variant) => {
  switch variant {
  | Primary => "primary"
  | Secondary => "secondary"
  | Ghost => "ghost"
  }
}

let sizeToString = (size: size) => {
  switch size {
  | Sm => "sm"
  | Md => "md"
  | Lg => "lg"
  }
}

@jsx.component
let make = (
  ~children=Xote__JSX.null(),
  ~class=ReactiveProp.static(""),
  ~disabled=ReactiveProp.static(false),
  ~label=ReactiveProp.static(""),
  ~loading: ReactiveProp.t<bool>=ReactiveProp.static(false),
  ~onClick=evt => {
    Basefn__Dom.preventDefault(evt)
  },
  ~variant: variant=Primary,
  ~size: size=Md,
  ~type_: string="button",
) => {
  let class = Computed.make(() => {
    let variantClass = "basefn-button--" ++ variantToString(variant)
    let sizeClass = " basefn-button--" ++ sizeToString(size)
    let loadingClass = loading->ReactiveProp.get ? " basefn-button--loading" : ""
    "basefn-button " ++ variantClass ++ sizeClass ++ loadingClass ++ " " ++ class->ReactiveProp.get
  })

  let isDisabled = Computed.make(() => {
    disabled->ReactiveProp.get || loading->ReactiveProp.get
  })

  <button class type_={type_} disabled={isDisabled} onClick>
    {children}
  </button>
}

%%raw(`import './Eita__Drawer.css'`)

open Xote

type position = Left | Right | Top | Bottom

type size = Sm | Md | Lg

let positionToString = (position: position) => {
  switch position {
  | Left => "left"
  | Right => "right"
  | Top => "top"
  | Bottom => "bottom"
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
  ~isOpen: Signal.t<bool>,
  ~onClose: unit => unit,
  ~position: position=Right,
  ~size: size=Md,
  ~title: option<string>=?,
  ~showCloseButton: bool=true,
  ~closeOnBackdrop: bool=true,
  ~children: Component.node,
  ~footer: option<Component.node>=?,
) => {
  let handleBackdropClick = evt => {
    if closeOnBackdrop {
      let target = Obj.magic(evt)["target"]
      let currentTarget = Obj.magic(evt)["currentTarget"]
      if target === currentTarget {
        onClose()
      }
    }
  }

  let getDrawerClass = () => {
    let positionClass = "eita-drawer--" ++ positionToString(position)
    let sizeClass = "eita-drawer--" ++ sizeToString(size)
    "eita-drawer " ++ positionClass ++ " " ++ sizeClass
  }

  let content = Computed.make(() => {
    if Signal.get(isOpen) {
      [
        <>
          <div class="eita-drawer-backdrop" onClick={handleBackdropClick} />
          <div class={getDrawerClass()}>
            {switch title {
            | Some(titleText) =>
              <div class="eita-drawer__header">
                <h2 class="eita-drawer__title"> {Component.text(titleText)} </h2>
                {showCloseButton
                  ? <button class="eita-drawer__close" onClick={_ => onClose()}>
                      {Component.text("\u00d7")}
                    </button>
                  : <> </>}
              </div>
            | None => <> </>
            }}
            <div class="eita-drawer__body"> {children} </div>
            {switch footer {
            | Some(footerContent) => <div class="eita-drawer__footer"> {footerContent} </div>
            | None => <> </>
            }}
          </div>
        </>,
      ]
    } else {
      []
    }
  })

  Component.signalFragment(content)
}

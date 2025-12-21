%%raw(`import './Eita__Switch.css'`)

open Xote

type size = Sm | Md | Lg

let sizeToString = (size: size) => {
  switch size {
  | Sm => "sm"
  | Md => "md"
  | Lg => "lg"
  }
}

@jsx.component
let make = (
  ~checked: Signal.t<bool>,
  ~onChange: option<unit => unit>=?,
  ~label: option<string>=?,
  ~disabled: bool=false,
  ~size: size=Md,
) => {
  let handleClick = _ => {
    if !disabled {
      Signal.update(checked, prev => !prev)
      switch onChange {
      | Some(callback) => callback()
      | None => ()
      }
    }
  }

  let getWrapperClass = () => {
    let baseClass = "eita-switch-wrapper"
    let disabledClass = disabled ? " eita-switch-wrapper--disabled" : ""
    baseClass ++ disabledClass
  }

  let getSwitchClass = () => {
    let baseClass = "eita-switch"
    let sizeClass = size != Md ? " eita-switch--" ++ sizeToString(size) : ""
    let checkedClass = Computed.make(() => Signal.get(checked) ? " eita-switch--checked" : "")
    let disabledClass = disabled ? " eita-switch--disabled" : ""
    baseClass ++ sizeClass ++ disabledClass
  }

  <label class={getWrapperClass()}>
    <div
      class={Computed.make(() =>
        getSwitchClass() ++
        Signal.get(Computed.make(() => Signal.get(checked) ? " eita-switch--checked" : ""))
      )}
      onClick={handleClick}
    >
      <div class="eita-switch__slider" />
    </div>
    {switch label {
    | Some(labelText) => <span class="eita-switch-label"> {Component.text(labelText)} </span>
    | None => <> </>
    }}
  </label>
}

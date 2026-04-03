%%raw(`import './Basefn__Checkbox.css'`)

open Xote

let setIndeterminate: (Dom.element, bool) => unit = %raw(`function(el, v) {
  el.indeterminate = v;
}`)

@jsx.component
let make = (
  ~checked: Signal.t<bool>,
  ~onChange: option<Dom.event => unit>=?,
  ~label: option<string>=?,
  ~disabled: bool=false,
  ~indeterminate: bool=false,
) => {
  let getWrapperClassName = () => {
    let base = "basefn-checkbox-wrapper"
    if disabled {
      base ++ " basefn-checkbox-wrapper--disabled"
    } else {
      base
    }
  }

  let inputClass = {
    "basefn-checkbox-input" ++ (indeterminate ? " basefn-checkbox-input--indeterminate" : "")
  }

  // Set indeterminate property on the DOM element (can't be set via HTML attribute)
  let _ = Effect.run(() => {
    let _ = %raw(`requestAnimationFrame(() => {
      var el = document.querySelector('.basefn-checkbox-input--indeterminate');
      if (el) el.indeterminate = indeterminate;
    })`)
    None
  })

  <label class={getWrapperClassName()}>
    <input type_="checkbox" class={inputClass} checked={checked} disabled ?onChange />
    {switch label {
    | Some(text) => <span class="basefn-checkbox-label"> {Component.text(text)} </span>
    | None => <> </>
    }}
  </label>
}

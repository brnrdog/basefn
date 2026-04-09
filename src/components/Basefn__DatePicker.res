%%raw(`import './Basefn__DatePicker.css'`)

open Xote

type date = Basefn__Calendar.date

@jsx.component
let make = (
  ~value: Signal.t<option<date>>,
  ~onSelect: option<date => unit>=?,
  ~placeholder: string="Pick a date",
  ~disabled: bool=false,
) => {
  let isOpen = Signal.make(false)

  let handleToggle = _ => {
    if !disabled {
      Signal.update(isOpen, prev => !prev)
    }
  }

  let handleSelect = (d: date) => {
    Signal.set(value, Some(d))
    Signal.set(isOpen, false)
    switch onSelect {
    | Some(cb) => cb(d)
    | None => ()
    }
  }

  let handleBackdrop = _ => Signal.set(isOpen, false)

  let displayText = Computed.make(() => {
    switch Signal.get(value) {
    | Some(d) => [Component.text(Basefn__Calendar.dateToString(d))]
    | None => [<span class="basefn-datepicker__placeholder"> {Component.text(placeholder)} </span>]
    }
  })

  let dropdown = Computed.make(() => {
    if Signal.get(isOpen) {
      [
        <div class="basefn-datepicker__backdrop" onClick={handleBackdrop} />,
        <div class="basefn-datepicker__dropdown">
          <Basefn__Calendar selected={value} onSelect={handleSelect} />
        </div>,
      ]
    } else {
      []
    }
  })

  let triggerClass = {
    "basefn-datepicker__trigger" ++ (disabled ? " basefn-datepicker__trigger--disabled" : "")
  }

  <div class="basefn-datepicker">
    <button class={triggerClass} onClick={handleToggle} disabled type_="button">
      {Basefn__Icon.make({name: Basefn__Icon.Search, size: Sm})}
      {Component.signalFragment(displayText)}
    </button>
    {Component.signalFragment(dropdown)}
  </div>
}

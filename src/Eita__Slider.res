%%raw(`import './Eita__Slider.css'`)

open Xote

@jsx.component
let make = (
  ~value: Signal.t<float>,
  ~onChange: option<float => unit>=?,
  ~min: float=0.0,
  ~max: float=100.0,
  ~step: float=1.0,
  ~label: option<string>=?,
  ~showValue: bool=true,
  ~disabled: bool=false,
  ~markers: option<array<string>>=?,
) => {
  let handleInput = evt => {
    let target = Obj.magic(evt)["target"]
    let newValue = Float.fromString(target["value"])->Option.getOr(0.0)
    Signal.set(value, newValue)
    switch onChange {
    | Some(callback) => callback(newValue)
    | None => ()
    }
  }

  <div class="eita-slider">
    <div class="eita-slider__wrapper">
      {switch (label, showValue) {
      | (Some(_), _) | (None, true) =>
        <div class="eita-slider__header">
          {switch label {
          | Some(labelText) => <span class="eita-slider__label"> {Component.text(labelText)} </span>
          | None => <> </>
          }}
          {showValue
            ? <span class="eita-slider__value">
                {Component.textSignal(() => Float.toString(Signal.get(value)))}
              </span>
            : <> </>}
        </div>
      | _ => <> </>
      }}
      <input
        type_="range"
        class="eita-slider__input"
        min={Float.toString(min)}
        max={Float.toString(max)}
        step={Float.toString(step)}
        value={value}
        onInput={handleInput}
        disabled
      />
      {switch markers {
      | Some(markerLabels) =>
        <div class="eita-slider__markers">
          {markerLabels
          ->Array.map(marker => {
            <span class="eita-slider__marker"> {Component.text(marker)} </span>
          })
          ->Component.fragment}
        </div>
      | None => <> </>
      }}
    </div>
  </div>
}

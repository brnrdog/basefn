%%raw(`import './Eita__Tooltip.css'`)

open Xote

type position = Top | Bottom | Left | Right

let positionToString = (position: position) => {
  switch position {
  | Top => "top"
  | Bottom => "bottom"
  | Left => "left"
  | Right => "right"
  }
}

@jsx.component
let make = (~content: string, ~position: position=Top, ~children: Component.node) => {
  let isVisible = Signal.make(false)

  let handleMouseEnter = _ => Signal.set(isVisible, true)
  let handleMouseLeave = _ => Signal.set(isVisible, false)

  let getTooltipClass = () => {
    let posClass = "eita-tooltip--" ++ positionToString(position)
    "eita-tooltip " ++ posClass
  }

  let tooltipContent = Computed.make(() => {
    if Signal.get(isVisible) {
      [<div class={getTooltipClass()}> {Component.text(content)} </div>]
    } else {
      []
    }
  })

  <div class="eita-tooltip-wrapper" onMouseEnter={handleMouseEnter} onMouseLeave={handleMouseLeave}>
    {children}
    {Component.signalFragment(tooltipContent)}
  </div>
}

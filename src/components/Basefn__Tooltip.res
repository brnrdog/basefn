%%raw(`import './Basefn__Tooltip.css'`)

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
let make = (~content: string, ~position: position=Top, ~children: Node.node) => {
  let isVisible = Signal.make(false)

  let handleMouseEnter = _ => Signal.set(isVisible, true)
  let handleMouseLeave = _ => Signal.set(isVisible, false)

  let getTooltipClass = () => {
    let posClass = "basefn-tooltip--" ++ positionToString(position)
    "basefn-tooltip " ++ posClass
  }

  let tooltipContent = Computed.make(() => {
    if Signal.get(isVisible) {
      [<div class={getTooltipClass()}> {Node.text(content)} </div>]
    } else {
      []
    }
  })

  <div
    class="basefn-tooltip-wrapper" onMouseEnter={handleMouseEnter} onMouseLeave={handleMouseLeave}
  >
    {children}
    {Node.signalFragment(tooltipContent)}
  </div>
}

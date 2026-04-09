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
let make = (
  ~content: Component.node,
  ~position: position=Top,
  ~openDelay: int=0,
  ~closeDelay: int=0,
  ~children: Component.node,
) => {
  let isVisible = Signal.make(false)
  let timeoutRef: ref<option<timeoutId>> = ref(None)

  let clearTimer = () => {
    switch timeoutRef.contents {
    | Some(id) => {
        clearTimeout(id)
        timeoutRef := None
      }
    | None => ()
    }
  }

  let handleMouseEnter = _ => {
    clearTimer()
    if openDelay > 0 {
      timeoutRef := Some(setTimeout(() => Signal.set(isVisible, true), openDelay))
    } else {
      Signal.set(isVisible, true)
    }
  }

  let handleMouseLeave = _ => {
    clearTimer()
    if closeDelay > 0 {
      timeoutRef := Some(setTimeout(() => Signal.set(isVisible, false), closeDelay))
    } else {
      Signal.set(isVisible, false)
    }
  }

  let handleFocus = _ => Signal.set(isVisible, true)
  let handleBlur = _ => Signal.set(isVisible, false)

  let getTooltipClass = () => {
    let posClass = "basefn-tooltip--" ++ positionToString(position)
    "basefn-tooltip " ++ posClass
  }

  let tooltipContent = Computed.make(() => {
    if Signal.get(isVisible) {
      [<div class={getTooltipClass()} role="tooltip"> {content} </div>]
    } else {
      []
    }
  })

  <div
    class="basefn-tooltip-wrapper"
    onMouseEnter={handleMouseEnter}
    onMouseLeave={handleMouseLeave}
    onFocus={handleFocus}
    onBlur={handleBlur}
  >
    {children}
    {Component.signalFragment(tooltipContent)}
  </div>
}

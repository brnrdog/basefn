%%raw(`import './Basefn__Resizable.css'`)

open Xote

type direction = Horizontal | Vertical

type panel = {
  content: Node.node,
  defaultSize: float,
  minSize?: float,
  maxSize?: float,
}

let directionToString = (d: direction) =>
  switch d {
  | Horizontal => "horizontal"
  | Vertical => "vertical"
  }

// DOM helpers
let getClientX: Dom.event => float = %raw(`function(e) {
  var t = e.touches ? e.touches[0] : e;
  return t.clientX;
}`)

let getClientY: Dom.event => float = %raw(`function(e) {
  var t = e.touches ? e.touches[0] : e;
  return t.clientY;
}`)

let addDocListener: (string, Dom.event => unit) => unit = %raw(`function(ev, fn) {
  document.addEventListener(ev, fn);
}`)

let removeDocListener: (string, Dom.event => unit) => unit = %raw(`function(ev, fn) {
  document.removeEventListener(ev, fn);
}`)

let disableSelect: unit => unit = %raw(`function() {
  document.body.style.userSelect = "none";
  document.body.style.webkitUserSelect = "none";
}`)

let enableSelect: unit => unit = %raw(`function() {
  document.body.style.userSelect = "";
  document.body.style.webkitUserSelect = "";
}`)

let findClosest: (Dom.element, string) => Nullable.t<Dom.element> = %raw(`function(el, sel) {
  return el.closest(sel);
}`)

let getElementRect: Dom.element => {..} = %raw(`function(el) {
  return el.getBoundingClientRect();
}`)

let getKey: Dom.event => string = %raw(`function(e) { return e.key || "" }`)

let getEventTarget: Dom.event => Dom.element = %raw(`function(e) {
  return e.target;
}`)

let preventDefault: Dom.event => unit = %raw(`function(e) { e.preventDefault() }`)

let genId: unit => string = %raw(`function() {
  return "basefn-resizable-" + Math.random().toString(36).substr(2, 9);
}`)

// Global event delegation: register callbacks by container ID, one document
// listener handles all instances. No timing dependency on DOM rendering.
let registerInstance: (string, (int, Dom.event) => unit) => unit = %raw(`function(id, cb) {
  if (!window.__basefn_resizable) {
    window.__basefn_resizable = {};

    function handler(e) {
      var target = e.target;
      if (!target || !target.closest) return;
      var handle = target.closest(".basefn-resizable__handle");
      if (!handle) return;
      var container = handle.closest(".basefn-resizable");
      if (!container || !container.id) return;
      var entry = window.__basefn_resizable[container.id];
      if (!entry) return;
      // Find the handle index among direct children of the container
      var children = container.children;
      var handleIndex = 0;
      for (var i = 0; i < children.length; i++) {
        if (children[i].classList.contains("basefn-resizable__handle")) {
          if (children[i] === handle) {
            entry(handleIndex, e);
            return;
          }
          handleIndex++;
        }
      }
    }

    document.addEventListener("mousedown", handler);
    document.addEventListener("touchstart", handler, { passive: false });
  }

  window.__basefn_resizable[id] = cb;
}`)

// Lazily attach mousedown/touchstart directly to a handle element.
// Called from onMouseEnter so the element is guaranteed to exist.
let initHandle: (Dom.element, int, (int, Dom.event) => unit) => unit = %raw(`function(el, idx, cb) {
  if (el._basefnInit) return;
  el._basefnInit = true;
  el.addEventListener("mousedown", function(e) { cb(idx, e); });
  el.addEventListener("touchstart", function(e) { cb(idx, e); }, { passive: false });
}`)

let getCurrentTarget: Dom.event => Dom.element = %raw(`function(e) {
  return e.currentTarget;
}`)

type dragInfo = {
  handleIndex: int,
  startPos: float,
  startSizes: array<float>,
  container: Dom.element,
}

@jsx.component
let make = (
  ~panels: array<panel>,
  ~direction: direction=Horizontal,
  ~withHandle: bool=true,
  ~onResize: option<array<float> => unit>=?,
  ~class: string="",
) => {
  let containerId = genId()
  let sizes = Signal.make(panels->Array.map(p => p.defaultSize))
  let isDragging = Signal.make(false)
  let dragRef: ref<option<dragInfo>> = ref(None)

  let getPos = (evt: Dom.event) =>
    switch direction {
    | Horizontal => getClientX(evt)
    | Vertical => getClientY(evt)
    }

  let getContainerDimension = (container: Dom.element) => {
    let rect = getElementRect(container)
    switch direction {
    | Horizontal => Obj.magic(rect)["width"]
    | Vertical => Obj.magic(rect)["height"]
    }
  }

  let clampSizes = (leftIdx: int, rightIdx: int, newLeft: float, newRight: float) => {
    let lp = panels->Array.getUnsafe(leftIdx)
    let rp = panels->Array.getUnsafe(rightIdx)
    let lMin = lp.minSize->Option.getOr(0.0)
    let lMax = lp.maxSize->Option.getOr(100.0)
    let rMin = rp.minSize->Option.getOr(0.0)
    let rMax = rp.maxSize->Option.getOr(100.0)
    let total = newLeft +. newRight

    if newLeft < lMin {
      (lMin, total -. lMin)
    } else if newLeft > lMax {
      (lMax, total -. lMax)
    } else if newRight < rMin {
      (total -. rMin, rMin)
    } else if newRight > rMax {
      (total -. rMax, rMax)
    } else {
      (newLeft, newRight)
    }
  }

  let applySizes = (newSizes: array<float>) => {
    Signal.set(sizes, newSizes)
    switch onResize {
    | Some(cb) => cb(newSizes)
    | None => ()
    }
  }

  let onMouseMove = (evt: Dom.event) => {
    switch dragRef.contents {
    | None => ()
    | Some(info) =>
      let containerSize = getContainerDimension(info.container)
      if containerSize > 0.0 {
        let delta = getPos(evt) -. info.startPos
        let deltaPercent = delta /. containerSize *. 100.0
        let li = info.handleIndex
        let ri = info.handleIndex + 1
        let origLeft = info.startSizes->Array.getUnsafe(li)
        let origRight = info.startSizes->Array.getUnsafe(ri)
        let (nl, nr) = clampSizes(li, ri, origLeft +. deltaPercent, origRight -. deltaPercent)
        let newSizes = Signal.get(sizes)->Array.copy
        newSizes->Array.setUnsafe(li, nl)
        newSizes->Array.setUnsafe(ri, nr)
        applySizes(newSizes)
      }
    }
  }

  let rec onMouseUp = (_: Dom.event) => {
    dragRef := None
    Signal.set(isDragging, false)
    enableSelect()
    removeDocListener("mousemove", onMouseMove)
    removeDocListener("mouseup", onMouseUp)
    removeDocListener("touchmove", onMouseMove)
    removeDocListener("touchend", onMouseUp)
  }

  let startDrag = (handleIndex: int, evt: Dom.event) => {
    preventDefault(evt)
    let target = getEventTarget(evt)
    let maybeContainer = findClosest(target, ".basefn-resizable")
    switch Nullable.toOption(maybeContainer) {
    | None => ()
    | Some(container) =>
      dragRef := Some({
        handleIndex,
        startPos: getPos(evt),
        startSizes: Signal.get(sizes)->Array.copy,
        container,
      })
      Signal.set(isDragging, true)
      disableSelect()
      addDocListener("mousemove", onMouseMove)
      addDocListener("mouseup", onMouseUp)
      addDocListener("touchmove", onMouseMove)
      addDocListener("touchend", onMouseUp)
    }
  }

  let handleKeyDown = (handleIndex: int, evt: Dom.event) => {
    let key = getKey(evt)
    let step = 1.0
    let li = handleIndex
    let ri = handleIndex + 1
    let currentSizes = Signal.get(sizes)
    let left = currentSizes->Array.getUnsafe(li)
    let right = currentSizes->Array.getUnsafe(ri)

    let delta = switch (direction, key) {
    | (Horizontal, "ArrowLeft") | (Vertical, "ArrowUp") => Some(-.step)
    | (Horizontal, "ArrowRight") | (Vertical, "ArrowDown") => Some(step)
    | _ => None
    }

    switch delta {
    | Some(d) =>
      preventDefault(evt)
      let (nl, nr) = clampSizes(li, ri, left +. d, right -. d)
      let newSizes = currentSizes->Array.copy
      newSizes->Array.setUnsafe(li, nl)
      newSizes->Array.setUnsafe(ri, nr)
      applySizes(newSizes)
    | None => ()
    }
  }

  // Register this instance for global event delegation
  registerInstance(containerId, startDrag)

  let containerClass =
    "basefn-resizable basefn-resizable--" ++
    directionToString(direction) ++
    (class !== "" ? " " ++ class : "")

  let elements: array<Node.node> = []

  panels->Array.forEachWithIndex((panel, index) => {
    let panelStyle = Computed.make(() => {
      let size = Signal.get(sizes)->Array.getUnsafe(index)
      "flex-basis:" ++ Float.toString(size) ++ "%;flex-grow:0;flex-shrink:0"
    })

    let panelClass = Computed.make(() => {
      let base = "basefn-resizable__panel"
      if Signal.get(isDragging) {
        base ++ " basefn-resizable__panel--dragging"
      } else {
        base
      }
    })

    elements->Array.push(
      <div key={"panel-" ++ Int.toString(index)} class={panelClass} style={panelStyle}>
        {panel.content}
      </div>,
    )

    if index < Array.length(panels) - 1 {
      let handleClass =
        "basefn-resizable__handle basefn-resizable__handle--" ++
        directionToString(direction) ++
        (withHandle ? " basefn-resizable__handle--with-grip" : "")

      elements->Array.push(
        <div
          key={"handle-" ++ Int.toString(index)}
          class={handleClass}
          onMouseEnter={evt => {
            let el = getCurrentTarget(evt)
            initHandle(el, index, startDrag)
          }}
          onKeyDown={evt => handleKeyDown(index, evt)}
          role="separator"
          tabIndex={0}
        >
          {withHandle ? <div class="basefn-resizable__handle-grip" /> : <> </>}
        </div>,
      )
    }
  })

  <div id={containerId} class={containerClass}> {elements->Node.fragment} </div>
}

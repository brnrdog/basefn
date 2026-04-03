%%raw(`import './Basefn__Drawer.css'`)

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

let trapFocus: Dom.element => unit = %raw(`function(container) {
  var focusable = container.querySelectorAll(
    'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
  );
  if (focusable.length === 0) return;
  var first = focusable[0];
  var last = focusable[focusable.length - 1];
  first.focus();
  container._basefnTrapHandler = function(e) {
    if (e.key !== 'Tab') return;
    if (e.shiftKey) {
      if (document.activeElement === first) { e.preventDefault(); last.focus(); }
    } else {
      if (document.activeElement === last) { e.preventDefault(); first.focus(); }
    }
  };
  container.addEventListener('keydown', container._basefnTrapHandler);
}`)

let releaseFocus: Dom.element => unit = %raw(`function(container) {
  if (container._basefnTrapHandler) {
    container.removeEventListener('keydown', container._basefnTrapHandler);
    delete container._basefnTrapHandler;
  }
}`)

let saveFocus: unit => unit = %raw(`function() {
  window.__basefnPrevFocus = document.activeElement;
}`)

let restoreFocus: unit => unit = %raw(`function() {
  if (window.__basefnPrevFocus && window.__basefnPrevFocus.focus) {
    window.__basefnPrevFocus.focus();
    window.__basefnPrevFocus = null;
  }
}`)

let queryDrawer: string => Nullable.t<Dom.element> = %raw(`function(sel) {
  return document.querySelector(sel);
}`)

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
    let positionClass = "basefn-drawer--" ++ positionToString(position)
    let sizeClass = "basefn-drawer--" ++ sizeToString(size)
    "basefn-drawer " ++ positionClass ++ " " ++ sizeClass
  }

  // Focus trap: save focus on open, trap inside drawer, restore on close
  let _ = Effect.run(() => {
    if Signal.get(isOpen) {
      saveFocus()
      let _ = %raw(`requestAnimationFrame(() => {
        var el = document.querySelector(".basefn-drawer");
        if (el) trapFocus(el);
      })`)
    } else {
      let el = queryDrawer(".basefn-drawer")
      switch Nullable.toOption(el) {
      | Some(e) => releaseFocus(e)
      | None => ()
      }
      restoreFocus()
    }
    None
  })

  let content = Computed.make(() => {
    if Signal.get(isOpen) {
      [
        <>
          <div class="basefn-drawer-backdrop" onClick={handleBackdropClick} />
          <div class={getDrawerClass()} role="dialog">
            {switch title {
            | Some(titleText) =>
              <div class="basefn-drawer__header">
                <h2 class="basefn-drawer__title"> {Component.text(titleText)} </h2>
                {showCloseButton
                  ? <button class="basefn-drawer__close" onClick={_ => onClose()}>
                      {Component.text("\u00d7")}
                    </button>
                  : <> </>}
              </div>
            | None => <> </>
            }}
            <div class="basefn-drawer__body"> {children} </div>
            {switch footer {
            | Some(footerContent) => <div class="basefn-drawer__footer"> {footerContent} </div>
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

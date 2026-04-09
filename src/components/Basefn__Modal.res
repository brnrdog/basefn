%%raw(`import './Basefn__Modal.css'`)

open Xote

type size = Sm | Md | Lg | Xl

let sizeToString = (size: size) => {
  switch size {
  | Sm => "sm"
  | Md => "md"
  | Lg => "lg"
  | Xl => "xl"
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

let queryModal: string => Nullable.t<Dom.element> = %raw(`function(sel) {
  return document.querySelector(sel);
}`)

@jsx.component
let make = (
  ~isOpen: Signal.t<bool>,
  ~onClose: unit => unit,
  ~title: option<string>=?,
  ~size: size=Md,
  ~closeOnBackdrop: bool=true,
  ~showCloseButton: bool=true,
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

  let getModalClass = () => {
    let sizeClass = "basefn-modal--" ++ sizeToString(size)
    "basefn-modal " ++ sizeClass
  }

  // Focus trap: save focus on open, trap inside modal, restore on close
  let _ = Effect.run(() => {
    if Signal.get(isOpen) {
      saveFocus()
      let _ = %raw(`requestAnimationFrame(() => {
        var el = document.querySelector(".basefn-modal");
        if (el) trapFocus(el);
      })`)
    } else {
      let el = queryModal(".basefn-modal")
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
        <div class="basefn-modal-backdrop" onClick={handleBackdropClick}>
          <div class={getModalClass()} role="dialog">
            {switch title {
            | Some(titleText) =>
              <div class="basefn-modal__header">
                <h2 class="basefn-modal__title"> {Component.text(titleText)} </h2>
                {showCloseButton
                  ? <button class="basefn-modal__close" onClick={_ => onClose()}>
                      {Component.text("\u00d7")}
                    </button>
                  : <> </>}
              </div>
            | None => <> </>
            }}
            <div class="basefn-modal__body"> {children} </div>
            {switch footer {
            | Some(footerContent) => <div class="basefn-modal__footer"> {footerContent} </div>
            | None => <> </>
            }}
          </div>
        </div>,
      ]
    } else {
      []
    }
  })

  Component.signalFragment(content)
}

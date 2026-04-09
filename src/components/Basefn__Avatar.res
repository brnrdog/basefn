%%raw(`import './Basefn__Avatar.css'`)

open Xote

type size = Sm | Md | Lg

let sizeToString = (size: size) => {
  switch size {
  | Sm => "sm"
  | Md => "md"
  | Lg => "lg"
  }
}

let getInitials: string => string = %raw(`function(name) {
  return name.split(' ').map(function(w) { return w[0] || '' }).join('').toUpperCase().slice(0, 2);
}`)

let setupImgError: (Dom.element, unit => unit) => unit = %raw(`function(el, cb) {
  var img = el.querySelector('img');
  if (img) img.onerror = function() { cb() };
}`)

@jsx.component
let make = (~src=?, ~name=?, ~size=Md) => {
  let class = {
    let sizeClass = "basefn-avatar--" ++ sizeToString(size)
    "basefn-avatar " ++ sizeClass
  }

  let showFallback = Signal.make(src === None)

  let content = Computed.make(() => {
    if Signal.get(showFallback) {
      switch name {
      | Some(n) => [
          <span class="basefn-avatar__initials"> {Component.text(getInitials(n))} </span>,
        ]
      | None => [
          <span class="basefn-avatar__initials">
            {Basefn__Icon.make({name: User, size: Sm})}
          </span>,
        ]
      }
    } else {
      switch src {
      | Some(url) => [<img src={url} alt={name} />]
      | None => []
      }
    }
  })

  // Set up error handler after mount
  let _ = Effect.run(() => {
    switch src {
    | Some(_) =>
      let _ = %raw(`requestAnimationFrame(() => {
        var el = document.querySelector('.basefn-avatar img');
        if (el) el.onerror = function() { showFallback.value = true };
      })`)
    | None => ()
    }
    None
  })

  <div class> {Component.signalFragment(content)} </div>
}

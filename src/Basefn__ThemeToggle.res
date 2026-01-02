%%raw(`import './Basefn__ThemeToggle.css'`)

open Xote

@jsx.component
let make = (~size: [#Sm | #Md | #Lg]=#Md) => {
  let theme = Signal.make(Signal.get(Basefn__Theme.currentTheme))

  let handleClick = _ => {
    Basefn__Theme.toggleTheme()
    Signal.set(theme, Signal.get(Basefn__Theme.currentTheme))
  }

  let icon = Computed.make(() => {
    switch Signal.get(theme) {
    | Light => "\u{1F319}" // Moon emoji
    | Dark => "\u{2600}\u{FE0F}" // Sun emoji
    }
  })

  <button onClick={handleClick} class="basefn-theme-toggle" ariaLabel="Toggle theme">
    {Component.text(Signal.get(icon))}
  </button>
}

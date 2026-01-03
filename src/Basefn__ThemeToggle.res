%%raw(`import './Basefn__ThemeToggle.css'`)

open Xote

@jsx.component
let make = (~size: [#Sm | #Md | #Lg]=#Md) => {
  let theme = Signal.make(Signal.get(Basefn__Theme.currentTheme))

  let handleClick = _ => {
    Basefn__Theme.toggleTheme()
    Signal.set(theme, Signal.get(Basefn__Theme.currentTheme))
  }

  let iconName = Computed.make(() => {
    switch Signal.get(theme) {
    | Light => Basefn__Icon.Moon // Show moon in light mode (click to go dark)
    | Dark => Basefn__Icon.Sun // Show sun in dark mode (click to go light)
    }
  })

  let iconSize = switch size {
  | #Sm => Basefn__Icon.Sm
  | #Md => Basefn__Icon.Md
  | #Lg => Basefn__Icon.Lg
  }

  <button onClick={handleClick} class="basefn-theme-toggle" ariaLabel="Toggle theme">
    <Basefn__Icon name={Signal.get(iconName)} size={iconSize} />
  </button>
}

%%raw(`import './Basefn__ThemeToggle.css'`)

open Xote

@jsx.component
let make = (~size: [#Sm | #Md | #Lg]=#Md) => {
  let theme = Signal.make(Signal.get(Basefn__Theme.currentTheme))

  let handleClick = e => {
    Basefn__Dom.preventDefault(e)->ignore
    Basefn__Theme.toggleTheme()
    Signal.set(theme, Signal.get(Basefn__Theme.currentTheme))
  }

  let icon = Computed.make(() => {
    switch Signal.get(theme) {
    | Light => [<Basefn__Icon name={Sun} />]
    | Dark => [<Basefn__Icon name={Moon} />]
    }
  })

  <Basefn__Button variant=Ghost onClick={handleClick}>
    {Component.signalFragment(icon)}
  </Basefn__Button>
}

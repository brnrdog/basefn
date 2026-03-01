open Xote
open Basefn

module ClickHandlerDemo = {
  @jsx.component
  let make = () => {
    open Component
    let count = Signal.make(0)
    let counterText = Computed.make(() => "Count: " ++ Int.toString(Signal.get(count)))
    <div style="display: flex; align-items: center; gap: 1rem;">
      <Button variant={Button.Primary} onClick={_ => Signal.update(count, c => c + 1)}>
        {text("Increment")}
      </Button>
      <Typography text={Reactive(counterText)} variant={Typography.H4} />
    </div>
  }
}

module ReactiveDemo = {
  @jsx.component
  let make = () => {
    open Component
    let fetching = Signal.make(false)
    let onClick = event => {
      let _ = Basefn__Dom.preventDefault(event)
      Signal.set(fetching, true)
      let _ = setTimeout(() => {
        Signal.set(fetching, false)
      }, 1500)
    }

    <div style="display: flex; align-items: center; gap: 1rem;">
      <Button variant={Button.Primary} disabled={ReactiveProp.Reactive(fetching)} onClick>
        {textSignal(() => Signal.get(fetching) ? "Data fetching..." : "Simulate data fetching")}
      </Button>
    </div>
  }
}

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "Variants",
      description: "Different button styles for various use cases.",
      demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
        <Button variant={Button.Primary}> {text("Primary")} </Button>
        <Button variant={Button.Secondary}> {text("Secondary")} </Button>
        <Button variant={Button.Ghost}> {text("Ghost")} </Button>
      </div>,
      code: `<Button variant={Button.Primary}> {text("Primary")} </Button>
<Button variant={Button.Secondary}> {text("Secondary")} </Button>
<Button variant={Button.Ghost}> {text("Ghost")} </Button>`,
    },
    {
      title: "Button with Click Handler",
      description: "Buttons can handle click events.",
      demo: <ClickHandlerDemo />,
      code: `let count = Signal.make(0)
let counterText = Computed.make(() => "Count: " ++ Int.toString(Signal.get(count)))

<Typography text={counterText} variant={Typography.H4} />
<Button
  variant={Button.Primary}
  onClick={_ => Signal.update(count, c => c + 1)}
>
  {text("Increment")}
</Button>
`,
    },
    {
      title: "Reactive button attributes",
      description: "Button attributes can be static or it can react to signals.",
      demo: <ReactiveDemo />,
      code: `let fetching = Signal.make(false)
let disabled = fetching

/* Simulate waiting for data fetching */
let onClick = event => {
  Basefn__Dom.preventDefault(event)
  Signal.set(fetching, true)
  let _ = setTimeout(() => {
    Signal.set(fetching, false)
  }, 1500)
}

<div style="display: flex; align-items: center; gap: 1rem;">
  <Button variant={Button.Primary} disabled onClick>
    {textSignal(() => Signal.get(fetching) ? "Loading data..." : "Load data")}
  </Button>
</div>
`,
    },
  ]
}

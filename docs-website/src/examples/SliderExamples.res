open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Slider",
    description: "Select a value from a range.",
    demo: {
      let value = Signal.make(50.0)
      <Slider value label="Volume" min={0.0} max={100.0} />
    },
    code: `let value = Signal.make(50.0)

<Slider value label="Volume" min={0.0} max={100.0} />`,
  },
  {
    title: "Slider with Markers",
    description: "Slider with labeled markers.",
    demo: {
      let value = Signal.make(2.0)
      <Slider
        value
        label="Quality"
        min={0.0}
        max={4.0}
        step={1.0}
        markers={["Low", "Med", "High", "Max", "Ultra"]}
      />
    },
    code: `let value = Signal.make(2.0)

<Slider value label="Quality" min={0.0} max={4.0} step={1.0} markers={["Low", "Med", "High", "Max", "Ultra"]} />`,
  },
]

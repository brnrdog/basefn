open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Radio Group",
    description: "Select a single option from multiple choices.",
    demo: {
      let selected = Signal.make("option1")
      <div style="display: flex; flex-direction: column; gap: 0.75rem;">
        <Typography text={ReactiveProp.Static("Choose a plan:")} variant={Typography.H6} />
        <Radio
          checked={Computed.make(() => Signal.get(selected) == "option1")}
          value="option1"
          label="Free"
          name="plan"
          onChange={_ => Signal.set(selected, "option1")}
        />
        <Radio
          checked={Computed.make(() => Signal.get(selected) == "option2")}
          value="option2"
          label="Pro"
          name="plan"
          onChange={_ => Signal.set(selected, "option2")}
        />
        <Radio
          checked={Computed.make(() => Signal.get(selected) == "option3")}
          value="option3"
          label="Enterprise"
          name="plan"
          onChange={_ => Signal.set(selected, "option3")}
        />
      </div>
    },
    code: `let selected = Signal.make("option1")

<Radio
  checked={Computed.make(() => Signal.get(selected) == "option1")}
  value="option1"
  label="Free"
  name="plan"
  onChange={_ => Signal.set(selected, "option1")}
/>`,
  },
]

open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Checkbox",
    description: "Toggle options on and off.",
    demo: {
      let checked = Signal.make(false)
      <div style="display: flex; flex-direction: column; gap: 1rem;">
        <Checkbox checked label="Accept terms and conditions" />
        <Checkbox checked={Signal.make(true)} label="Subscribe to newsletter" />
        <Checkbox checked={Signal.make(false)} label="Enable notifications" disabled={true} />
      </div>
    },
    code: `let checked = Signal.make(false)

<Checkbox checked label="Accept terms and conditions" />`,
  },
  {
    title: "Checkbox Group",
    description: "Multiple checkboxes for selecting options.",
    demo: {
      let option1 = Signal.make(true)
      let option2 = Signal.make(false)
      let option3 = Signal.make(true)
      <div style="display: flex; flex-direction: column; gap: 0.75rem;">
        <Typography text={ReactiveProp.Static("Select features:")} variant={Typography.H6} />
        <Checkbox checked={option1} label="Dark mode" />
        <Checkbox checked={option2} label="Email notifications" />
        <Checkbox checked={option3} label="Auto-save" />
      </div>
    },
    code: `let option1 = Signal.make(true)
let option2 = Signal.make(false)

<div>
  <Checkbox checked={option1} label="Dark mode" />
  <Checkbox checked={option2} label="Email notifications" />
</div>`,
  },
  {
    title: "Indeterminate State",
    description: "Use indeterminate for \"select all\" patterns where some but not all items are checked.",
    demo: <div style="display: flex; flex-direction: column; gap: 0.75rem;">
      <Checkbox checked={Signal.make(false)} label="Select all" indeterminate={true} />
      <div style="padding-left: 1.5rem; display: flex; flex-direction: column; gap: 0.5rem;">
        <Checkbox checked={Signal.make(true)} label="Item A" />
        <Checkbox checked={Signal.make(false)} label="Item B" />
        <Checkbox checked={Signal.make(true)} label="Item C" />
      </div>
    </div>,
    code: `<Checkbox
  checked={Signal.make(false)}
  label="Select all"
  indeterminate={true}
/>`,
  },
]

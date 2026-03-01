open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Switch",
    description: "Toggle between on and off states.",
    demo: {
      let isEnabled = Signal.make(false)
      <div style="display: flex; flex-direction: column; gap: 1rem;">
        <Switch checked={isEnabled} label="Enable notifications" />
        <Switch checked={Signal.make(true)} label="Dark mode" />
        <Switch checked={Signal.make(false)} label="Auto-save" disabled={true} />
      </div>
    },
    code: `let isEnabled = Signal.make(false)

<Switch checked={isEnabled} label="Enable notifications" />`,
  },
  {
    title: "Switch Sizes",
    description: "Switches in different sizes.",
    demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
      <Switch checked={Signal.make(true)} label="Small" size={Switch.Sm} />
      <Switch checked={Signal.make(true)} label="Medium" size={Switch.Md} />
      <Switch checked={Signal.make(true)} label="Large" size={Switch.Lg} />
    </div>,
    code: `<Switch checked={Signal.make(true)} label="Medium" size={Switch.Md} />`,
  },
]

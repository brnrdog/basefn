open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Keyboard Shortcuts",
    description: "Display keyboard keys and shortcuts.",
    demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
      <div style="display: flex; gap: 0.5rem; align-items: center;">
        <Typography text={ReactiveProp.Static("Save:")} variant={Typography.P} />
        <Kbd keys={["Ctrl", "S"]->Signal.make} />
      </div>
      <div style="display: flex; gap: 0.5rem; align-items: center;">
        <Typography text={ReactiveProp.Static("Copy:")} variant={Typography.P} />
        <Kbd keys={["Ctrl", "C"]->Signal.make} />
      </div>
      <div style="display: flex; gap: 0.5rem; align-items: center;">
        <Typography text={ReactiveProp.Static("Undo:")} variant={Typography.P} />
        <Kbd keys={["Ctrl", "Z"]->Signal.make} />
      </div>
    </div>,
    code: `<Kbd keys={["Ctrl", "S"]->Signal.make} />
<Kbd keys={["Cmd", "Shift", "P"]->Signal.make} />`,
  },
  {
    title: "Kbd Sizes",
    description: "Different sizes for keyboard shortcuts.",
    demo: <div style="display: flex; gap: 1rem; align-items: center;">
      <Kbd keys={["Esc"]->Signal.make} size={Kbd.Sm} />
      <Kbd keys={["Enter"]->Signal.make} size={Kbd.Md} />
      <Kbd keys={["Tab"]->Signal.make} size={Kbd.Lg} />
    </div>,
    code: `<Kbd keys={["Esc"]->Signal.make} size={Kbd.Sm} />`,
  },
]

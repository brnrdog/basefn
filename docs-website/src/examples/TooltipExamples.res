open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Tooltip Positions",
    description: "Show helpful hints on hover.",
    demo: <div style="display: flex; gap: 2rem; justify-content: center; padding: 3rem;">
      <Tooltip content="Tooltip on top" position={Tooltip.Top}>
        <Button label={Static("Top")} variant={Button.Ghost} />
      </Tooltip>
      <Tooltip content="Tooltip on bottom" position={Tooltip.Bottom}>
        <Button label={Static("Bottom")} variant={Button.Ghost} />
      </Tooltip>
      <Tooltip content="Tooltip on left" position={Tooltip.Left}>
        <Button label={Static("Left")} variant={Button.Ghost} />
      </Tooltip>
      <Tooltip content="Tooltip on right" position={Tooltip.Right}>
        <Button label={Static("Right")} variant={Button.Ghost} />
      </Tooltip>
    </div>,
    code: `<Tooltip content="Helpful hint" position={Tooltip.Top}>
  <Button label={("Hover me")} />
</Tooltip>`,
  },
]

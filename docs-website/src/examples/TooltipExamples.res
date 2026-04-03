open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Tooltip Positions",
    description: "Show helpful hints on hover.",
    demo: <div style="display: flex; gap: 2rem; justify-content: center; padding: 3rem;">
      <Tooltip content={Component.text("Tooltip on top")} position={Tooltip.Top}>
        <Button variant={Button.Ghost}> {Component.text("Top")} </Button>
      </Tooltip>
      <Tooltip content={Component.text("Tooltip on bottom")} position={Tooltip.Bottom}>
        <Button variant={Button.Ghost}> {Component.text("Bottom")} </Button>
      </Tooltip>
      <Tooltip content={Component.text("Tooltip on left")} position={Tooltip.Left}>
        <Button variant={Button.Ghost}> {Component.text("Left")} </Button>
      </Tooltip>
      <Tooltip content={Component.text("Tooltip on right")} position={Tooltip.Right}>
        <Button variant={Button.Ghost}> {Component.text("Right")} </Button>
      </Tooltip>
    </div>,
    code: `<Tooltip content={Component.text("Helpful hint")} position={Tooltip.Top}>
  <Button label={("Hover me")} />
</Tooltip>`,
  },
]

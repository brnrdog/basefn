open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "Drawer Positions",
      description: "Drawers can slide in from any edge of the screen.",
      demo: {
        let isRightOpen = Signal.make(false)
        let isLeftOpen = Signal.make(false)
        <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
          <Button variant={Button.Primary} onClick={_ => Signal.set(isRightOpen, true)}>
            {text("Open Right Drawer")}
          </Button>
          <Button variant={Button.Secondary} onClick={_ => Signal.set(isLeftOpen, true)}>
            {text("Open Left Drawer")}
          </Button>
          <Drawer
            isOpen={isRightOpen}
            onClose={() => Signal.set(isRightOpen, false)}
            position={Drawer.Right}
            title={"Settings"}
          >
            <div style="display: flex; flex-direction: column; gap: 1rem;">
              <Typography text={ReactiveProp.Static("Drawer Content")} variant={Typography.H5} />
              <p> {Component.text("This drawer slides in from the right side.")} </p>
            </div>
          </Drawer>
          <Drawer
            isOpen={isLeftOpen}
            onClose={() => Signal.set(isLeftOpen, false)}
            position={Drawer.Left}
            title={"Navigation"}
          >
            <div style="display: flex; flex-direction: column; gap: 1rem;">
              <Typography text={ReactiveProp.Static("Menu Items")} variant={Typography.H5} />
              <p> {Component.text("This drawer slides in from the left side.")} </p>
            </div>
          </Drawer>
        </div>
      },
      code: `let isOpen = Signal.make(false)

<Button
  label={Signal.make("Open Drawer")}
  onClick={_ => Signal.set(isOpen, true)}
/>

<Drawer
  isOpen={isOpen}
  onClose={() => Signal.set(isOpen, false)}
  position={Drawer.Right}
  title={"Settings"}
>
  <p>{Component.text("Drawer content")}</p>
</Drawer>`,
    },
    {
      title: "Drawer Sizes",
      description: "Control drawer width with size variants.",
      demo: {
        let isSmallOpen = Signal.make(false)
        let isMediumOpen = Signal.make(false)
        let isLargeOpen = Signal.make(false)
        <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
          <Button variant={Button.Ghost} onClick={_ => Signal.set(isSmallOpen, true)}>
            {text("Small")}
          </Button>
          <Button variant={Button.Ghost} onClick={_ => Signal.set(isMediumOpen, true)}>
            {text("Medium")}
          </Button>
          <Button variant={Button.Ghost} onClick={_ => Signal.set(isLargeOpen, true)}>
            {text("Large")}
          </Button>
          <Drawer
            isOpen={isSmallOpen}
            onClose={() => Signal.set(isSmallOpen, false)}
            size={Drawer.Sm}
            title={"Small Drawer"}
          >
            <p> {Component.text("This is a small drawer (240px).")} </p>
          </Drawer>
          <Drawer
            isOpen={isMediumOpen}
            onClose={() => Signal.set(isMediumOpen, false)}
            size={Drawer.Md}
            title={"Medium Drawer"}
          >
            <p> {Component.text("This is a medium drawer (320px).")} </p>
          </Drawer>
          <Drawer
            isOpen={isLargeOpen}
            onClose={() => Signal.set(isLargeOpen, false)}
            size={Drawer.Lg}
            title={"Large Drawer"}
          >
            <p> {Component.text("This is a large drawer (480px).")} </p>
          </Drawer>
        </div>
      },
      code: `<Drawer
  isOpen={isOpen}
  onClose={() => Signal.set(isOpen, false)}
  size={Drawer.Sm}
  title={"Small Drawer"}
>
  <p>{Component.text("Content")}</p>
</Drawer>`,
    },
  ]
}

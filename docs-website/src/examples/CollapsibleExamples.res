open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Collapsible",
    description: "Click the trigger to expand or collapse the content.",
    demo: {
      let isOpen = Signal.make(false)
      let toggle = () => Signal.update(isOpen, prev => !prev)
      <div style="width: 100%;">
        <Collapsible isOpen>
          <Collapsible.Trigger isOpen onToggle={toggle}>
            <Typography
              text={ReactiveProp.Static("Click to expand")}
              variant={Typography.P}
            />
          </Collapsible.Trigger>
          <Collapsible.Content isOpen>
            <div style="padding: 0.75rem 0;">
              <Typography
                text={ReactiveProp.Static(
                  "This content is hidden by default and revealed when the trigger is clicked.",
                )}
                variant={Typography.Muted}
              />
            </div>
          </Collapsible.Content>
        </Collapsible>
      </div>
    },
    code: `let isOpen = Signal.make(false)
let toggle = () =>
  Signal.update(isOpen, prev => !prev)

<Collapsible isOpen>
  <Collapsible.Trigger isOpen onToggle={toggle}>
    <span> {text("Click to expand")} </span>
  </Collapsible.Trigger>
  <Collapsible.Content isOpen>
    <p> {text("Hidden content here.")} </p>
  </Collapsible.Content>
</Collapsible>`,
  },
]

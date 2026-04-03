open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Textarea",
    description: "Multi-line text input for longer content.",
    demo: {
      let value = Signal.make("")
      <div style="max-width: 400px;">
        <Label text="Message" required={true} />
        <Textarea value={Reactive(value)} placeholder="Enter your message..." />
      </div>
    },
    code: `let value = Signal.make("")

<Textarea
  value
  placeholder="Enter your message..."
/>`,
  },
  {
    title: "Controlled Textarea",
    description: "Textarea with character count.",
    demo: {
      let value = Signal.make("")
      let charCount = Computed.make(() => String.length(Signal.get(value)))
      let message = Computed.make(() => Signal.get(charCount)->Int.toString ++ " characters")
      <div style="max-width: 400px; display: flex; flex-direction: column; gap: 0.5rem;">
        <Textarea value={Reactive(value)} placeholder="Write something..." />
        <Typography text={Reactive(message)} variant={Typography.Small} />
      </div>
    },
    code: `let value = Signal.make("")
let charCount = Computed.make(() => String.length(Signal.get(value)))

<div>
  <Textarea value placeholder="Write something..." />
  <Typography text={charCount} variant={Typography.Small} />
</div>`,
  },
  {
    title: "Rows, MaxLength, and ReadOnly",
    description: "Control the textarea height, character limit, and read-only state.",
    demo: <div style="display: flex; flex-direction: column; gap: 1rem; max-width: 400px;">
      <div>
        <Label text="Short note (2 rows, max 100 chars)" />
        <Textarea value={Static("")} placeholder="Brief note..." rows={2} maxLength={100} />
      </div>
      <div>
        <Label text="Read-only content" />
        <Textarea value={Static("This content cannot be edited.")} readOnly={true} />
      </div>
      <div>
        <Label text="Error state" />
        <Textarea value={Static("")} placeholder="Required field..." error={true} />
      </div>
    </div>,
    code: `<Textarea value rows={2} maxLength={100} />
<Textarea value readOnly={true} />
<Textarea value error={true} />`,
  },
]

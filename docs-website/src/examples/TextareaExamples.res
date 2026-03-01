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
]

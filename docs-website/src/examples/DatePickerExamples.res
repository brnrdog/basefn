open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Date Picker",
    description: "An input trigger that opens a calendar popover for date selection.",
    demo: {
      let date = Signal.make(None)
      <DatePicker value={date} placeholder="Pick a date" />
    },
    code: `let date = Signal.make(None)

<DatePicker
  value={date}
  placeholder="Pick a date"
/>`,
  },
]

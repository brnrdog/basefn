open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Basic Calendar",
    description: "A date grid with month navigation and day selection.",
    demo: {
      let selected = Signal.make(None)
      <Calendar selected />
    },
    code: `let selected = Signal.make(None)

<Calendar selected />`,
  },
]

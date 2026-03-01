open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Badge Variants",
    description: "Different badge styles for status indicators.",
    demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center;">
      <Badge label={Signal.make("Default")} variant={Badge.Default} />
      <Badge label={Signal.make("Primary")} variant={Badge.Primary} />
      <Badge label={Signal.make("Success")} variant={Badge.Success} />
      <Badge label={Signal.make("Warning")} variant={Badge.Warning} />
    </div>,
    code: `<Badge label={Signal.make("Default")} variant={Badge.Default} />
<Badge label={Signal.make("Primary")} variant={Badge.Primary} />
<Badge label={Signal.make("Success")} variant={Badge.Success} />
<Badge label={Signal.make("Warning")} variant={Badge.Warning} />`,
  },
  {
    title: "Badge Sizes",
    description: "Badges come in small, medium, and large sizes.",
    demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center;">
      <Badge label={Signal.make("Small")} size={Badge.Sm} variant={Badge.Primary} />
      <Badge label={Signal.make("Medium")} size={Badge.Md} variant={Badge.Primary} />
      <Badge label={Signal.make("Large")} size={Badge.Lg} variant={Badge.Primary} />
    </div>,
    code: `<Badge label={Signal.make("Small")} size={Badge.Sm} variant={Badge.Primary} />
<Badge label={Signal.make("Medium")} size={Badge.Md} variant={Badge.Primary} />
<Badge label={Signal.make("Large")} size={Badge.Lg} variant={Badge.Primary} />`,
  },
]

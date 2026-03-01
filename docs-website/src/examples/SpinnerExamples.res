open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Spinner Sizes",
    description: "Loading indicators in different sizes.",
    demo: <div style="display: flex; gap: 2rem; align-items: center;">
      <Spinner size={Spinner.Sm} />
      <Spinner size={Spinner.Md} />
      <Spinner size={Spinner.Lg} />
      <Spinner size={Spinner.Xl} />
    </div>,
    code: `<Spinner size={Spinner.Sm} />
<Spinner size={Spinner.Md} />
<Spinner size={Spinner.Lg} />`,
  },
  {
    title: "Spinner Variants with Labels",
    description: "Colored spinners with loading messages.",
    demo: <div style="display: flex; flex-direction: column; gap: 1.5rem;">
      <Spinner variant={Spinner.Default} label="Loading..." />
      <Spinner variant={Spinner.Primary} label="Processing..." />
      <Spinner variant={Spinner.Secondary} label="Please wait..." />
    </div>,
    code: `<Spinner variant={Spinner.Primary} label="Loading..." />`,
  },
]

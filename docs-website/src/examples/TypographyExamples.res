open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Typography Variants",
    description: "Different text styles for headings and content.",
    demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
      <Typography text={ReactiveProp.Static("Heading 1")} variant={Typography.H1} />
      <Typography text={ReactiveProp.Static("Heading 2")} variant={Typography.H2} />
      <Typography text={ReactiveProp.Static("Heading 3")} variant={Typography.H3} />
      <Typography text={ReactiveProp.Static("Paragraph text")} variant={Typography.P} />
      <Typography
        text={ReactiveProp.Static("Lead text for introductions")} variant={Typography.Lead}
      />
      <Typography text={ReactiveProp.Static("Small text")} variant={Typography.Small} />
      <Typography text={ReactiveProp.Static("Muted text")} variant={Typography.Muted} />
      <Typography text={ReactiveProp.Static("inline code")} variant={Typography.Code} />
    </div>,
    code: `<Typography text={ReactiveProp.Static("Heading 1")} variant={Typography.H1} />
<Typography text={ReactiveProp.Static("Paragraph text")} variant={Typography.P} />
<Typography text={ReactiveProp.Static("Muted text")} variant={Typography.Muted} />`,
  },
  {
    title: "Text Alignment",
    description: "Control text alignment.",
    demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
      <Typography text={ReactiveProp.Static("Left aligned")} align={Typography.Left} />
      <Typography text={ReactiveProp.Static("Center aligned")} align={Typography.Center} />
      <Typography text={ReactiveProp.Static("Right aligned")} align={Typography.Right} />
    </div>,
    code: `<Typography text={ReactiveProp.Static("Center aligned")} align={Typography.Center} />`,
  },
]

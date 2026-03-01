open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Horizontal Separator",
    description: "Divide content sections horizontally.",
    demo: <div style="display: flex; flex-direction: column;">
      <Typography text={ReactiveProp.Static("Section 1")} variant={Typography.Unstyled} />
      <Separator orientation={Separator.Horizontal} />
      <Typography text={ReactiveProp.Static("Section 2")} variant={Typography.Unstyled} />
    </div>,
    code: `<Separator orientation={Separator.Horizontal} />`,
  },
  {
    title: "Vertical Separator",
    description: "Divide content sections vertically.",
    demo: <div
      style="display: flex; flex-direction: column; align-items: center; gap: 2rem; width: 100%;"
    >
      <div
        style="display: flex; width: 100%; flex-direction: row; height: 2.5rem; gap: 2rem; height: 2.5rem; gap: 2rem;"
      >
        <Typography
          text={ReactiveProp.Static("Solid Separators")}
          variant={Typography.Unstyled}
          style="width: 100px;"
        />
        <Separator orientation={Vertical} variant={Solid} />
        <Typography
          text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
        />
      </div>
      <div style="display: flex; width: 100%; flex-direction: row; height: 2.5rem; gap: 2rem;">
        <Typography
          text={ReactiveProp.Static("Dashed Separators")}
          variant={Typography.Unstyled}
          style="width: 100px;"
        />
        <Separator orientation={Vertical} variant={Dashed} />
        <Typography
          text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
        />
      </div>
      <div style="display: flex; width: 100%; flex-direction: row; height: 2.5rem; gap: 2rem;">
        <Typography
          text={ReactiveProp.Static("Dotted Separators")}
          variant={Typography.Unstyled}
          style="width: 100px;"
        />
        <Separator orientation={Vertical} variant={Dotted} />
        <Typography
          text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
        />
      </div>
    </div>,
    code: `<Separator orientation={Separator.Vertical} />`,
  },
  {
    title: "Horizontal Separators",
    description: "Divides content sections horizontally.",
    demo: <div style="display: flex; align-items: center; gap: 2rem; width: 100%;">
      <div style="display: flex; width: 100%; flex-direction: column;">
        <Typography
          text={ReactiveProp.Static("Solid Separators")} variant={Typography.Unstyled}
        />
        <Separator variant={Solid} />
        <Typography
          text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
        />
      </div>
      <div style="display: flex; width: 100%; flex-direction: column;">
        <Typography
          text={ReactiveProp.Static("Dashed Separators")} variant={Typography.Unstyled}
        />
        <Separator variant={Dashed} />
        <Typography
          text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
        />
      </div>
      <div style="display: flex; width: 100%; flex-direction: column;">
        <Typography
          text={ReactiveProp.Static("Dotted Separators")} variant={Typography.Unstyled}
        />
        <Separator variant={Dotted} />
        <Typography
          text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
        />
      </div>
      <div style="display: flex; width: 100%; flex-direction: column; width: 100%;">
        <Typography
          text={ReactiveProp.Static("Separator with a label")} variant={Typography.Unstyled}
        />
        <Separator variant={Solid} label="With a label" />
        <Typography
          text={ReactiveProp.Static("Content example")} variant={Typography.Unstyled}
        />
      </div>
    </div>,
    code: `<Separator variant={Solid} />
<Separator variant={Dashed} />
<Separator variant={Dotted} />
<Separator variant={Dotted} label="Section name"/>`,
  },
]

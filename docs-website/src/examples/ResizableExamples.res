open Xote
open Basefn

let panelStyle = "display:flex;align-items:center;justify-content:center;height:100%;padding:1rem;"

let examples: array<DocsExample.t> = [
  {
    title: "Horizontal Resizable",
    description: "Resize panels horizontally by dragging the handle between them.",
    demo: <div style="height:200px;border:1px solid var(--basefn-border-primary);border-radius:var(--basefn-radius-lg);overflow:hidden;">
      <Resizable
        direction={Resizable.Horizontal}
        panels=[
          {
            content: <div style={panelStyle ++ "background:var(--basefn-bg-secondary);"}>
              <Typography text={ReactiveProp.Static("Panel A")} variant={Typography.Unstyled} />
            </div>,
            defaultSize: 50.0,
            minSize: 20.0,
          },
          {
            content: <div style={panelStyle}>
              <Typography text={ReactiveProp.Static("Panel B")} variant={Typography.Unstyled} />
            </div>,
            defaultSize: 50.0,
            minSize: 20.0,
          },
        ]
      />
    </div>,
    code: `<Resizable
  direction={Resizable.Horizontal}
  panels=[
    {
      content: <div>Panel A</div>,
      defaultSize: 50.0,
      minSize: 20.0,
    },
    {
      content: <div>Panel B</div>,
      defaultSize: 50.0,
      minSize: 20.0,
    },
  ]
/>`,
  },
  {
    title: "Vertical Resizable",
    description: "Stack panels vertically with a drag handle to resize.",
    demo: <div style="height:300px;border:1px solid var(--basefn-border-primary);border-radius:var(--basefn-radius-lg);overflow:hidden;">
      <Resizable
        direction={Resizable.Vertical}
        panels=[
          {
            content: <div style={panelStyle ++ "background:var(--basefn-bg-secondary);"}>
              <Typography text={ReactiveProp.Static("Top")} variant={Typography.Unstyled} />
            </div>,
            defaultSize: 40.0,
            minSize: 15.0,
          },
          {
            content: <div style={panelStyle}>
              <Typography text={ReactiveProp.Static("Bottom")} variant={Typography.Unstyled} />
            </div>,
            defaultSize: 60.0,
            minSize: 15.0,
          },
        ]
      />
    </div>,
    code: `<Resizable
  direction={Resizable.Vertical}
  panels=[
    {
      content: <div>Top</div>,
      defaultSize: 40.0,
      minSize: 15.0,
    },
    {
      content: <div>Bottom</div>,
      defaultSize: 60.0,
      minSize: 15.0,
    },
  ]
/>`,
  },
  {
    title: "Three Panels",
    description: "Multiple panels with individual size constraints.",
    demo: <div style="height:200px;border:1px solid var(--basefn-border-primary);border-radius:var(--basefn-radius-lg);overflow:hidden;">
      <Resizable
        direction={Resizable.Horizontal}
        panels=[
          {
            content: <div style={panelStyle ++ "background:var(--basefn-bg-secondary);"}>
              <Typography text={ReactiveProp.Static("Sidebar")} variant={Typography.Unstyled} />
            </div>,
            defaultSize: 25.0,
            minSize: 15.0,
            maxSize: 40.0,
          },
          {
            content: <div style={panelStyle}>
              <Typography text={ReactiveProp.Static("Content")} variant={Typography.Unstyled} />
            </div>,
            defaultSize: 50.0,
            minSize: 30.0,
          },
          {
            content: <div style={panelStyle ++ "background:var(--basefn-bg-secondary);"}>
              <Typography text={ReactiveProp.Static("Details")} variant={Typography.Unstyled} />
            </div>,
            defaultSize: 25.0,
            minSize: 15.0,
            maxSize: 40.0,
          },
        ]
      />
    </div>,
    code: `<Resizable
  direction={Resizable.Horizontal}
  panels=[
    {
      content: <div>Sidebar</div>,
      defaultSize: 25.0,
      minSize: 15.0,
      maxSize: 40.0,
    },
    {
      content: <div>Content</div>,
      defaultSize: 50.0,
      minSize: 30.0,
    },
    {
      content: <div>Details</div>,
      defaultSize: 25.0,
      minSize: 15.0,
      maxSize: 40.0,
    },
  ]
/>`,
  },
  {
    title: "Without Handle Grip",
    description: "A minimal look with just a thin divider line instead of the grip indicator.",
    demo: <div style="height:200px;border:1px solid var(--basefn-border-primary);border-radius:var(--basefn-radius-lg);overflow:hidden;">
      <Resizable
        direction={Resizable.Horizontal}
        withHandle={false}
        panels=[
          {
            content: <div style={panelStyle ++ "background:var(--basefn-bg-secondary);"}>
              <Typography text={ReactiveProp.Static("Left")} variant={Typography.Unstyled} />
            </div>,
            defaultSize: 50.0,
            minSize: 20.0,
          },
          {
            content: <div style={panelStyle}>
              <Typography text={ReactiveProp.Static("Right")} variant={Typography.Unstyled} />
            </div>,
            defaultSize: 50.0,
            minSize: 20.0,
          },
        ]
      />
    </div>,
    code: `<Resizable
  direction={Resizable.Horizontal}
  withHandle={false}
  panels=[
    {
      content: <div>Left</div>,
      defaultSize: 50.0,
      minSize: 20.0,
    },
    {
      content: <div>Right</div>,
      defaultSize: 50.0,
      minSize: 20.0,
    },
  ]
/>`,
  },
]

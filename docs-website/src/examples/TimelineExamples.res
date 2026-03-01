open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Vertical Timeline",
    description: "Display events in chronological order.",
    demo: <Timeline
      items={[
        {
          title: "Project Created",
          timestamp: Some("2 hours ago"),
          description: Some("Initial project setup and configuration"),
          variant: Timeline.Success,
          icon: Some("\u2713"),
        },
        {
          title: "First Commit",
          timestamp: Some("1 hour ago"),
          description: Some("Added basic component structure"),
          variant: Timeline.Primary,
          icon: None,
        },
        {
          title: "Deploy to Staging",
          timestamp: Some("30 minutes ago"),
          description: Some("Deployed latest changes to staging environment"),
          variant: Timeline.Warning,
          icon: None,
        },
        {
          title: "Production Release",
          timestamp: Some("Pending"),
          description: Some("Awaiting final approval"),
          variant: Timeline.Default,
          icon: None,
        },
      ]}
      orientation={Timeline.Vertical}
    />,
    code: `<Timeline
  items={[
    {
      title: "Project Created",
      timestamp: Some("2 hours ago"),
      description: Some("Initial setup"),
      variant: Timeline.Success,
      icon: Some("\u2713"),
    },
    {
      title: "First Commit",
      timestamp: Some("1 hour ago"),
      description: Some("Added components"),
      variant: Timeline.Primary,
      icon: None,
    },
  ]}
  orientation={Timeline.Vertical}
/>`,
  },
  {
    title: "Timeline Variants",
    description: "Different color variants for timeline items.",
    demo: <Timeline
      items={[
        {
          title: "Success Event",
          timestamp: None,
          description: Some("Operation completed successfully"),
          variant: Timeline.Success,
          icon: Some("\u2713"),
        },
        {
          title: "Warning Event",
          timestamp: None,
          description: Some("Action requires attention"),
          variant: Timeline.Warning,
          icon: Some("!"),
        },
        {
          title: "Error Event",
          timestamp: None,
          description: Some("An error occurred"),
          variant: Timeline.Error,
          icon: Some("\u00d7"),
        },
      ]}
      orientation={Timeline.Vertical}
    />,
    code: `<Timeline
  items={[
    {
      title: "Success",
      variant: Timeline.Success,
      icon: Some("\u2713"),
    },
    {
      title: "Warning",
      variant: Timeline.Warning,
      icon: Some("!"),
    },
  ]}
/>`,
  },
]

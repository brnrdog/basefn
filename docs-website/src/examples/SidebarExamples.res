open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "Dark Sidebar",
      description: "Navigation sidebar with dark theme.",
      demo: {
        let activePage = Signal.make("dashboard")
        <div
          style="height: 400px; background: #f9fafb; border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;"
        >
          <Sidebar
            logo={<div> {Component.text("MyApp")} </div>}
            sections={[
              {
                title: None,
                items: [
                  {
                    label: "Dashboard",
                    icon: Some("\u{1F4CA}"),
                    active: Signal.get(activePage) == "dashboard",
                    url: "/dashboard",
                  },
                  {
                    label: "Projects",
                    icon: Some("\u{1F4C1}"),
                    active: Signal.get(activePage) == "projects",
                    url: "/projects",
                  },
                ],
              },
              {
                title: Some("Settings"),
                items: [
                  {
                    label: "Profile",
                    icon: Some("\u{1F464}"),
                    active: Signal.get(activePage) == "profile",
                    url: "/profile",
                  },
                  {
                    label: "Preferences",
                    icon: Some("\u2699\uFE0F"),
                    active: Signal.get(activePage) == "preferences",
                    url: "/profile",
                  },
                ],
              },
            ]}
            footer={<div style="font-size: 0.75rem; color: #9ca3af;">
              {Component.text("v1.0.0")}
            </div>}
          />
        </div>
      },
      code: `let activePage = Signal.make("dashboard")

<Sidebar
  logo={Some(<div>{Component.text("MyApp")}</div>)}
  theme={Sidebar.Dark}
  sections={[
    {
      title: None,
      items: [
        {
          label: "Dashboard",
          icon: Some("\u{1F4CA}"),
          active: Signal.get(activePage) == "dashboard",
          onClick: () => Signal.set(activePage, "dashboard"),
        },
      ],
    },
  ]}
/>`,
    },
    {
      title: "Light Sidebar",
      description: "Sidebar with light theme variant.",
      demo: {
        let activePage = Signal.make("home")
        <div
          style="height: 400px; background: #1f2937; border: 1px solid #374151; border-radius: 0.5rem; overflow: hidden;"
        >
          <Sidebar
            logo={<div> {Component.text("Dashboard")} </div>}
            size={Sidebar.Md}
            sections={[
              {
                title: Some("Main"),
                items: [
                  {
                    label: "Home",
                    icon: Some("\u{1F3E0}"),
                    active: Signal.get(activePage) == "home",
                    url: "/profile",
                  },
                  {
                    label: "Analytics",
                    icon: Some("\u{1F4C8}"),
                    active: Signal.get(activePage) == "analytics",
                    url: "/profile",
                  },
                  {
                    label: "Reports",
                    icon: Some("\u{1F4CB}"),
                    active: Signal.get(activePage) == "reports",
                    url: "/profile",
                  },
                ],
              },
            ]}
          />
        </div>
      },
      code: `<Sidebar
  logo={Some(<div>{Component.text("Dashboard")}</div>)}
  theme={Sidebar.Light}
  sections={[
    {
      title: Some("Main"),
      items: [
        {label: "Home", icon: Some("\u{1F3E0}"), active: true, onClick: () => ()},
        {label: "Analytics", icon: Some("\u{1F4C8}"), active: false, onClick: () => ()},
      ],
    },
  ]}
/>`,
    },
  ]
}

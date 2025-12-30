%%raw(`import './DocsLayout.css'`)

open Xote
open Basefn

type componentInfo = DocsRoutes.componentInfo

// Group components by category
let groupByCategory = (components: array<componentInfo>): Dict.t<array<componentInfo>> => {
  let groups = Dict.make()
  components->Array.forEach(comp => {
    let existing = groups->Dict.get(comp.category)->Option.getOr([])
    groups->Dict.set(comp.category, Array.concat(existing, [comp]))
  })
  groups
}

@jsx.component
let make = (~components: array<componentInfo>, ~children: Component.node) => {
  let sidebarCollapsed = Signal.make(false)
  let grouped = groupByCategory(components)
  let categories = ["", "Form", "Foundation", "Display", "Navigation", "Interactive", "Layout"]

  // Compute sidebar sections reactively based on current route
  let sidebarSections = Computed.make(() => {
    let currentPath = Signal.get(Router.location).pathname

    categories->Array.filterMap(category => {
      grouped
      ->Dict.get(category)
      ->Option.map(
        comps => {
          {
            Sidebar.title: Some(category),
            items: comps->Array.map(
              comp => {
                {
                  Sidebar.label: comp.name,
                  icon: None,
                  active: currentPath == comp.path,
                  onClick: () => Router.push(comp.path, ()),
                }
              },
            ),
          }
        },
      )
    })
  })

  <AppLayout
    sidebar={<Sidebar
      logo={Router.link(
        ~to="/",
        ~children=[
          <div style="display: flex; align-items: baseline; gap:0.5rem">
            <div style="display: flex; align-items: center; gap:0rem">
              <Typography text={Signal.make("base")} variant={Typography.Unstyled} />
              <Typography text={Signal.make("fn")} variant={Typography.Unstyled} />
            </div>
            <Typography text={Signal.make("v1.0.0")} variant={Typography.Small} />
          </div>,
        ],
        (),
      )}
      sections={Signal.get(sidebarSections)}
      theme={Sidebar.Dark}
      size={Sidebar.Lg}
      collapsed={Signal.get(sidebarCollapsed)}
    />}
    topbar={<Topbar
      navItems={[
        {
          label: "Getting Started",
          onClick: () => {
            Router.push("/getting-started", ())
            ()
          },
          active: Router.getCurrentLocation().pathname === "/getting-started",
        },
        {
          label: "API Reference",
          onClick: () => {
            Router.push("/api", ())
            ()
          },
          active: Router.getCurrentLocation().pathname === "/api",
        },
        {
          label: "Changelog",
          onClick: () => {
            Router.push("/changelog", ())
            ()
          },
          active: Router.getCurrentLocation().pathname === "/changelog",
        },
      ]}
      rightContent={<div style="display: flex; gap: 0.75rem;">
        <Input type_={Text} value={Static("")} radius=Full placeholder="Search" />
        {Router.link(~to="/", ~children=[Component.text("Home")], ())}
        <a
          href="https://github.com/yourusername/basefn-ui"
          target="_blank"
          style="text-decoration: none; color: inherit;"
        >
          {Component.text("GitHub")}
        </a>
      </div>}
      theme={Topbar.Light}
    />}
    sidebarSize={"lg"}
    sidebarCollapsed={Signal.get(sidebarCollapsed)}
  >
    {children}
  </AppLayout>
}

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
  let categories = ["Form", "Foundation", "Display", "Navigation", "Interactive", "Layout"]

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
      logo={<div>
        <Typography text={Signal.make("basefn")} variant={Typography.H5} />
        <div style="font-size: 0.75rem; margin-top: 0.125rem;">
          {Component.text("Documentation")}
        </div>
      </div>}
      sections={Signal.get(sidebarSections)}
      theme={Sidebar.Dark}
      size={Sidebar.Md}
      collapsed={Signal.get(sidebarCollapsed)}
    />}
    topbar={<Topbar
      onMenuClick={() => Signal.update(sidebarCollapsed, prev => !prev)}
      rightContent={<div style="display: flex; gap: 0.75rem;">
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
    sidebarSize={"md"}
    sidebarCollapsed={Signal.get(sidebarCollapsed)}
  >
    {children}
  </AppLayout>
}

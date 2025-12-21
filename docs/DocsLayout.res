%%raw(`import './DocsLayout.css'`)

open Xote
open Eita

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

  // Get current path for active state
  let currentPath = Computed.make(() => {
    Signal.get(Router.location).pathname
  })

  <AppLayout
    sidebar={<div class="docs-sidebar">
      <div class="docs-sidebar__header">
        <Typography text={Signal.make("eita UI")} variant={Typography.H4} />
        <Typography text={Signal.make("Component Documentation")} variant={Typography.Muted} />
      </div>
      <nav class="docs-sidebar__nav">
        {categories
        ->Array.filterMap(category => {
          grouped
          ->Dict.get(category)
          ->Option.map(comps => {
            <div key={category} class="docs-sidebar__category">
              <div class="docs-sidebar__category-title"> {Component.text(category)} </div>
              <div class="docs-sidebar__category-items">
                {comps
                ->Array.map(
                  comp => {
                    let isActive = Computed.make(
                      () =>
                        Signal.get(currentPath) == comp.path ? " docs-sidebar__item--active" : "",
                    )
                    <div key={comp.name}>
                      {Router.link(
                        ~to=comp.path,
                        ~attrs=[
                          Component.attr("class", "docs-sidebar__item" ++ Signal.get(isActive)),
                        ],
                        ~children=[Component.text(comp.name)],
                        (),
                      )}
                    </div>
                  },
                )
                ->Component.fragment}
              </div>
            </div>
          })
        })
        ->Component.fragment}
      </nav>
    </div>}
    topbar={<Topbar
      logo={Router.link(
        ~to="/",
        ~attrs=[Component.attr("class", "docs-topbar__logo")],
        ~children=[Component.text("eita UI")],
        (),
      )}
      onMenuClick={() => Signal.update(sidebarCollapsed, prev => !prev)}
      rightContent={<div style="display: flex; gap: 0.75rem;">
        {Router.link(~to="/", ~children=[Component.text("Home")], ())}
        <a
          href="https://github.com/yourusername/eita-ui"
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

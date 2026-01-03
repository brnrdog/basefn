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
let make = (~components: array<componentInfo>, ~showSidebar=true, ~children: Component.node) => {
  let sidebarCollapsed = Signal.make(!showSidebar)
  let grouped = groupByCategory(components)
  let categories = [
    "Learn",
    "Form",
    "Foundation",
    "Display",
    "Navigation",
    "Interactive",
    "Layout",
    "Media",
  ]

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
          <div style="display: flex; align-items: center; gap:0.5rem">
            <div style="display: flex; align-items: center; gap:0rem; font-size: 1.25rem;">
              <Typography
                text={ReactiveProp.Static("base")}
                variant={Typography.Unstyled}
                style="font-weight: 600; line-height: 2rem;"
              />
              <Typography
                text={ReactiveProp.Static("fn")}
                variant={Typography.Unstyled}
                style="font-style: italic; font-weight: 800;"
              />
            </div>
            <Typography text={ReactiveProp.Static("v1.0.0")} variant={Typography.Small} />
          </div>,
        ],
        (),
      )}
      sections={Signal.get(sidebarSections)}
      size={Sidebar.Lg}
      collapsed={Signal.get(sidebarCollapsed)}
    />}
    topbar={<Topbar
      leftContent={Signal.get(sidebarCollapsed)
        ? <>
            <div style="display: flex; align-items: center; gap:0rem; font-size: 1.25rem;">
              <Typography
                text={ReactiveProp.Static("base")}
                variant={Typography.Unstyled}
                style="font-weight: 600; line-height: 2rem;"
              />
              <Typography
                text={ReactiveProp.Static("fn")}
                variant={Typography.Unstyled}
                style="font-style: italic; font-weight: 800;"
              />
            </div>
            <Typography text={ReactiveProp.Static("v1.0.0")} variant={Typography.Small} />
          </>
        : Component.null()}
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
      rightContent={<div style="display: flex; align-items: center; gap: 0.75rem;">
        <Input
          type_={Text} value={Static("")} radius=Full placeholder="Search" style="width: 20rem;"
        />
        <ThemeToggle />
        <a
          href="https://github.com/brnrdog/basefn-ui"
          target="_blank"
          style="text-decoration: none; color: inherit;"
        >
          <img width="24px" height="24px" src="https://simpleicons.org/icons/github.svg" />
        </a>
      </div>}
    />}
    sidebarSize={"lg"}
    sidebarCollapsed={Signal.get(sidebarCollapsed)}
  >
    {children}
  </AppLayout>
}

%%raw(`import './DocsLayout.css'`)

open Xote
open Basefn

type componentInfo = DocsRoutes.componentInfo

// ---- External bindings ----
@val @scope("window") external addWindowListener: (string, 'a) => unit = "addEventListener"
@val @scope("window") external removeWindowListener: (string, 'a) => unit = "removeEventListener"
@val @scope("localStorage") external getItem: string => Nullable.t<string> = "getItem"
@val @scope("localStorage") external setItem: (string, string) => unit = "setItem"

// ---- Search state ----
let searchOpen = Signal.make(false)
let openSearch = () => Signal.set(searchOpen, true)
let closeSearch = () => Signal.set(searchOpen, false)

// ---- Scroll state ----
let isScrolled = Signal.make(false)

// ---- Search items ----
type searchItem = {
  title: string,
  path: string,
  section: string,
}

let buildSearchItems = (components: array<componentInfo>): array<searchItem> => {
  let items = [
    {title: "Getting Started", path: "/getting-started", section: "Learn"},
  ]
  let componentItems = components->Array.map(c => {
    {title: c.name, path: c.path, section: c.category}
  })
  Array.concat(items, componentItems)
}

// Group components by category
let groupByCategory = (components: array<componentInfo>): Dict.t<array<componentInfo>> => {
  let groups = Dict.make()
  components->Array.forEach(comp => {
    let existing = groups->Dict.get(comp.category)->Option.getOr([])
    groups->Dict.set(comp.category, Array.concat(existing, [comp]))
  })
  groups
}

// ---- Search Modal ----
module SearchModal = {
  @jsx.component
  let make = (~searchItems: array<searchItem>) => {
    let query = Signal.make("")
    let selectedIndex = Signal.make(0)

    let filteredItems = Computed.make(() => {
      let q = Signal.get(query)->String.toLowerCase
      if q == "" {
        searchItems
      } else {
        searchItems->Array.filter(item =>
          item.title->String.toLowerCase->String.includes(q) ||
            item.section->String.toLowerCase->String.includes(q)
        )
      }
    })

    let handleInput = (_evt: Dom.event) => {
      let value: string = %raw(`_evt.target.value`)
      Signal.set(query, value)
      Signal.set(selectedIndex, 0)
    }

    let navigateToResult = () => {
      let items = Signal.peek(filteredItems)
      let idx = Signal.peek(selectedIndex)
      switch items->Array.get(idx) {
      | Some(item) =>
        Router.push(item.path, ())
        closeSearch()
        Signal.set(query, "")
      | None => ()
      }
    }

    let handleKeyDown = (_evt: Dom.event) => {
      let key: string = %raw(`_evt.key`)
      switch key {
      | "ArrowDown" => {
          let _ = %raw(`_evt.preventDefault()`)
          let items = Signal.peek(filteredItems)
          Signal.update(selectedIndex, i => i < Array.length(items) - 1 ? i + 1 : i)
        }
      | "ArrowUp" => {
          let _ = %raw(`_evt.preventDefault()`)
          Signal.update(selectedIndex, i => i > 0 ? i - 1 : 0)
        }
      | "Enter" => navigateToResult()
      | "Escape" => {
          closeSearch()
          Signal.set(query, "")
        }
      | _ => ()
      }
    }

    Component.signalFragment(
      Computed.make(() => {
        if Signal.get(searchOpen) {
          [
            Component.element(
              "div",
              ~attrs=[Component.attr("class", "search-overlay")],
              ~events=[
                (
                  "click",
                  _evt => {
                    let className: string = %raw(`_evt.target.className || ""`)
                    if className->String.includes("search-overlay") {
                      closeSearch()
                      Signal.set(query, "")
                    }
                  },
                ),
              ],
              ~children=[
                <div class="search-modal">
                  <div class="search-input-wrapper">
                    {Basefn__Icon.make({name: Search, size: Sm})}
                    {Component.input(
                      ~attrs=[
                        Component.attr("class", "search-input"),
                        Component.attr("placeholder", "Search components..."),
                        Component.attr("autofocus", "true"),
                      ],
                      ~events=[("input", handleInput), ("keydown", handleKeyDown)],
                      (),
                    )}
                    <div class="search-trigger-key"> {Component.text("esc")} </div>
                  </div>
                  <div class="search-results">
                    {Component.signalFragment(
                      Computed.make(() => {
                        let items = Signal.get(filteredItems)
                        let idx = Signal.get(selectedIndex)
                        if Array.length(items) == 0 {
                          [
                            <div class="search-empty">
                              {Component.text("No results found.")}
                            </div>,
                          ]
                        } else {
                          let currentSection = ref("")
                          let globalIdx = ref(0)
                          items->Array.flatMap(item => {
                            let nodes = []
                            if currentSection.contents != item.section {
                              currentSection := item.section
                              nodes
                              ->Array.push(
                                <div class="search-group-label">
                                  {Component.text(item.section)}
                                </div>,
                              )
                              ->ignore
                            }
                            let myIdx = globalIdx.contents
                            let isActive = myIdx == idx
                            let cn = "search-result-item" ++ (isActive ? " active" : "")
                            nodes
                            ->Array.push(
                              Component.element(
                                "div",
                                ~attrs=[Component.attr("class", cn)],
                                ~events=[
                                  (
                                    "click",
                                    _ => {
                                      Router.push(item.path, ())
                                      closeSearch()
                                      Signal.set(query, "")
                                    },
                                  ),
                                ],
                                ~children=[
                                  <div class="search-result-title">
                                    {Component.text(item.title)}
                                  </div>,
                                ],
                                (),
                              ),
                            )
                            ->ignore
                            globalIdx := myIdx + 1
                            nodes
                          })
                        }
                      }),
                    )}
                  </div>
                  <div class="search-footer">
                    {Component.text("Use arrow keys to navigate, Enter to select, Esc to close")}
                  </div>
                </div>,
              ],
              (),
            ),
          ]
        } else {
          []
        }
      }),
    )
  }
}

// ---- Header ----
module Header = {
  @jsx.component
  let make = () => {
    // Scroll listener
    let _ = Effect.run(() => {
      let handleScroll = () => {
        let scrollY: float = %raw(`window.scrollY`)
        Signal.set(isScrolled, scrollY > 10.0)
      }
      addWindowListener("scroll", handleScroll)
      Some(() => removeWindowListener("scroll", handleScroll))
    })->ignore

    Component.element(
      "header",
      ~attrs=[
        Component.computedAttr("class", () =>
          Signal.get(isScrolled) ? "site-header scrolled" : "site-header"
        ),
      ],
      ~children=[
        <div class="header-inner">
          <div class="header-left">
            {Router.link(
              ~to="/",
              ~attrs=[Component.attr("class", "header-logo-link")],
              ~children=[
                <span class="logo-text-base"> {Component.text("base")} </span>,
                <span class="logo-text-fn"> {Component.text("fn")} </span>,
              ],
              (),
            )}
            <a
              href="https://www.npmjs.com/package/basefn-ui"
              target="_blank"
              class="header-version"
            >
              {Component.text("v1.10.0")}
            </a>
            <nav class="header-nav">
              {Router.link(
                ~to="/getting-started",
                ~attrs=[Component.attr("class", "header-nav-link")],
                ~children=[Component.text("Getting Started")],
                (),
              )}
              {Router.link(
                ~to="/component/button",
                ~attrs=[Component.attr("class", "header-nav-link")],
                ~children=[Component.text("Components")],
                (),
              )}
            </nav>
          </div>
          <div class="header-right">
            {Component.element(
              "button",
              ~attrs=[Component.attr("class", "search-trigger")],
              ~events=[("click", _ => openSearch())],
              ~children=[
                Basefn__Icon.make({name: Search, size: Sm}),
                <span> {Component.text("Search...")} </span>,
                <div class="search-trigger-keys">
                  <span class="search-trigger-key"> {Component.text("\u2318")} </span>
                  <span class="search-trigger-key"> {Component.text("K")} </span>
                </div>,
              ],
              (),
            )}
            {Component.element(
              "a",
              ~attrs=[
                Component.attr("href", "https://github.com/brnrdog/basefn-ui"),
                Component.attr("target", "_blank"),
                Component.attr("class", "gh-star-btn"),
                Component.attr("title", "Star on GitHub"),
              ],
              ~children=[
                Basefn__Icon.make({name: Star, size: Sm}),
                Component.element(
                  "span",
                  ~attrs=[Component.attr("class", "gh-star-label")],
                  ~children=[Component.text("Star")],
                  (),
                ),
              ],
              (),
            )}
            {Component.element(
              "a",
              ~attrs=[
                Component.attr("href", "https://github.com/brnrdog/basefn-ui"),
                Component.attr("target", "_blank"),
                Component.attr("class", "header-icon-btn"),
                Component.attr("title", "GitHub"),
              ],
              ~children=[Basefn__Icon.make({name: GitHub, size: Sm})],
              (),
            )}
            {Component.element(
              "button",
              ~attrs=[
                Component.attr("class", "header-icon-btn"),
                Component.attr("title", "Toggle theme"),
              ],
              ~events=[("click", _ => Basefn__Theme.toggleTheme())],
              ~children=[<ThemeToggle />],
              (),
            )}
          </div>
        </div>,
      ],
      (),
    )
  }
}

// ---- Sidebar ----
module DocsSidebar = {
  @jsx.component
  let make = (~components: array<componentInfo>) => {
    let grouped = groupByCategory(components)
    let categories = [
      "Learn",
      "Components",
    ]

    <nav class="docs-sidebar">
      {Component.signalFragment(
        Computed.make(() => {
          let currentPath = Signal.get(Router.location()).pathname
          categories->Array.filterMap(category => {
            grouped
            ->Dict.get(category)
            ->Option.map(comps => {
              Component.fragment([
                <div class="sidebar-section">
                  <div class="sidebar-section-title">
                    {Component.text(category)}
                  </div>
                  {comps
                  ->Array.map(comp => {
                    let isActive = currentPath == comp.path
                    let className =
                      "sidebar-link" ++ (isActive ? " active" : "")
                    Router.link(
                      ~to=comp.path,
                      ~attrs=[Component.attr("class", className)],
                      ~children=[Component.text(comp.name)],
                      (),
                    )
                  })
                  ->Component.fragment}
                </div>,
              ])
            })
          })
        }),
      )}
    </nav>
  }
}

// ---- Footer ----
module Footer = {
  @jsx.component
  let make = () => {
    let year = Date.now()->Date.fromTime->Date.getFullYear->Int.toString

    <footer class="site-footer">
      <div class="footer-inner">
        <div class="footer-grid">
          <div class="footer-brand">
            <div class="footer-brand-logo">
              <span class="logo-text-base"> {Component.text("base")} </span>
              <span class="logo-text-fn"> {Component.text("fn")} </span>
            </div>
            <p>
              {Component.text(
                "A modern UI component library for ReScript and Xote with fine-grained reactivity and type safety.",
              )}
            </p>
          </div>
          <div class="footer-col">
            <h4> {Component.text("Docs")} </h4>
            <ul>
              <li>
                {Router.link(
                  ~to="/getting-started",
                  ~children=[Component.text("Getting Started")],
                  (),
                )}
              </li>
              <li>
                {Router.link(
                  ~to="/component/button",
                  ~children=[Component.text("Components")],
                  (),
                )}
              </li>
            </ul>
          </div>
          <div class="footer-col">
            <h4> {Component.text("Community")} </h4>
            <ul>
              <li>
                <a href="https://github.com/brnrdog/basefn-ui" target="_blank">
                  {Component.text("GitHub")}
                </a>
              </li>
              <li>
                <a href="https://www.npmjs.com/package/basefn-ui" target="_blank">
                  {Component.text("npm")}
                </a>
              </li>
            </ul>
          </div>
          <div class="footer-col">
            <h4> {Component.text("Built With")} </h4>
            <ul>
              <li>
                <a href="https://rescript-lang.org/" target="_blank">
                  {Component.text("ReScript")}
                </a>
              </li>
              <li>
                <a href="https://github.com/brnrdog/xote" target="_blank">
                  {Component.text("Xote")}
                </a>
              </li>
              <li>
                <a href="https://github.com/tc39/proposal-signals" target="_blank">
                  {Component.text("TC39 Signals")}
                </a>
              </li>
            </ul>
          </div>
        </div>
        <div class="footer-bottom">
          <div>
            {Component.text(`\u00A9 ${year} basefn. MIT License.`)}
          </div>
          <div class="footer-bottom-right">
            {Component.text("Built with ")}
            <span class="logo-text-base" style="font-size:0.75rem">
              {Component.text("base")}
            </span>
            <span class="logo-text-fn" style="font-size:0.75rem">
              {Component.text("fn")}
            </span>
            {Component.text(" + Xote")}
          </div>
        </div>
      </div>
    </footer>
  }
}

// ---- Global Cmd+K shortcut ----
let _ = Effect.run(() => {
  let handler = (_evt: Dom.event) => {
    let ctrlOrMeta: bool = %raw(`_evt.ctrlKey || _evt.metaKey`)
    let key: string = %raw(`_evt.key`)
    if ctrlOrMeta && key == "k" {
      let _ = %raw(`_evt.preventDefault()`)
      if Signal.peek(searchOpen) {
        closeSearch()
      } else {
        openSearch()
      }
    }
  }
  addWindowListener("keydown", handler)
  Some(() => removeWindowListener("keydown", handler))
})->ignore

// ---- Content layout with sidebar ----
@jsx.component
let make = (~components: array<componentInfo>, ~showSidebar=true, ~children: Component.node) => {
  if showSidebar {
    <div class="docs-wrapper">
      <DocsSidebar components />
      <main class="docs-content"> {children} </main>
    </div>
  } else {
    <div class="full-width-wrapper">
      <main> {children} </main>
    </div>
  }
}

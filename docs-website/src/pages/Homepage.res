open Xote

%%raw(`import './Homepage.css'`)

// ---- Feature data ----
type feature = {
  title: string,
  description: string,
  iconName: Basefn__Icon.name,
  linkText: option<string>,
  linkTo: option<string>,
}

let features = [
  {
    title: "35+ Components",
    description: "Forms, navigation, layout, display, and interactive components \u2014 everything you need to build complete UIs.",
    iconName: Basefn__Icon.Home,
    linkText: Some("Browse components"),
    linkTo: Some("/component/button"),
  },
  {
    title: "Fine-Grained Reactivity",
    description: "Built on Xote's signal-based architecture. Direct DOM updates without a virtual DOM, with automatic dependency tracking.",
    iconName: Basefn__Icon.Star,
    linkText: Some("Learn more"),
    linkTo: Some("/getting-started"),
  },
  {
    title: "Type-Safe by Default",
    description: "Written entirely in ReScript with sound types, pattern matching, and compile-time safety for every component.",
    iconName: Basefn__Icon.Check,
    linkText: Some("View API Reference"),
    linkTo: Some("/api"),
  },
  {
    title: "Dark Mode Built-In",
    description: "Every component supports light and dark themes out of the box with CSS custom properties and smooth transitions.",
    iconName: Basefn__Icon.Moon,
    linkText: None,
    linkTo: None,
  },
  {
    title: "Accessible & Responsive",
    description: "Keyboard navigation, ARIA attributes, and responsive designs that work across devices and screen sizes.",
    iconName: Basefn__Icon.User,
    linkText: None,
    linkTo: None,
  },
  {
    title: "Lightweight & Fast",
    description: "Minimal runtime overhead with no virtual DOM diffing. Components compile to efficient JavaScript with tree-shaking support.",
    iconName: Basefn__Icon.Download,
    linkText: None,
    linkTo: None,
  },
]

// ---- Feature Card ----
module FeatureCard = {
  @jsx.component
  let make = (~feature: feature) => {
    <div class="feature-card">
      <div class="feature-card-icon">
        {Basefn__Icon.make({name: feature.iconName, size: Md})}
      </div>
      <h3> {Node.text(feature.title)} </h3>
      <p> {Node.text(feature.description)} </p>
      {switch (feature.linkText, feature.linkTo) {
      | (Some(text), Some(to)) =>
        Router.link(
          ~to,
          ~attrs=[Node.attr("class", "feature-card-link")],
          ~children=[
            Node.text(text ++ " "),
            Basefn__Icon.make({name: ChevronRight, size: Sm}),
          ],
          (),
        )
      | _ => Node.fragment([])
      }}
    </div>
  }
}

// ---- Hero ----
module Hero = {
  @jsx.component
  let make = () => {
    <section class="hero">
      <div class="hero-inner">
        <div class="hero-logo">
          <span class="hero-logo-base"> {Node.text("base")} </span>
          <span class="hero-logo-fn"> {Node.text("fn")} </span>
        </div>
        <h1>
          {Node.text("Build beautiful interfaces with ")}
          <em> {Node.text("reactive components")} </em>
          {Node.text(" and ")}
          <em> {Node.text("sound types")} </em>
        </h1>
        <p class="hero-subtitle">
          {Node.text(
            "basefn is a comprehensive UI component library for ReScript and Xote. 35+ components with fine-grained reactivity, dark mode, and full type safety \u2014 no virtual DOM required.",
          )}
        </p>
        <div class="hero-buttons">
          {Router.link(
            ~to="/getting-started",
            ~attrs=[Node.attr("class", "btn btn-primary")],
            ~children=[
              Node.text("Get Started "),
              Basefn__Icon.make({name: ChevronRight, size: Sm}),
            ],
            (),
          )}
          <a
            href="https://github.com/brnrdog/basefn-ui"
            target="_blank"
            class="btn btn-ghost"
          >
            {Basefn__Icon.make({name: GitHub, size: Sm})}
            {Node.text(" View on GitHub")}
          </a>
        </div>
        <div class="hero-install">
          <code> {Node.text("npm install basefn-ui")} </code>
        </div>
      </div>
    </section>
  }
}

// ---- Features Section ----
module Features = {
  @jsx.component
  let make = () => {
    <section class="features-section">
      <div class="features-inner">
        <div class="features-heading">
          <h2> {Node.text("Everything you need for modern UIs")} </h2>
          <p>
            {Node.text(
              "A complete component library with reactive primitives, type safety, and thoughtful design patterns.",
            )}
          </p>
        </div>
        <div class="features-grid">
          {Node.fragment(features->Array.map(f => <FeatureCard feature={f} />))}
        </div>
      </div>
    </section>
  }
}

// ---- Component Categories Section ----
module Categories = {
  type category = {
    name: string,
    description: string,
    components: string,
    path: string,
    iconName: Basefn__Icon.name,
  }

  let categories = [
    {
      name: "Form",
      description: "Input controls for collecting user data",
      components: "Button, Input, Textarea, Select, Checkbox, Radio, Label",
      path: "/component/button",
      iconName: Basefn__Icon.Edit,
    },
    {
      name: "Foundation",
      description: "Essential building blocks for any interface",
      components: "Badge, Spinner, Separator, Kbd, Typography",
      path: "/component/badge",
      iconName: Basefn__Icon.Star,
    },
    {
      name: "Display",
      description: "Components for presenting content",
      components: "Card, Avatar, Grid, Alert, Progress",
      path: "/component/card",
      iconName: Basefn__Icon.Info,
    },
    {
      name: "Navigation",
      description: "Guide users through your application",
      components: "Tabs, Accordion, Breadcrumb, Stepper, Timeline",
      path: "/component/tabs",
      iconName: Basefn__Icon.Menu,
    },
    {
      name: "Interactive",
      description: "Rich interactive experiences",
      components: "Modal, Tooltip, Switch, Slider, Dropdown, Toast, Drawer, Spotlight",
      path: "/component/modal",
      iconName: Basefn__Icon.ExternalLink,
    },
    {
      name: "Layout",
      description: "Structure and organize your pages",
      components: "Sidebar, Topbar, AppLayout",
      path: "/component/sidebar",
      iconName: Basefn__Icon.Home,
    },
  ]

  @jsx.component
  let make = () => {
    <section class="categories-section">
      <div class="categories-inner">
        <div class="categories-heading">
          <h2> {Node.text("Component Categories")} </h2>
          <p>
            {Node.text(
              "Organized by purpose so you can find the right component for every part of your UI.",
            )}
          </p>
        </div>
        <div class="categories-grid">
          {Node.fragment(
            categories->Array.map(cat => {
              Router.link(
                ~to=cat.path,
                ~attrs=[Node.attr("class", "category-card")],
                ~children=[
                  <div class="category-card-icon">
                    {Basefn__Icon.make({name: cat.iconName, size: Md})}
                  </div>,
                  <h3> {Node.text(cat.name)} </h3>,
                  <p class="category-card-desc">
                    {Node.text(cat.description)}
                  </p>,
                  <p class="category-card-components">
                    {Node.text(cat.components)}
                  </p>,
                ],
                (),
              )
            }),
          )}
        </div>
      </div>
    </section>
  }
}

// ---- Code Demo ----
module CodeDemo = {
  let buttonCode = `open Xote
open Basefn

@jsx.component
let make = () => {
  let loading = Signal.make(false)

  let handleClick = _ => {
    Signal.set(loading, true)
    let _ = setTimeout(() =>
      Signal.set(loading, false)
    , 1500)
  }

  <div style="display: flex; gap: 0.5rem">
    <Button
      label={Static("Primary")}
      variant={Primary}
      onClick={handleClick}
    />
    <Button
      label={Static("Secondary")}
      variant={Secondary}
    />
    <Button
      label={Static("Ghost")}
      variant={Ghost}
    />
  </div>
}`

  let signalCode = `open Xote
open Basefn

@jsx.component
let make = () => {
  let count = Signal.make(0)

  // Computed values auto-update
  let doubled = Computed.make(() =>
    Signal.get(count) * 2
  )

  let label = Computed.make(() =>
    "Count: " ++ Int.toString(
      Signal.get(count)
    )
  )

  <div>
    <Typography
      text={Reactive(label)}
      variant={H3}
    />
    <Typography
      text={Reactive(
        Signal.map(doubled, d =>
          "Doubled: " ++ Int.toString(d)
        )
      )}
      variant={Muted}
    />
    <Button
      label={Static("Increment")}
      onClick={_ =>
        Signal.update(count, n => n + 1)
      }
    />
  </div>
}`

  @jsx.component
  let make = () => {
    let activeTab = Signal.make("buttons")

    let setTab = (tab: string) => (_evt: Dom.event) => Signal.set(activeTab, tab)

    <section class="code-demo-section">
      <div class="code-demo-inner">
        <div class="code-demo-heading">
          <h2> {Node.text("Simple, reactive, type-safe")} </h2>
          <p>
            {Node.text(
              "Components that work with Xote's signal system. Your mental model stays simple \u2014 update a signal, the UI reacts.",
            )}
          </p>
        </div>
        <div class="code-demo-container">
          <div class="code-editor-pane">
            <div class="code-editor-tabs">
              {Node.element(
                "div",
                ~attrs=[
                  Node.computedAttr("class", () =>
                    "code-editor-tab" ++
                    (Signal.get(activeTab) == "buttons" ? " active" : "")
                  ),
                ],
                ~events=[("click", setTab("buttons"))],
                ~children=[Node.text("Buttons.res")],
                (),
              )}
              {Node.element(
                "div",
                ~attrs=[
                  Node.computedAttr("class", () =>
                    "code-editor-tab" ++
                    (Signal.get(activeTab) == "signals" ? " active" : "")
                  ),
                ],
                ~events=[("click", setTab("signals"))],
                ~children=[Node.text("Signals.res")],
                (),
              )}
            </div>
            <div class="code-editor-body">
              <pre class="code-editor-pre">
                <code>
                  {Node.signalFragment(
                    Computed.make(() => {
                      let code = switch Signal.get(activeTab) {
                      | "buttons" => buttonCode
                      | _ => signalCode
                      }
                      [Node.text(code)]
                    }),
                  )}
                </code>
              </pre>
            </div>
          </div>
        </div>
      </div>
    </section>
  }
}

// ---- Community Section ----
module Community = {
  @jsx.component
  let make = () => {
    <section class="community-section">
      <div class="community-inner">
        <h2> {Node.text("Ready to build?")} </h2>
        <p>
          {Node.text(
            "basefn is open source and built for developers who value type safety, fine-grained reactivity, and clean component APIs.",
          )}
        </p>
        <div class="community-links">
          {Router.link(
            ~to="/getting-started",
            ~attrs=[Node.attr("class", "btn btn-primary")],
            ~children=[
              Node.text("Get Started "),
              Basefn__Icon.make({name: ChevronRight, size: Sm}),
            ],
            (),
          )}
          <a
            href="https://github.com/brnrdog/basefn-ui"
            target="_blank"
            class="btn btn-ghost"
          >
            {Basefn__Icon.make({name: GitHub, size: Sm})}
            {Node.text(" GitHub")}
          </a>
          <a
            href="https://www.npmjs.com/package/basefn-ui"
            target="_blank"
            class="btn btn-ghost"
          >
            {Basefn__Icon.make({name: Download, size: Sm})}
            {Node.text(" npm")}
          </a>
        </div>
      </div>
    </section>
  }
}

// ---- Main page ----
@jsx.component
let make = () => {
  Node.fragment([<Hero />, <Features />, <Categories />, <CodeDemo />, <Community />])
}

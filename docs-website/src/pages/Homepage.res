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
    description: "Forms, navigation, layout, display, and interactive components covering common UI patterns.",
    iconName: Basefn__Icon.Home,
    linkText: Some("Browse components"),
    linkTo: Some("/component/button"),
  },
  {
    title: "Signal-Based Reactivity",
    description: "Built on Xote's signal architecture. Direct DOM updates with automatic dependency tracking, no virtual DOM.",
    iconName: Basefn__Icon.Star,
    linkText: Some("Learn more"),
    linkTo: Some("/getting-started"),
  },
  {
    title: "Type-Safe",
    description: "Written in ReScript with sound types, pattern matching, and compile-time safety.",
    iconName: Basefn__Icon.Check,
    linkText: None,
    linkTo: None,
  },
  {
    title: "Dark Mode",
    description: "Light and dark themes supported out of the box via CSS custom properties.",
    iconName: Basefn__Icon.Moon,
    linkText: None,
    linkTo: None,
  },
  {
    title: "Accessible & Responsive",
    description: "Keyboard navigation, ARIA attributes, and responsive layouts included where applicable.",
    iconName: Basefn__Icon.User,
    linkText: None,
    linkTo: None,
  },
  {
    title: "Lightweight",
    description: "No virtual DOM diffing. Components compile to plain JavaScript with minimal runtime overhead.",
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
      <h3> {Component.text(feature.title)} </h3>
      <p> {Component.text(feature.description)} </p>
      {switch (feature.linkText, feature.linkTo) {
      | (Some(text), Some(to)) =>
        Router.link(
          ~to,
          ~attrs=[Component.attr("class", "feature-card-link")],
          ~children=[
            Component.text(text ++ " "),
            Basefn__Icon.make({name: ChevronRight, size: Sm}),
          ],
          (),
        )
      | _ => Component.fragment([])
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
          <span class="hero-logo-base"> {Component.text("base")} </span>
          <span class="hero-logo-fn"> {Component.text("fn")} </span>
        </div>
        <h1>
          {Component.text("A foundational UI library for ")}
          <em> {Component.text("ReScript")} </em>
          {Component.text(" and ")}
          <em> {Component.text("Xote")} </em>
        </h1>
        <p class="hero-subtitle">
          {Component.text(
            "basefn provides 35+ UI components with signal-based reactivity, dark mode, and type safety. Built for the ReScript and Xote ecosystem.",
          )}
        </p>
        <div class="hero-buttons">
          {Router.link(
            ~to="/getting-started",
            ~attrs=[Component.attr("class", "btn btn-primary")],
            ~children=[
              Component.text("Get Started "),
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
            {Component.text(" View on GitHub")}
          </a>
        </div>
        <div class="hero-install">
          <code> {Component.text("npm install basefn-ui")} </code>
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
          <h2> {Component.text("What's included")} </h2>
          <p>
            {Component.text(
              "A set of foundational components for building UIs with ReScript and Xote.",
            )}
          </p>
        </div>
        <div class="features-grid">
          {Component.fragment(features->Array.map(f => <FeatureCard feature={f} />))}
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
          <h2> {Component.text("Signals in, UI out")} </h2>
          <p>
            {Component.text(
              "Components work with Xote's signal system. Update a signal, the UI reacts.",
            )}
          </p>
        </div>
        <div class="code-demo-container">
          <div class="code-editor-pane">
            <div class="code-editor-tabs">
              {Component.element(
                "div",
                ~attrs=[
                  Component.computedAttr("class", () =>
                    "code-editor-tab" ++
                    (Signal.get(activeTab) == "buttons" ? " active" : "")
                  ),
                ],
                ~events=[("click", setTab("buttons"))],
                ~children=[Component.text("Buttons.res")],
                (),
              )}
              {Component.element(
                "div",
                ~attrs=[
                  Component.computedAttr("class", () =>
                    "code-editor-tab" ++
                    (Signal.get(activeTab) == "signals" ? " active" : "")
                  ),
                ],
                ~events=[("click", setTab("signals"))],
                ~children=[Component.text("Signals.res")],
                (),
              )}
            </div>
            <div class="code-editor-body">
              <pre class="code-editor-pre">
                <code>
                  {Component.signalFragment(
                    Computed.make(() => {
                      let code = switch Signal.get(activeTab) {
                      | "buttons" => buttonCode
                      | _ => signalCode
                      }
                      [Component.text(code)]
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
        <h2> {Component.text("Get started")} </h2>
        <p>
          {Component.text(
            "basefn is open source and available on npm.",
          )}
        </p>
        <div class="community-links">
          {Router.link(
            ~to="/getting-started",
            ~attrs=[Component.attr("class", "btn btn-primary")],
            ~children=[
              Component.text("Get Started "),
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
            {Component.text(" GitHub")}
          </a>
          <a
            href="https://www.npmjs.com/package/basefn-ui"
            target="_blank"
            class="btn btn-ghost"
          >
            {Basefn__Icon.make({name: Download, size: Sm})}
            {Component.text(" npm")}
          </a>
        </div>
      </div>
    </section>
  }
}

// ---- Main page ----
@jsx.component
let make = () => {
  Component.fragment([<Hero />, <Features />, <CodeDemo />, <Community />])
}

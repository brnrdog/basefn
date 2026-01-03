open Xote

let components = DocsRoutes.components

// Initialize router and theme once at module level
Router.init()
Basefn__Theme.init()

// Debug: Watch for location changes
let _ = Effect.run(() => {
  let loc = Signal.get(Router.location)
  (%raw(`function(p) { console.log('Router.location changed:', p) }`): string => unit)(loc.pathname)
  None
})

// Debug: Watch for theme changes
let _ = Effect.run(() => {
  let theme = Signal.get(Basefn__Theme.currentTheme)
  (%raw(`function(t) { console.log('Theme changed:', t) }`): 'a => unit)(theme)
  None
})

// Define routes once at module level to prevent recreation on every render
let appRoutes = Router.routes([
  {
    pattern: "/",
    render: _params => {
      let _ = %raw(`console.log('Route render: /')`)
      <DocsLayout components showSidebar={false}>
        <Homepage />
      </DocsLayout>
    },
  },
  {
    pattern: "/getting-started",
    render: _params => {
      let _ = %raw(`console.log('Route render: /getting-started')`)
      <DocsLayout components>
        <GettingStarted />
      </DocsLayout>
    },
  },
  {
    pattern: "/api",
    render: _params => {
      let _ = %raw(`console.log('Route render: /api')`)
      <DocsLayout components>
        <ApiReference />
      </DocsLayout>
    },
  },
  {
    pattern: "/changelog",
    render: _params => {
      let _ = %raw(`console.log('Route render: /changelog')`)
      <DocsLayout components>
        <Changelog />
      </DocsLayout>
    },
  },
  {
    pattern: "/component/:name",
    render: params => {
      let componentName = params->Dict.get("name")->Option.getOr("button")
      let _ = %raw(`console.log('Route render: /component/', componentName)`)
      <DocsLayout components>
        <DocsComponentPage componentName />
      </DocsLayout>
    },
  },
])

module App = {
  @jsx.component
  let make = () => {
    <div> {appRoutes} </div>
  }
}

Component.mountById(<App />, "root")

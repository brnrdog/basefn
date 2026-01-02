open Xote

let components = DocsRoutes.components

module App = {
  @jsx.component
  let make = () => {
    // Initialize router and theme
    Router.init()
    let _ = Effect.run(() => {
      Basefn__Theme.init()->ignore
      None
    })

    <div>
      {Router.routes([
        {
          pattern: "/",
          render: _params =>
            <DocsLayout components showSidebar={false}>
              <Homepage />
            </DocsLayout>,
        },
        {
          pattern: "/getting-started",
          render: _params =>
            <DocsLayout components>
              <GettingStarted />
            </DocsLayout>,
        },
        {
          pattern: "/api",
          render: _params =>
            <DocsLayout components>
              <ApiReference />
            </DocsLayout>,
        },
        {
          pattern: "/changelog",
          render: _params =>
            <DocsLayout components>
              <Changelog />
            </DocsLayout>,
        },
        {
          pattern: "/component/:name",
          render: params => {
            let componentName = params->Dict.get("name")->Option.getOr("button")
            <DocsLayout components>
              <DocsComponentPage componentName />
            </DocsLayout>
          },
        },
      ])}
    </div>
  }
}

Component.mountById(<App />, "root")

open Xote

let components = DocsRoutes.components

module App = {
  @jsx.component
  let make = () => {
    // Initialize router
    Router.init()

    <div>
      {Router.routes([
        {
          pattern: "/",
          render: _params =>
            <DocsLayout components>
              <DocsHome />
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

%%raw(`import hljs from 'highlight.js/lib/core'`)
%%raw(`import javascript from 'highlight.js/lib/languages/javascript'`)
%%raw(`import rescript from 'highlight.js/lib/languages/reasonml'`)
%%raw(`hljs.registerLanguage('javascript', javascript)`)
%%raw(`hljs.registerLanguage('rescript', rescript)`)

open Xote

let highlightCode = %raw(`function() {
      document.querySelectorAll('pre code:not(.hljs)').forEach((block) => {
        console.log('what')
        hljs.highlightElement(block);
      });
    }`)

// Highlight on mount
let _ = Effect.run(() => {
  let _ = setTimeout(() => {
    highlightCode()
  }, 100)

  None
})

let components = DocsRoutes.components

// Initialize router and theme once at module level
Router.init()
Basefn__Theme.init()

// Define routes once at module level to prevent recreation on every render
let appRoutes = Router.routes([
  {
    pattern: PathUtils.toRoute("/"),
    render: _params => {
      <DocsLayout components showSidebar={false}>
        <Homepage />
      </DocsLayout>
    },
  },
  {
    pattern: PathUtils.toRoute("/getting-started"),
    render: _params => {
      <DocsLayout components>
        <GettingStarted />
      </DocsLayout>
    },
  },
  {
    pattern: PathUtils.toRoute("/api"),
    render: _params => {
      <DocsLayout components>
        <ApiReference />
      </DocsLayout>
    },
  },
  {
    pattern: PathUtils.toRoute("/changelog"),
    render: _params => {
      <DocsLayout components>
        <Changelog />
      </DocsLayout>
    },
  },
  {
    pattern: PathUtils.toRoute("/component/:name"),
    render: params => {
      let componentName = params->Dict.get("name")->Option.getOr("button")
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

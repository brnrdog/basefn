%%raw(`import './styles/variables.css'`)
%%raw(`import hljs from 'highlight.js/lib/core'`)
%%raw(`import javascript from 'highlight.js/lib/languages/javascript'`)
%%raw(`import xml from 'highlight.js/lib/languages/xml'`)
%%raw(`import rescript from 'highlight.js/lib/languages/reasonml'`)
%%raw(`hljs.registerLanguage('javascript', javascript)`)
%%raw(`hljs.registerLanguage('xml', xml)`)
%%raw(`hljs.registerLanguage('rescript', rescript)`)

open Xote

let highlightCode = %raw(`function() {
      document.querySelectorAll('pre code:not(.hljs)').forEach((block) => {
        hljs.highlightElement(block);
      });
    }`)

// Highlight code on route changes
let _ = Effect.run(() => {
  // Track route changes by subscribing to location signal
  let _location = Signal.get(Router.location())

  // Run highlighting after DOM updates
  let _ = setTimeout(() => {
    highlightCode()
  }, 50)

  None
})

let components = DocsRoutes.components

// Initialize router and theme once at module level
Router.init(~basePath=PathUtils.basePath, ())
Basefn__Theme.init()

// Define routes
let appRoutes = Router.routes([
  {
    pattern: "/",
    render: _params => {
      <DocsLayout components showSidebar={false}>
        <Homepage />
      </DocsLayout>
    },
  },
  {
    pattern: "/getting-started",
    render: _params => {
      <DocsLayout components>
        <GettingStarted />
      </DocsLayout>
    },
  },
  {
    pattern: "/component/:name",
    render: params => {
      let componentName = Obj.magic(params)->Dict.get("name")->Option.getOr("button")
      <DocsLayout components>
        <DocsComponentPage componentName />
      </DocsLayout>
    },
  },
])

module App = {
  @jsx.component
  let make = () => {
    let searchItems = DocsLayout.buildSearchItems(components)

    <div>
      <DocsLayout.Header />
      {appRoutes}
      <DocsLayout.Footer />
      <DocsLayout.SearchModal searchItems />
    </div>
  }
}

Component.mountById(<App />, "root")

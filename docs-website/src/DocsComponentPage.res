%%raw(`import './DocsComponentPage.css'`)

open Xote
open Basefn

type example = {
  title: string,
  description: string,
  demo: Component.node,
  code: string,
}

let copyToClipboard: string => unit = %raw(`
  function(text) {
    navigator.clipboard.writeText(text);
  }
`)

module CodeBlock = {
  @jsx.component
  let make = (~code: string) => {
    let copied = Signal.make(false)

    let handleCopy = _ => {
      copyToClipboard(code)
      Signal.set(copied, true)
      let _ = %raw(`setTimeout(() => { copied.value = false }, 2000)`)
    }

    let buttonContent = Computed.make(() => {
      [Component.text(Signal.get(copied) ? "Copied!" : "Copy")]
    })

    <div class="docs-component-code">
      <div class="docs-component-code__header">
        <button class="docs-component-code__copy-btn" onClick={handleCopy}>
          {Component.signalFragment(buttonContent)}
        </button>
      </div>
      <div class="docs-component-code__content">
        <pre>
          <code class="language-rescript"> {Component.text(code)} </code>
        </pre>
      </div>
    </div>
  }
}

@jsx.component
let make = (~componentName: string) => {
  // Get examples for the component
  let examples = DocsExamples.getExamples(componentName)
  let title = componentName->String.replaceAll("-", " ")

  <div class="docs-component-page">
    <div class="docs-component-header">
      <Typography text={ReactiveProp.Static(title)} variant={Typography.H2} />
    </div>
    <div class="docs-component-content">
      {examples
      ->Array.mapWithIndex((example, index) => {
        <div key={Int.toString(index)} class="docs-component-example">
          <div class="docs-component-example__header">
            <Typography text={ReactiveProp.Static(example.title)} variant={Typography.H4} />
            <p class="docs-component-example__description">
              {Component.text(example.description)}
            </p>
          </div>
          <Card className="docs-component-example__card">
            <div class="docs-component-example__split">
              <div class="docs-component-demo"> {example.demo} </div>
              <CodeBlock code={example.code} />
            </div>
          </Card>
        </div>
      })
      ->Component.fragment}
    </div>
  </div>
}

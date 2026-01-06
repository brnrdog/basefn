%%raw(`import './DocsComponentPage.css'`)

open Xote
open Basefn

type example = {
  title: string,
  description: string,
  demo: Component.node,
  code: string,
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
          <div class="docs-component-demo"> {example.demo} </div>
          <div class="docs-component-code">
            <pre>
              <code class="language-javascript"> {Component.text(example.code)} </code>
            </pre>
          </div>
        </div>
      })
      ->Component.fragment}
    </div>
  </div>
}

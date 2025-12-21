%%raw(`import './DocsComponentPage.css'`)

open Xote
open Eita

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
      <Typography text={Signal.make(title)} variant={Typography.H1} />
      <Typography
        text={Signal.make("Explore examples and code for the " ++ title ++ " component.")}
        variant={Typography.Muted}
      />
    </div>
    <div class="docs-component-content">
      {examples
      ->Array.mapWithIndex((example, index) => {
        <div key={Int.toString(index)} class="docs-component-example">
          <div class="docs-component-example__header">
            <Typography text={Signal.make(example.title)} variant={Typography.H4} />
            <p class="docs-component-example__description">
              {Component.text(example.description)}
            </p>
          </div>
          <Tabs
            tabs={[
              {
                label: "Demo",
                value: "demo",
                content: <div class="docs-component-demo"> {example.demo} </div>,
              },
              {
                label: "Code",
                value: "code",
                content: <div class="docs-component-code">
                  <pre>
                    <code> {Component.text(example.code)} </code>
                  </pre>
                </div>,
              },
            ]}
          />
        </div>
      })
      ->Component.fragment}
    </div>
  </div>
}

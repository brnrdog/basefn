open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "Basic Accordion",
      description: "Collapsible content panels.",
      demo: <Accordion
        items={[
          {
            value: "item1",
            title: "What is basefn-UI?",
            content: <p>
              {Node.text(
                "basefn-UI is a modern ReScript UI component library built with Xote for fine-grained reactivity.",
              )}
            </p>,
          },
          {
            value: "item2",
            title: "How do I install it?",
            content: <p>
              {Node.text(
                "You can install basefn-UI via npm or use it directly in your ReScript project.",
              )}
            </p>,
          },
          {
            value: "item3",
            title: "Is it free?",
            content: <p> {Node.text("Yes, basefn-UI is open source and free to use.")} </p>,
          },
        ]}
      />,
      code: `<Accordion
  items={[
    {
      value: "item1",
      title: "Question?",
      content: <p>{Node.text("Answer here")}</p>,
    },
  ]}
/>`,
    },
  ]
}

open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "Basic Card",
      description: "A simple card container for grouping content.",
      demo: <Card>
        <Typography
          text={ReactiveProp.Static("Card Title")}
          variant={Typography.H5}
          style="margin-bottom: 1rem;"
        />
        <Typography
          text={ReactiveProp.static(
            "This is a basic card component. It can contain any content.",
          )}
          style="margin-bottom: 2rem;"
          variant={P}
        />
        <Button> {Component.text("Call to Action")} </Button>
      </Card>,
      code: `<Card>
  <Typography text={ReactiveProp.Static("Card Title")} variant={Typography.H4} />
  <p>{Component.text("This is a basic card component.")}</p>
</Card>`,
    },
  ]
}

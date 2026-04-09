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
    {
      title: "Card with JSX Header and Footer",
      description: "Pass any content to the header and footer, not just text.",
      demo: <Card
        header={
          <div style="display: flex; justify-content: space-between; align-items: center;">
            <Typography
              text={ReactiveProp.Static("Project Status")}
              variant={Typography.H5}
            />
            <Badge label={Signal.make("Active")} variant={Badge.Success} size={Badge.Sm} />
          </div>
        }
        footer={
          <div style="display: flex; justify-content: flex-end; gap: 0.5rem;">
            <Button variant={Button.Ghost} size={Button.Sm}> {Component.text("Cancel")} </Button>
            <Button size={Button.Sm}> {Component.text("Save")} </Button>
          </div>
        }
      >
        <Typography
          text={ReactiveProp.static("Card body content with a rich header and footer.")}
          variant={P}
        />
      </Card>,
      code: `<Card
  header={
    <div>
      <Typography text={Static("Title")} />
      <Badge label={Signal.make("Active")} />
    </div>
  }
  footer={
    <div>
      <Button variant={Ghost}> {text("Cancel")} </Button>
      <Button> {text("Save")} </Button>
    </div>
  }
>
  <p> {text("Card body")} </p>
</Card>`,
    },
    {
      title: "Card without Padding",
      description: "Use padding={false} for edge-to-edge content like images or tables.",
      demo: <Card padding={false}>
        <div style="height: 120px; background: linear-gradient(135deg, var(--basefn-color-primary), var(--basefn-color-secondary)); display: flex; align-items: center; justify-content: center; color: white;">
          {Component.text("Full-bleed content")}
        </div>
      </Card>,
      code: `<Card padding={false}>
  <img src="..." style="width: 100%;" />
</Card>`,
    },
  ]
}

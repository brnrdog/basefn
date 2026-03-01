open Xote
open Basefn

let examples: array<DocsExample.t> = [
  {
    title: "Simple Column Count",
    description: "Create an equal-width grid with a simple column count.",
    demo: <Grid columns={Count(3)} gap="1rem">
      <Card>
        <Typography text={ReactiveProp.Static("Item 1")} variant={Typography.H5} />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Item 2")} variant={Typography.H5} />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Item 3")} variant={Typography.H5} />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Item 4")} variant={Typography.H5} />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Item 5")} variant={Typography.H5} />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Item 6")} variant={Typography.H5} />
      </Card>
    </Grid>,
    code: `<Grid columns={Count(3)} gap="1rem">
  <Card><Typography text={ReactiveProp.Static("Item 1")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Item 2")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Item 3")} /></Card>
</Grid>`,
  },
  {
    title: "Responsive Auto-Fit",
    description: "Grid that automatically fits items based on available space.",
    demo: <Grid columns={AutoFit("minmax(200px, 1fr)")} gap="1rem">
      <Card>
        <Typography text={ReactiveProp.Static("Card 1")} variant={Typography.H5} />
        <Typography
          text={ReactiveProp.Static("Resizes automatically")} variant={Typography.Small}
        />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Card 2")} variant={Typography.H5} />
        <Typography
          text={ReactiveProp.Static("Try resizing window")} variant={Typography.Small}
        />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Card 3")} variant={Typography.H5} />
        <Typography text={ReactiveProp.Static("Flexible layout")} variant={Typography.Small} />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Card 4")} variant={Typography.H5} />
        <Typography text={ReactiveProp.Static("No media queries")} variant={Typography.Small} />
      </Card>
    </Grid>,
    code: `<Grid columns={AutoFit("minmax(200px, 1fr)")} gap="1rem">
  <Card><Typography text={ReactiveProp.Static("Card 1")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Card 2")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Card 3")} /></Card>
</Grid>`,
  },
  {
    title: "Custom Template",
    description: "Define exact column sizes with custom templates.",
    demo: <Grid columns={Template("2fr 1fr 1fr")} gap="1rem">
      <Card>
        <Typography
          text={ReactiveProp.Static("2fr - Twice as wide")} variant={Typography.Small}
        />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("1fr")} variant={Typography.Small} />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("1fr")} variant={Typography.Small} />
      </Card>
    </Grid>,
    code: `<Grid columns={Template("2fr 1fr 1fr")} gap="1rem">
  <Card><Typography text={ReactiveProp.Static("2fr - Twice as wide")} /></Card>
  <Card><Typography text={ReactiveProp.Static("1fr")} /></Card>
  <Card><Typography text={ReactiveProp.Static("1fr")} /></Card>
</Grid>`,
  },
  {
    title: "Grid with Spanning Items",
    description: "Items can span multiple columns or rows.",
    demo: <Grid columns={Count(4)} gap="1rem">
      <Grid.Item column={Span(2)}>
        <Card>
          <Typography text={ReactiveProp.Static("Spans 2 columns")} variant={Typography.H5} />
        </Card>
      </Grid.Item>
      <Card>
        <Typography text={ReactiveProp.Static("Normal")} variant={Typography.Small} />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Normal")} variant={Typography.Small} />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Normal")} variant={Typography.Small} />
      </Card>
      <Grid.Item column={Span(3)}>
        <Card>
          <Typography text={ReactiveProp.Static("Spans 3 columns")} variant={Typography.H5} />
        </Card>
      </Grid.Item>
    </Grid>,
    code: `<Grid columns={Count(4)} gap="1rem">
  <Grid.Item column={Span(2)}>
    <Card><Typography text={ReactiveProp.Static("Spans 2 columns")} /></Card>
  </Grid.Item>
  <Card><Typography text={ReactiveProp.Static("Normal")} /></Card>
  <Card><Typography text={ReactiveProp.Static("Normal")} /></Card>
</Grid>`,
  },
  {
    title: "Alignment Options",
    description: "Control item alignment with justifyItems and alignItems.",
    demo: <Grid
      columns={Count(3)}
      gap="1rem"
      justifyItems={Center}
      alignItems={Center}
      style={ReactiveProp.static("min-height: 200px;")}
    >
      <Badge variant={Badge.Default} label={Signal.make("Centered")} />
      <Badge variant={Badge.Primary} label={Signal.make("Centered")} />
      <Badge variant={Badge.Success} label={Signal.make("Centered")} />
    </Grid>,
    code: `<Grid
  columns={Count(3)}
  gap="1rem"
  justifyItems={Center}
  alignItems={Center}
>
  <Badge variant={Badge.Default} label={Signal.make("Centered")} />
  <Badge variant={Badge.Primary} label={Signal.make("Centered")} />
</Grid>`,
  },
  {
    title: "Form Layout",
    description: "Use grid for complex form layouts.",
    demo: <Grid columns={Count(2)} gap="1rem">
      <div>
        <Label text="First Name" />
        <Input type_={Text} value={Static("")} />
      </div>
      <div>
        <Label text="Last Name" />
        <Input type_={Text} value={Static("")} />
      </div>
      <Grid.Item column={Span(2)}>
        <Label text="Email" />
        <Input type_={Email} value={Static("")} />
      </Grid.Item>
      <Grid.Item column={Span(2)}>
        <Label text="Address" />
        <Textarea value={Static("")} />
      </Grid.Item>
      <div>
        <Label text="City" />
        <Input type_={Text} value={Static("")} />
      </div>
      <div>
        <Label text="Zip Code" />
        <Input type_={Text} value={Static("")} />
      </div>
    </Grid>,
    code: `<Grid columns={Count(2)} gap="1rem">
  <div>
    <Label text="First Name" />
    <Input type_={Text} value={Static("")} />
  </div>
  <div>
    <Label text="Last Name" />
    <Input type_={Text} value={Static("")} />
  </div>
  <Grid.Item column={Span(2)}>
    <Label text="Email" />
    <Input type_={Email} value={Static("")} />
  </Grid.Item>
</Grid>`,
  },
]

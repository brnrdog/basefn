open Xote
open Basefn

@jsx.component
let make = () => {
  <div class="docs-component-page">
    <Typography text={ReactiveProp.Static("Getting Started")} variant={Typography.H2} />
    <Typography
      text={ReactiveProp.Static("A UI component library for ReScript and Xote.")}
      variant={Typography.Lead}
    />
    <Typography text={ReactiveProp.Static("Installation")} variant={Typography.H3} />
    <Card>
      <pre>
        <code class="language-bash">
          {Component.text("npm install basefn-ui")}
        </code>
      </pre>
    </Card>
    <Typography text={ReactiveProp.Static("Requirements")} variant={Typography.H3} />
    <Typography
      text={ReactiveProp.Static("• Xote ^4.7.0")}
      variant={Typography.P}
    />
    <Typography
      text={ReactiveProp.Static("• ReScript ^12.0.0")}
      variant={Typography.P}
    />
    <Typography text={ReactiveProp.Static("Basic Usage")} variant={Typography.H3} />
    <Card>
      <pre>
        <code class="language-rescript">
          {Component.text(`open Xote
open Basefn

@jsx.component
let make = () => {
  let count = Signal.make(0)

  <div>
    <Typography
      text={ReactiveProp.Reactive(count->Signal.map(c => "Count: " ++ Int.toString(c)))}
      variant={Typography.P}
    />
    <Button
      label={Static("Increment")}
      onClick={_ => Signal.update(count, c => c + 1)}
      variant={Button.Primary}
    />
  </div>
}`)}
        </code>
      </pre>
    </Card>
    <Typography text={ReactiveProp.Static("Props: Static vs Reactive")} variant={Typography.H3} />
    <Typography
      text={ReactiveProp.Static("Components accept props as either Static or Reactive values.")}
      variant={Typography.P}
    />
    <Card>
      <pre>
        <code class="language-rescript">
          {Component.text(`// Static - value doesn't change
<Button label={Static("Click me")} />

// Reactive - value updates with signal
let text = Signal.make("Loading...")
<Button label={Reactive(text)} />`)}
        </code>
      </pre>
    </Card>
    <Typography text={ReactiveProp.Static("Form Example")} variant={Typography.H3} />
    <Card>
      <pre>
        <code class="language-rescript">
          {Component.text(`let name = Signal.make("")
let email = Signal.make("")

<div>
  <Label text="Name" required={true} />
  <Input
    value={Reactive(name)}
    onInput={evt => {
      let target = Obj.magic(evt)["target"]
      Signal.set(name, target["value"])
    }}
    type_={Input.Text}
  />

  <Label text="Email" required={true} />
  <Input
    value={Reactive(email)}
    onInput={evt => {
      let target = Obj.magic(evt)["target"]
      Signal.set(email, target["value"])
    }}
    type_={Input.Email}
  />

  <Button
    label={Static("Submit")}
    onClick={_ => Console.log("Submitted")}
    variant={Button.Primary}
  />
</div>`)}
        </code>
      </pre>
    </Card>
    <Typography text={ReactiveProp.Static("Components")} variant={Typography.H3} />
    <Grid columns={Count(3)} gap="1rem">
      <Card>
        <Typography text={ReactiveProp.Static("Form")} variant={Typography.H4} />
        <Typography
          text={ReactiveProp.Static("Button, Input, Textarea, Select, Checkbox, Radio, Label")}
          variant={Typography.Muted}
        />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Foundation")} variant={Typography.H4} />
        <Typography
          text={ReactiveProp.Static("Badge, Spinner, Separator, Kbd, Typography")}
          variant={Typography.Muted}
        />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Display")} variant={Typography.H4} />
        <Typography
          text={ReactiveProp.Static("Card, Avatar, Grid, Alert, Progress")}
          variant={Typography.Muted}
        />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Navigation")} variant={Typography.H4} />
        <Typography
          text={ReactiveProp.Static("Tabs, Accordion, Breadcrumb, Stepper, Timeline")}
          variant={Typography.Muted}
        />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Interactive")} variant={Typography.H4} />
        <Typography
          text={ReactiveProp.Static("Modal, Tooltip, Switch, Slider, Dropdown, Toast, Drawer")}
          variant={Typography.Muted}
        />
      </Card>
      <Card>
        <Typography text={ReactiveProp.Static("Layout")} variant={Typography.H4} />
        <Typography
          text={ReactiveProp.Static("Sidebar, Topbar, AppLayout")}
          variant={Typography.Muted}
        />
      </Card>
    </Grid>
  </div>
}

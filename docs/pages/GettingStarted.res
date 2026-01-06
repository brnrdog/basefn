open Xote
open Basefn

@jsx.component
let make = () => {
  <div class="docs-component-page">
    <Typography text={ReactiveProp.Static("Getting Started")} variant={Typography.H2} />
    <Typography
      text={ReactiveProp.Static(
        "Learn how to install and use basefn-ui in your ReScript + Xote application.",
      )}
      variant={Typography.Lead}
    />
    // Installation Section
    <Typography text={ReactiveProp.Static("Installation")} variant={Typography.H3} />
    <Typography
      text={ReactiveProp.Static("Install basefn-ui via npm or yarn:")} variant={Typography.P}
    />
    <Card>
      <Typography text={ReactiveProp.Static("npm install basefn-ui")} variant={Typography.Code} />
      <br />
      <Typography text={ReactiveProp.Static("# or")} variant={Typography.Muted} />
      <br />
      <Typography text={ReactiveProp.Static("yarn add basefn-ui")} variant={Typography.Code} />
    </Card>
    <div style="margin: 1rem 0;">
      <Alert
        title="Prerequisites"
        message={Signal.make(
          "basefn-ui requires Xote (^4.7.0) and ReScript (^12.0.0). Make sure these are installed in your project.",
        )}
        variant={Alert.Info}
      />
    </div>
    // Quick Start Section
    <Typography text={ReactiveProp.Static("Quick Start")} variant={Typography.H3} />
    <Typography
      text={ReactiveProp.Static("Here's a simple example to get you started:")}
      variant={Typography.P}
    />
    <Card>
      <pre>
        <code class="language-rescript">
          {Component.text(`open Xote
open Basefn

@jsx.component
let make = () => {
  // Create a signal for reactive state
  let count = Signal.make(0)

  <div>
    <Typography
      text={ReactiveProp.static("Counter Example")}
      variant={Typography.H3}
    />

    <Typography
      text={ReactiveProp.reactive(count->Signal.map(c => "Count: " ++ Int.toString(c)))}
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
    // Understanding Reactive Props
    <Typography
      text={ReactiveProp.Static("Understanding Reactive Props")} variant={Typography.H2}
    />
    <Typography
      text={ReactiveProp.Static(
        "basefn-ui components use ReactiveProp for flexible property handling. Props can be either static or reactive:",
      )}
      variant={Typography.P}
    />
    <Card>
      <Typography text={ReactiveProp.Static("Static Props")} variant={Typography.H4} />
      <Typography
        text={ReactiveProp.Static("Use Static() for values that don't change:")}
        variant={Typography.P}
      />
      <Typography
        text={ReactiveProp.Static(`<Button
  label={Static("Click me")}
  variant={Button.Primary}
/>`)}
        variant={Typography.Code}
      />
      <br />
      <br />
      <Typography text={ReactiveProp.Static("Reactive Props")} variant={Typography.H4} />
      <Typography
        text={ReactiveProp.Static("Use Reactive() for signals that update over time:")}
        variant={Typography.P}
      />
      <Typography
        text={ReactiveProp.Static(`let name = Signal.make("")

<Input
  value={Reactive(name)}
  type_={Input.Text}
  placeholder="Enter name"
/>`)}
        variant={Typography.Code}
      />
    </Card>
    // Form Components Example
    <Typography text={ReactiveProp.Static("Building a Simple Form")} variant={Typography.H2} />
    <Typography
      text={ReactiveProp.Static("Here's a practical example with form components:")}
      variant={Typography.P}
    />
    <Card>
      <pre>
        <code class="language-javascript">
          {Component.text(`open Xote
open Basefn

@jsx.component
let make = () => {
  // Form state
  let name = Signal.make("")
  let email = Signal.make("")
  let agreeToTerms = Signal.make(false)

  let handleSubmit = _ => {
    Console.log("Name: " ++ Signal.get(name))
    Console.log("Email: " ++ Signal.get(email))
  }

  <Card>
    <Typography
      text={ReactiveProp.Static("Sign Up Form")}
      variant={Typography.H3}
    />

    <Label text="Name" required={true} />
    <Input
      value={Reactive(name)}
      onInput={evt => {
        let target = Obj.magic(evt)["target"]
        Signal.set(name, target["value"])
      }}
      type_={Input.Text}
      placeholder="John Doe"
    />

    <br />

    <Label text="Email" required={true} />
    <Input
      value={Reactive(email)}
      onInput={evt => {
        let target = Obj.magic(evt)["target"]
        Signal.set(email, target["value"])
      }}
      type_={Input.Email}
      placeholder="john@example.com"
    />

    <br />

    <Checkbox
      checked={agreeToTerms}
      onChange={_ => Signal.update(agreeToTerms, v => !v)}
      label="I agree to terms"
    />

    <br />

    <Button
      label={Static("Submit")}
      onClick={handleSubmit}
      variant={Button.Primary}
    />
  </Card>
}`)}
        </code>
      </pre>
    </Card>
    // Interactive Demo
    <Typography text={ReactiveProp.Static("Try It Out")} variant={Typography.H2} />
    <Typography
      text={ReactiveProp.Static("Here's a live example you can interact with:")}
      variant={Typography.P}
    />
    // Component Categories
    <Typography text={ReactiveProp.Static("Available Components")} variant={Typography.H2} />
    <Typography
      text={ReactiveProp.Static(
        "basefn-ui provides a comprehensive set of components organized into categories:",
      )}
      variant={Typography.P}
    />
    <Accordion
      items={[
        {
          value: "form",
          title: "Form Components",
          content: <div>
            <Typography
              text={ReactiveProp.Static(
                "Button, Input, Textarea, Select, Checkbox, Radio, Label - Everything you need for building forms.",
              )}
              variant={Typography.P}
            />
          </div>,
        },
        {
          value: "foundation",
          title: "Foundation Components",
          content: <div>
            <Typography
              text={ReactiveProp.Static(
                "Badge, Spinner, Separator, Kbd, Typography - Basic building blocks for your UI.",
              )}
              variant={Typography.P}
            />
          </div>,
        },
        {
          value: "content",
          title: "Content Components",
          content: <div>
            <Typography
              text={ReactiveProp.Static(
                "Card, Avatar, Grid, Alert, Progress, Tabs, Accordion, Breadcrumb - Display and organize content.",
              )}
              variant={Typography.P}
            />
          </div>,
        },
        {
          value: "interactive",
          title: "Interactive Components",
          content: <div>
            <Typography
              text={ReactiveProp.Static(
                "Modal, Tooltip, Switch, Slider, Dropdown, Toast - Advanced interactive elements.",
              )}
              variant={Typography.P}
            />
          </div>,
        },
        {
          value: "navigation",
          title: "Navigation & Layout",
          content: <div>
            <Typography
              text={ReactiveProp.Static(
                "Stepper, Drawer, Timeline, Sidebar, Topbar, AppLayout - Complete application layouts.",
              )}
              variant={Typography.P}
            />
          </div>,
        },
      ]}
      defaultOpen={["form"]}
    />
    // Next Steps
    <Typography text={ReactiveProp.Static("Next Steps")} variant={Typography.H2} />
    <div style="display: flex; flex-direction: column; gap: 1rem;">
      <Alert
        title="Explore Components"
        message={Signal.make(
          "Check out the API Reference to see all available components and their props.",
        )}
        variant={Alert.Info}
      />
      <Alert
        title="Theming"
        message={Signal.make(
          "Customize the look and feel using CSS variables. See src/styles/variables.css for available options.",
        )}
        variant={Alert.Success}
      />
      <Alert
        title="Examples"
        message={Signal.make(
          "View the Demo application (src/Demo.res) for comprehensive examples of all components.",
        )}
        variant={Alert.Warning}
      />
    </div>
  </div>
}

// Live form example component
module LiveFormExample = {
  @jsx.component
  let make = () => {
    let name = Signal.make("")
    let email = Signal.make("")
    let message = Signal.make("")
    let newsletter = Signal.make(false)

    <Card style="background-color: #f9fafb;">
      <Typography text={ReactiveProp.Static("Interactive Demo")} variant={Typography.H4} />
      <br />
      <Label text="Name" />
      <Input
        value={Reactive(name)}
        onInput={evt => {
          let target = Obj.magic(evt)["target"]
          Signal.set(name, target["value"])
        }}
        type_={Input.Text}
        placeholder="Enter your name"
      />
      <br />
      <Label text="Email" />
      <Input
        value={Reactive(email)}
        onInput={evt => {
          let target = Obj.magic(evt)["target"]
          Signal.set(email, target["value"])
        }}
        type_={Input.Email}
        placeholder="Enter your email"
      />
      <br />
      <Label text="Message" />
      <Textarea
        value={Reactive(message)}
        onInput={evt => {
          let target = Obj.magic(evt)["target"]
          Signal.set(message, target["value"])
        }}
        placeholder="Type a message..."
      />
      <br />
      <Checkbox
        checked={newsletter}
        onChange={_ => Signal.update(newsletter, v => !v)}
        label="Subscribe to newsletter"
      />
      <br />
      <Button
        label={Static("Submit")}
        onClick={_ => {
          Console.log("Form submitted!")
          Console.log2("Name:", Signal.get(name))
          Console.log2("Email:", Signal.get(email))
          Console.log2("Message:", Signal.get(message))
          Console.log2("Newsletter:", Signal.get(newsletter))
        }}
        variant={Button.Primary}
      />
      <Button
        label={Static("Reset")}
        onClick={_ => {
          Signal.set(name, "")
          Signal.set(email, "")
          Signal.set(message, "")
          Signal.set(newsletter, false)
        }}
        variant={Button.Secondary}
      />
      <Separator orientation={Separator.Horizontal} variant={Separator.Dashed} />
      <Typography
        text={ReactiveProp.Static("Form State (Live Updates):")} variant={Typography.H6}
      />
      <pre
        style="background-color: #1f2937; color: #f9fafb; padding: 1rem; border-radius: 0.25rem; overflow-x: auto; font-size: 0.875rem; margin-top: 0.5rem;"
      >
        {Component.textSignal(() => {
          `{
  name: "${Signal.get(name)}",
  email: "${Signal.get(email)}",
  message: "${Signal.get(message)}",
  newsletter: ${Signal.get(newsletter)->Bool.toString}
}`
        })}
      </pre>
    </Card>
  }
}

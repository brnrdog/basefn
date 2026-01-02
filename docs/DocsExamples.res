open Xote
open Basefn

type example = {
  title: string,
  description: string,
  demo: Component.node,
  code: string,
}

// Helper to get examples for a component
let getExamples = (componentName: string): array<example> => {
  open Component

  switch componentName {
  | "button" => [
      {
        title: "Button Variants",
        description: "Different button styles for various use cases.",
        demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
          <Button variant={Button.Primary}> {text("Primary")} </Button>
          <Button variant={Button.Secondary}> {text("Secondary")} </Button>
          <Button variant={Button.Ghost}> {text("Ghost")} </Button>
        </div>,
        code: `<Button variant={Button.Primary}> {text("Primary")} </Button>
<Button variant={Button.Secondary}> {text("Secondary")} </Button>
<Button variant={Button.Ghost}> {text("Ghost")} </Button>`,
      },
      {
        title: "Button with Click Handler",
        description: "Buttons can handle click events.",
        demo: {
          let count = Signal.make(0)
          let counterText = Computed.make(() => "Count: " ++ Int.toString(Signal.get(count)))
          <div style="display: flex; align-items: center; gap: 1rem;">
            <Button variant={Button.Primary} onClick={_ => Signal.update(count, c => c + 1)}>
              {text("Increment")}
            </Button>
            <Typography text={Reactive(counterText)} variant={Typography.H4} />
          </div>
        },
        code: `let count = Signal.make(0)
let counterText = Computed.make(() => "Count: " ++ Int.toString(Signal.get(count)))

<Typography text={counterText} variant={Typography.H4} />
<Button
  variant={Button.Primary}
  onClick={_ => Signal.update(count, c => c + 1)}
>
  {text("Increment")}
</Button>
`,
      },
      {
        title: "Reactive button attributes",
        description: "Button attributes can be static or it can react to signals.",
        demo: {
          let fetching = Signal.make(false)
          let onClick = event => {
            let _ = Basefn__Dom.preventDefault(event)
            Signal.set(fetching, true)
            let _ = setTimeout(() => {
              Signal.set(fetching, false)
            }, 1500)
          }

          <div style="display: flex; align-items: center; gap: 1rem;">
            <Button variant={Button.Primary} disabled={ReactiveProp.Reactive(fetching)} onClick>
              {textSignal(() =>
                Signal.get(fetching) ? "Data fetching..." : "Simulate data fetching"
              )}
            </Button>
          </div>
        },
        code: `let fetching = Signal.make(false)
let disabled = fetching

/* Simulate waiting for data fetching */
let onClick = event => {
  Basefn__Dom.preventDefault(event)
  Signal.set(fetching, true)
  let _ = setTimeout(() => {
    Signal.set(fetching, false)
  }, 1500)
}

<div style="display: flex; align-items: center; gap: 1rem;">
  <Button variant={Button.Primary} disabled onClick>
    {textSignal(() => Signal.get(fetching) ? "Loading data..." : "Load data")}
  </Button>
</div>
`,
      },
    ]

  | "badge" => [
      {
        title: "Badge Variants",
        description: "Different badge styles for status indicators.",
        demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center;">
          <Badge label={Signal.make("Default")} variant={Badge.Default} />
          <Badge label={Signal.make("Primary")} variant={Badge.Primary} />
          <Badge label={Signal.make("Success")} variant={Badge.Success} />
          <Badge label={Signal.make("Warning")} variant={Badge.Warning} />
        </div>,
        code: `<Badge label={Signal.make("Default")} variant={Badge.Default} />
<Badge label={Signal.make("Primary")} variant={Badge.Primary} />
<Badge label={Signal.make("Success")} variant={Badge.Success} />
<Badge label={Signal.make("Warning")} variant={Badge.Warning} />`,
      },
      {
        title: "Badge Sizes",
        description: "Badges come in small, medium, and large sizes.",
        demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: center;">
          <Badge label={Signal.make("Small")} size={Badge.Sm} variant={Badge.Primary} />
          <Badge label={Signal.make("Medium")} size={Badge.Md} variant={Badge.Primary} />
          <Badge label={Signal.make("Large")} size={Badge.Lg} variant={Badge.Primary} />
        </div>,
        code: `<Badge label={Signal.make("Small")} size={Badge.Sm} variant={Badge.Primary} />
<Badge label={Signal.make("Medium")} size={Badge.Md} variant={Badge.Primary} />
<Badge label={Signal.make("Large")} size={Badge.Lg} variant={Badge.Primary} />`,
      },
    ]

  | "card" => [
      {
        title: "Basic Card",
        description: "A simple card container for grouping content.",
        demo: <Card>
          <Typography text={ReactiveProp.Static("Card Title")} variant={Typography.H4} />
          <p style="margin: 1rem 0; color: #6b7280;">
            {Component.text("This is a basic card component. It can contain any content.")}
          </p>
          <Button label={Static("Call to Action")} />
        </Card>,
        code: `<Card>
  <Typography text={ReactiveProp.Static("Card Title")} variant={Typography.H4} />
  <p>{Component.text("This is a basic card component.")}</p>
</Card>`,
      },
    ]

  | "input" => [
      {
        title: "Input Types",
        description: "Different input types for various use cases.",
        demo: {
          let textValue = Signal.make("")
          let emailValue = Signal.make("")

          <div style="display: flex; flex-direction: column; gap:1rem;">
            <Input value={Reactive(textValue)} placeholder="Enter username" name="username" />
            <Input
              value={Reactive(emailValue)} placeholder="Enter email" type_=Input.Email name="email"
            />
          </div>
        },
        code: `let username = Signal.make("")
let email = Signal.make("")

<Input
  name="username"
  placeholder="Enter username" 
  value={username}
/>
<Input 
  value={email} 
  placeholder="Enter email" 
  type_=Input.Email 
  name="email" 
/>
        `,
      },
      {
        title: "Disabled state",
        description: "Disabled and other properties can be either static or reactive (signal).",
        demo: {
          let checked = Signal.make(false)
          let disabled = Computed.make(() => !Signal.get(checked))
          let onChange = e => {
            let v = Basefn__Dom.target(e)["checked"]
            Signal.set(checked, v)
          }

          <div style="display: flex; flex-direction: column; gap:2rem;">
            <Checkbox label="The button will only be enabled when checked" checked onChange />
            <div>
              <Button disabled={Reactive(disabled)}> {Component.text("Submit")} </Button>
            </div>
          </div>
        },
        code: `let checked = Signal.make(false)
let disabled = Computed.make(() => !Signal.get(checked))
let onChange = e => {
  let v = Basefn__Dom.target(e)["checked"]
  Signal.set(checked, v)
}

<div style="display: flex; flex-direction: column; gap:2rem;">
  <Checkbox label="The button will only be enabled when checked" checked onChange />
  <div>
    <Button disabled={Reactive(disabled)}> {Component.text("Submit")} </Button>
  </div>
</div>
        `,
      },
    ]

  | "alert" => [
      {
        title: "Alert Variants",
        description: "Different alert styles for various message types.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Alert
            title={"Info"}
            message={Signal.make("This is an informational message.")}
            variant={Alert.Info}
          />
          <Alert
            title={"Success"}
            message={Signal.make("Operation completed successfully!")}
            variant={Alert.Success}
          />
          <Alert
            title={"Warning"}
            message={Signal.make("Please review your settings.")}
            variant={Alert.Warning}
          />
          <Alert
            title={"Error"}
            message={Signal.make("An error occurred during the operation.")}
            variant={Alert.Error}
          />
        </div>,
        code: `<Alert
  title={Signal.make("Info")}
  message={Signal.make("This is an informational message.")}
  variant={Alert.Info}
/>
<Alert
  title={Signal.make("Success")}
  message={Signal.make("Operation completed successfully!")}
  variant={Alert.Success}
/>`,
      },
    ]

  | "tabs" => [
      {
        title: "Basic Tabs",
        description: "Organize content in tabbed sections.",
        demo: {
          <Tabs
            tabs={[
              {
                label: "Profile",
                value: "tab1",
                content: <div style="padding: 1rem;">
                  <Typography
                    text={ReactiveProp.Static("Profile Settings")} variant={Typography.H5}
                  />
                  <p> {Component.text("Manage your profile information here.")} </p>
                </div>,
              },
              {
                label: "Account",
                value: "tab2",
                content: <div style="padding: 1rem;">
                  <Typography
                    text={ReactiveProp.Static("Account Settings")} variant={Typography.H5}
                  />
                  <p> {Component.text("Manage your account settings here.")} </p>
                </div>,
              },
              {
                label: "Notifications",
                value: "tab3",
                content: <div style="padding: 1rem;">
                  <Typography
                    text={ReactiveProp.Static("Notification Preferences")} variant={Typography.H5}
                  />
                  <p> {Component.text("Configure your notification preferences.")} </p>
                </div>,
              },
            ]}
          />
        },
        code: `let activeTab = Signal.make("tab1")

<Tabs
  tabs={[
    {
      label: "Profile",
      value: "tab1",
      content: <div>Profile content</div>,
    },
    {
      label: "Account",
      value: "tab2",
      content: <div>Account content</div>,
    },
  ]}
/>`,
      },
    ]

  | "textarea" => [
      {
        title: "Basic Textarea",
        description: "Multi-line text input for longer content.",
        demo: {
          let value = Signal.make("")
          <div style="max-width: 400px;">
            <Label text="Message" required={true} />
            <Textarea value={Reactive(value)} placeholder="Enter your message..." />
          </div>
        },
        code: `let value = Signal.make("")

<Textarea
  value
  placeholder="Enter your message..."
/>`,
      },
      {
        title: "Controlled Textarea",
        description: "Textarea with character count.",
        demo: {
          let value = Signal.make("")
          let charCount = Computed.make(() => String.length(Signal.get(value)))
          let message = Computed.make(() => Signal.get(charCount)->Int.toString ++ " characters")
          <div style="max-width: 400px; display: flex; flex-direction: column; gap: 0.5rem;">
            <Textarea value={Reactive(value)} placeholder="Write something..." />
            <Typography text={Reactive(message)} variant={Typography.Small} />
          </div>
        },
        code: `let value = Signal.make("")
let charCount = Computed.make(() => String.length(Signal.get(value)))

<div>
  <Textarea value placeholder="Write something..." />
  <Typography text={charCount} variant={Typography.Small} />
</div>`,
      },
    ]

  | "select" => [
      {
        title: "Basic Select",
        description: "Dropdown selection from a list of options.",
        demo: {
          let value = Signal.make("option1")
          let options = Signal.make([
            {Select.value: "option1", label: "Option 1"},
            {value: "option2", label: "Option 2"},
            {value: "option3", label: "Option 3"},
          ])
          <div style="max-width: 300px;">
            <Label text="Choose an option" />
            <Select value options />
          </div>
        },
        code: `let value = Signal.make("option1")
let options = Signal.make([
  {value: "option1", label: "Option 1"},
  {value: "option2", label: "Option 2"},
  {value: "option3", label: "Option 3"},
])

<Select value options />`,
      },
      {
        title: "Select with Dynamic Options",
        description: "Dropdown with categories.",
        demo: {
          let value = Signal.make("apple")
          let options = Signal.make([
            {Select.value: "apple", label: "Apple"},
            {value: "banana", label: "Banana"},
            {value: "orange", label: "Orange"},
            {value: "grape", label: "Grape"},
          ])
          let selectedValue = Computed.make(() => Signal.get(value))

          let onClickOption = optionValue =>
            _evt => {
              Signal.set(value, optionValue)
            }

          <div style="max-width: 300px; display: flex; flex-direction: column; gap: 1rem;">
            <Select value options />
            <Typography
              text={ReactiveProp.Reactive(
                Computed.make(() => "Selected: " ++ Signal.get(selectedValue)),
              )}
              variant={Typography.Small}
            />
            <div style="display: flex; gap: 4rem;">
              <Button variant={Ghost} onClick={onClickOption("apple")}>
                {Component.text("🍎")}
              </Button>
              <Button variant={Ghost} onClick={onClickOption("banana")}>
                {Component.text("🍌")}
              </Button>
              <Button variant={Ghost} onClick={onClickOption("orange")}>
                {Component.text("🍊")}
              </Button>
              <Button variant={Ghost} onClick={onClickOption("grape")}>
                {Component.text("🍇")}
              </Button>
            </div>
          </div>
        },
        code: `let value = Signal.make("apple")
let options = Signal.make([
  {value: "apple", label: "Apple"},
  {value: "banana", label: "Banana"},
])

<Select value options />`,
      },
    ]

  | "checkbox" => [
      {
        title: "Basic Checkbox",
        description: "Toggle options on and off.",
        demo: {
          let checked = Signal.make(false)
          <div style="display: flex; flex-direction: column; gap: 1rem;">
            <Checkbox checked label="Accept terms and conditions" />
            <Checkbox checked={Signal.make(true)} label="Subscribe to newsletter" />
            <Checkbox checked={Signal.make(false)} label="Enable notifications" disabled={true} />
          </div>
        },
        code: `let checked = Signal.make(false)

<Checkbox checked label="Accept terms and conditions" />`,
      },
      {
        title: "Checkbox Group",
        description: "Multiple checkboxes for selecting options.",
        demo: {
          let option1 = Signal.make(true)
          let option2 = Signal.make(false)
          let option3 = Signal.make(true)
          <div style="display: flex; flex-direction: column; gap: 0.75rem;">
            <Typography text={ReactiveProp.Static("Select features:")} variant={Typography.H6} />
            <Checkbox checked={option1} label="Dark mode" />
            <Checkbox checked={option2} label="Email notifications" />
            <Checkbox checked={option3} label="Auto-save" />
          </div>
        },
        code: `let option1 = Signal.make(true)
let option2 = Signal.make(false)

<div>
  <Checkbox checked={option1} label="Dark mode" />
  <Checkbox checked={option2} label="Email notifications" />
</div>`,
      },
    ]

  | "radio" => [
      {
        title: "Radio Group",
        description: "Select a single option from multiple choices.",
        demo: {
          let selected = Signal.make("option1")
          <div style="display: flex; flex-direction: column; gap: 0.75rem;">
            <Typography text={ReactiveProp.Static("Choose a plan:")} variant={Typography.H6} />
            <Radio
              checked={Computed.make(() => Signal.get(selected) == "option1")}
              value="option1"
              label="Free"
              name="plan"
              onChange={_ => Signal.set(selected, "option1")}
            />
            <Radio
              checked={Computed.make(() => Signal.get(selected) == "option2")}
              value="option2"
              label="Pro"
              name="plan"
              onChange={_ => Signal.set(selected, "option2")}
            />
            <Radio
              checked={Computed.make(() => Signal.get(selected) == "option3")}
              value="option3"
              label="Enterprise"
              name="plan"
              onChange={_ => Signal.set(selected, "option3")}
            />
          </div>
        },
        code: `let selected = Signal.make("option1")

<Radio
  checked={Computed.make(() => Signal.get(selected) == "option1")}
  value="option1"
  label="Free"
  name="plan"
  onChange={_ => Signal.set(selected, "option1")}
/>`,
      },
    ]

  | "label" => [
      {
        title: "Basic Label",
        description: "Label for form inputs.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <div>
            <Label text="Email address" />
            <Input value={Static("")} placeholder="Enter email" type_=Input.Email />
          </div>
          <div>
            <Label text="Password" required={true} />
            <Input value={Static("")} placeholder="Enter password" type_=Input.Password />
          </div>
          <div>
            <Label text="Bio" required={true} />
            <Textarea value={Static("")} placeholder="Describe yourself in a few words..." />
          </div>
        </div>,
        code: `<Label text="Email address" />
<Input value={Signal.make("")} placeholder="Enter email" />

<Label text="Password" required={true} />
<Input value={Signal.make("")} placeholder="Enter password" />`,
      },
    ]

  | "typography" => [
      {
        title: "Typography Variants",
        description: "Different text styles for headings and content.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Typography text={ReactiveProp.Static("Heading 1")} variant={Typography.H1} />
          <Typography text={ReactiveProp.Static("Heading 2")} variant={Typography.H2} />
          <Typography text={ReactiveProp.Static("Heading 3")} variant={Typography.H3} />
          <Typography text={ReactiveProp.Static("Paragraph text")} variant={Typography.P} />
          <Typography
            text={ReactiveProp.Static("Lead text for introductions")} variant={Typography.Lead}
          />
          <Typography text={ReactiveProp.Static("Small text")} variant={Typography.Small} />
          <Typography text={ReactiveProp.Static("Muted text")} variant={Typography.Muted} />
          <Typography text={ReactiveProp.Static("inline code")} variant={Typography.Code} />
        </div>,
        code: `<Typography text={ReactiveProp.Static("Heading 1")} variant={Typography.H1} />
<Typography text={ReactiveProp.Static("Paragraph text")} variant={Typography.P} />
<Typography text={ReactiveProp.Static("Muted text")} variant={Typography.Muted} />`,
      },
      {
        title: "Text Alignment",
        description: "Control text alignment.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Typography text={ReactiveProp.Static("Left aligned")} align={Typography.Left} />
          <Typography text={ReactiveProp.Static("Center aligned")} align={Typography.Center} />
          <Typography text={ReactiveProp.Static("Right aligned")} align={Typography.Right} />
        </div>,
        code: `<Typography text={ReactiveProp.Static("Center aligned")} align={Typography.Center} />`,
      },
    ]

  | "spinner" => [
      {
        title: "Spinner Sizes",
        description: "Loading indicators in different sizes.",
        demo: <div style="display: flex; gap: 2rem; align-items: center;">
          <Spinner size={Spinner.Sm} />
          <Spinner size={Spinner.Md} />
          <Spinner size={Spinner.Lg} />
          <Spinner size={Spinner.Xl} />
        </div>,
        code: `<Spinner size={Spinner.Sm} />
<Spinner size={Spinner.Md} />
<Spinner size={Spinner.Lg} />`,
      },
      {
        title: "Spinner Variants with Labels",
        description: "Colored spinners with loading messages.",
        demo: <div style="display: flex; flex-direction: column; gap: 1.5rem;">
          <Spinner variant={Spinner.Default} label="Loading..." />
          <Spinner variant={Spinner.Primary} label="Processing..." />
          <Spinner variant={Spinner.Secondary} label="Please wait..." />
        </div>,
        code: `<Spinner variant={Spinner.Primary} label="Loading..." />`,
      },
    ]

  | "separator" => [
      {
        title: "Horizontal Separator",
        description: "Divide content sections horizontally.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Typography text={ReactiveProp.Static("Section 1")} variant={Typography.H5} />
          <Separator orientation={Separator.Horizontal} />
          <Typography text={ReactiveProp.Static("Section 2")} variant={Typography.H5} />
        </div>,
        code: `<Separator orientation={Separator.Horizontal} />`,
      },
      {
        title: "Vertical Separator",
        description: "Divide content sections vertically.",
        demo: <div style="display: flex; gap: 1rem; align-items: center; height: 100px;">
          <Typography text={ReactiveProp.Static("Left")} variant={Typography.P} />
          <Separator orientation={Separator.Vertical} />
          <Typography text={ReactiveProp.Static("Right")} variant={Typography.P} />
        </div>,
        code: `<Separator orientation={Separator.Vertical} />`,
      },
    ]

  | "kbd" => [
      {
        title: "Keyboard Shortcuts",
        description: "Display keyboard keys and shortcuts.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <div style="display: flex; gap: 0.5rem; align-items: center;">
            <Typography text={ReactiveProp.Static("Save:")} variant={Typography.P} />
            <Kbd keys={["Ctrl", "S"]->Signal.make} />
          </div>
          <div style="display: flex; gap: 0.5rem; align-items: center;">
            <Typography text={ReactiveProp.Static("Copy:")} variant={Typography.P} />
            <Kbd keys={["Ctrl", "C"]->Signal.make} />
          </div>
          <div style="display: flex; gap: 0.5rem; align-items: center;">
            <Typography text={ReactiveProp.Static("Undo:")} variant={Typography.P} />
            <Kbd keys={["Ctrl", "Z"]->Signal.make} />
          </div>
        </div>,
        code: `<Kbd keys={["Ctrl", "S"]->Signal.make} />
<Kbd keys={["Cmd", "Shift", "P"]->Signal.make} />`,
      },
      {
        title: "Kbd Sizes",
        description: "Different sizes for keyboard shortcuts.",
        demo: <div style="display: flex; gap: 1rem; align-items: center;">
          <Kbd keys={["Esc"]->Signal.make} size={Kbd.Sm} />
          <Kbd keys={["Enter"]->Signal.make} size={Kbd.Md} />
          <Kbd keys={["Tab"]->Signal.make} size={Kbd.Lg} />
        </div>,
        code: `<Kbd keys={["Esc"]->Signal.make} size={Kbd.Sm} />`,
      },
    ]

  | "avatar" => [
      {
        title: "Avatar Sizes",
        description: "User avatars in different sizes.",
        demo: <div style="display: flex; gap: 1rem; align-items: center;">
          <Avatar name="John Doe" size={Avatar.Sm} src="https://i.pravatar.cc" />
          <Avatar name="Jane Smith" size={Avatar.Md} src="https://i.pravatar.cc" />
          <Avatar name="Bob Johnson" size={Avatar.Lg} src="https://i.pravatar.cc" />
        </div>,
        code: `<Avatar name="John Doe" size={Avatar.Sm} />
<Avatar name="Jane Smith" size={Avatar.Md} />`,
      },
      {
        title: "Avatar with Image",
        description: "Avatar displaying profile images.",
        demo: <div style="display: flex; gap: 1rem;">
          <Avatar src="https://i.pravatar.cc" name="User 1" />
          <Avatar src="https://i.pravatar.cc" name="User 2" />
          <Avatar src="https://i.pravatar.cc" name="User 3" />
        </div>,
        code: `<Avatar src="https://i.pravatar.cc" name="User 1" />`,
      },
    ]

  | "grid" => [
      {
        title: "Basic Grid",
        description: "Responsive grid layout for organizing content.",
        demo: <Grid cols={3} gap="1rem">
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
        code: `<Grid cols={3} gap="1rem">
  <Card><Typography text={ReactiveProp.Static("Item 1")} variant={Typography.H5} /></Card>
  <Card><Typography text={ReactiveProp.Static("Item 2")} variant={Typography.H5} /></Card>
  <Card><Typography text={ReactiveProp.Static("Item 3")} variant={Typography.H5} /></Card>
</Grid>`,
      },
    ]

  | "progress" => [
      {
        title: "Progress Variants",
        description: "Progress bars with different colors.",
        demo: <div style="display: flex; flex-direction: column; gap: 1.5rem;">
          <div>
            <Typography text={ReactiveProp.Static("Default")} variant={Typography.Small} />
            <Progress value={Signal.make(45.0)} variant={Progress.Default} />
          </div>
          <div>
            <Typography text={ReactiveProp.Static("Primary")} variant={Typography.Small} />
            <Progress value={Signal.make(60.0)} variant={Progress.Primary} />
          </div>
          <div>
            <Typography text={ReactiveProp.Static("Success")} variant={Typography.Small} />
            <Progress value={Signal.make(75.0)} variant={Progress.Success} />
          </div>
          <div>
            <Typography text={ReactiveProp.Static("Warning")} variant={Typography.Small} />
            <Progress value={Signal.make(45.0)} variant={Progress.Warning} />
          </div>
          <div>
            <Typography text={ReactiveProp.Static("Error")} variant={Typography.Small} />
            <Progress value={Signal.make(30.0)} variant={Progress.Error} />
          </div>
        </div>,
        code: `<Progress value={Signal.make(60.0)} variant={Progress.Primary} />
<Progress value={Signal.make(75.0)} variant={Progress.Success} />`,
      },
      {
        title: "Progress Sizes",
        description: "Different sizes for progress bars.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Progress value={Signal.make(50.0)} size={Progress.Sm} />
          <Progress value={Signal.make(50.0)} size={Progress.Md} />
          <Progress value={Signal.make(50.0)} size={Progress.Lg} />
        </div>,
        code: `<Progress value={Signal.make(50.0)} size={Progress.Md} />`,
      },
    ]

  | "breadcrumb" => [
      {
        title: "Basic Breadcrumb",
        description: "Navigation breadcrumbs showing current location.",
        demo: <Breadcrumb
          items={[
            {label: "Home", href: Some("/"), onClick: None},
            {label: "Products", href: Some("/products"), onClick: None},
            {label: "Electronics", href: Some("/products/electronics"), onClick: None},
            {label: "Laptop", href: None, onClick: None},
          ]}
        />,
        code: `<Breadcrumb
  items={[
    {label: "Home", href: Some("/"), onClick: None},
    {label: "Products", href: Some("/products"), onClick: None},
    {label: "Laptop", href: None, onClick: None},
  ]}
/>`,
      },
    ]

  | "accordion" => [
      {
        title: "Basic Accordion",
        description: "Collapsible content panels.",
        demo: <Accordion
          items={[
            {
              value: "item1",
              title: "What is basefn-UI?",
              content: <p>
                {Component.text(
                  "basefn-UI is a modern ReScript UI component library built with Xote for fine-grained reactivity.",
                )}
              </p>,
            },
            {
              value: "item2",
              title: "How do I install it?",
              content: <p>
                {Component.text(
                  "You can install basefn-UI via npm or use it directly in your ReScript project.",
                )}
              </p>,
            },
            {
              value: "item3",
              title: "Is it free?",
              content: <p> {Component.text("Yes, basefn-UI is open source and free to use.")} </p>,
            },
          ]}
        />,
        code: `<Accordion
  items={[
    {
      value: "item1",
      title: "Question?",
      content: <p>{Component.text("Answer here")}</p>,
    },
  ]}
/>`,
      },
    ]

  | "modal" => [
      {
        title: "Basic Modal",
        description: "Display content in an overlay dialog.",
        demo: {
          let isOpen = Signal.make(false)
          <div>
            <Button label={Static("Open Modal")} onClick={_ => Signal.set(isOpen, true)} />
            <Modal isOpen onClose={() => Signal.set(isOpen, false)} title={"Welcome"}>
              <p>
                {Component.text(
                  "This is a modal dialog. Click outside or press the close button to dismiss.",
                )}
              </p>
            </Modal>
          </div>
        },
        code: `let isOpen = Signal.make(false)

<Button label={("Open Modal")} onClick={_ => Signal.set(isOpen, true)} />
<Modal isOpen onClose={() => Signal.set(isOpen, false)} title={"Welcome"}>
  <p>{Component.text("Modal content")}</p>
</Modal>`,
      },
      {
        title: "Modal Sizes",
        description: "Modals in different sizes.",
        demo: {
          let isSmOpen = Signal.make(false)
          let isMdOpen = Signal.make(false)
          let isLgOpen = Signal.make(false)
          <div style="display: flex; gap: 0.5rem;">
            <Button
              label={Static("Small")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isSmOpen, true)}
            />
            <Button
              label={Static("Medium")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isMdOpen, true)}
            />
            <Button
              label={Static("Large")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isLgOpen, true)}
            />
            <Modal
              isOpen={isSmOpen}
              onClose={() => Signal.set(isSmOpen, false)}
              title={"Small Modal"}
              size={Modal.Sm}
            >
              <p> {Component.text("Small modal content.")} </p>
            </Modal>
            <Modal
              isOpen={isMdOpen}
              onClose={() => Signal.set(isMdOpen, false)}
              title={"Medium Modal"}
              size={Modal.Md}
            >
              <p> {Component.text("Medium modal content.")} </p>
            </Modal>
            <Modal
              isOpen={isLgOpen}
              onClose={() => Signal.set(isLgOpen, false)}
              title={"Large Modal"}
              size={Modal.Lg}
            >
              <p> {Component.text("Large modal content.")} </p>
            </Modal>
          </div>
        },
        code: `<Modal isOpen onClose={onClose} title={"Title"} size={Modal.Lg}>
  <p>{Component.text("Content")}</p>
</Modal>`,
      },
    ]

  | "switch" => [
      {
        title: "Basic Switch",
        description: "Toggle between on and off states.",
        demo: {
          let isEnabled = Signal.make(false)
          <div style="display: flex; flex-direction: column; gap: 1rem;">
            <Switch checked={isEnabled} label="Enable notifications" />
            <Switch checked={Signal.make(true)} label="Dark mode" />
            <Switch checked={Signal.make(false)} label="Auto-save" disabled={true} />
          </div>
        },
        code: `let isEnabled = Signal.make(false)

<Switch checked={isEnabled} label="Enable notifications" />`,
      },
      {
        title: "Switch Sizes",
        description: "Switches in different sizes.",
        demo: <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Switch checked={Signal.make(true)} label="Small" size={Switch.Sm} />
          <Switch checked={Signal.make(true)} label="Medium" size={Switch.Md} />
          <Switch checked={Signal.make(true)} label="Large" size={Switch.Lg} />
        </div>,
        code: `<Switch checked={Signal.make(true)} label="Medium" size={Switch.Md} />`,
      },
    ]

  | "slider" => [
      {
        title: "Basic Slider",
        description: "Select a value from a range.",
        demo: {
          let value = Signal.make(50.0)
          <Slider value label="Volume" min={0.0} max={100.0} />
        },
        code: `let value = Signal.make(50.0)

<Slider value label="Volume" min={0.0} max={100.0} />`,
      },
      {
        title: "Slider with Markers",
        description: "Slider with labeled markers.",
        demo: {
          let value = Signal.make(2.0)
          <Slider
            value
            label="Quality"
            min={0.0}
            max={4.0}
            step={1.0}
            markers={["Low", "Med", "High", "Max", "Ultra"]}
          />
        },
        code: `let value = Signal.make(2.0)

<Slider value label="Quality" min={0.0} max={4.0} step={1.0} markers={["Low", "Med", "High", "Max", "Ultra"]} />`,
      },
    ]

  | "tooltip" => [
      {
        title: "Tooltip Positions",
        description: "Show helpful hints on hover.",
        demo: <div style="display: flex; gap: 2rem; justify-content: center; padding: 3rem;">
          <Tooltip content="Tooltip on top" position={Tooltip.Top}>
            <Button label={Static("Top")} variant={Button.Ghost} />
          </Tooltip>
          <Tooltip content="Tooltip on bottom" position={Tooltip.Bottom}>
            <Button label={Static("Bottom")} variant={Button.Ghost} />
          </Tooltip>
          <Tooltip content="Tooltip on left" position={Tooltip.Left}>
            <Button label={Static("Left")} variant={Button.Ghost} />
          </Tooltip>
          <Tooltip content="Tooltip on right" position={Tooltip.Right}>
            <Button label={Static("Right")} variant={Button.Ghost} />
          </Tooltip>
        </div>,
        code: `<Tooltip content="Helpful hint" position={Tooltip.Top}>
  <Button label={("Hover me")} />
</Tooltip>`,
      },
    ]

  | "dropdown" => [
      {
        title: "Basic Dropdown",
        description: "Menu with multiple actions.",
        demo: <Dropdown
          trigger={<Button label={Static("Actions")} variant={Button.Secondary} />}
          items={[
            Item({label: "Edit", onClick: () => ()}),
            Item({label: "Duplicate", onClick: () => ()}),
            Separator,
            Item({label: "Delete", onClick: () => (), danger: true}),
          ]}
        />,
        code: `<Dropdown
  trigger={<Button label={("Actions")} />}
  items={[
    Item({label: "Edit", onClick: () => ()}),
    Item({label: "Delete", onClick: () => (), danger: true}),
  ]}
/>`,
      },
    ]

  | "toast" => [
      {
        title: "Toast Notifications",
        description: "Temporary notification messages.",
        demo: {
          let showSuccess = Signal.make(false)
          let showError = Signal.make(false)
          let showWarning = Signal.make(false)
          <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
            <Button
              label={Static("Success")}
              variant={Button.Primary}
              onClick={_ => Signal.set(showSuccess, true)}
            />
            <Button
              label={Static("Error")}
              variant={Button.Secondary}
              onClick={_ => Signal.set(showError, true)}
            />
            <Button
              label={Static("Warning")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(showWarning, true)}
            />
            <Toast
              isVisible={showSuccess}
              onClose={() => Signal.set(showSuccess, false)}
              title={"Success"}
              message="Operation completed successfully!"
              variant={Toast.Success}
            />
            <Toast
              isVisible={showError}
              onClose={() => Signal.set(showError, false)}
              title={"Error"}
              message="Something went wrong."
              variant={Toast.Error}
            />
            <Toast
              isVisible={showWarning}
              onClose={() => Signal.set(showWarning, false)}
              title={"Warning"}
              message="Please review your changes."
              variant={Toast.Warning}
            />
          </div>
        },
        code: `let isVisible = Signal.make(false)

<Button label={("Show Toast")} onClick={_ => Signal.set(isVisible, true)} />
<Toast
  isVisible
  onClose={() => Signal.set(isVisible, false)}
  title={"Success"}
  message="Operation completed!"
  variant={Toast.Success}
/>`,
      },
    ]

  | "stepper" => [
      {
        title: "Horizontal Stepper",
        description: "Guide users through a multi-step process.",
        demo: {
          let currentStep = Signal.make(1)
          <div style="display: flex; flex-direction: column; gap: 1.5rem;">
            <Stepper
              steps={[
                {
                  title: "Account Details",
                  description: Some("Enter your personal information"),
                  status: Stepper.Completed,
                },
                {
                  title: "Verification",
                  description: Some("Verify your email address"),
                  status: Stepper.Active,
                },
                {
                  title: "Preferences",
                  description: Some("Customize your settings"),
                  status: Stepper.Inactive,
                },
                {
                  title: "Complete",
                  description: Some("Review and finish setup"),
                  status: Stepper.Inactive,
                },
              ]}
              currentStep={currentStep}
              orientation={Stepper.Horizontal}
            />
            <div style="display: flex; gap: 0.5rem; justify-content: center;">
              <Button
                label={Static("Previous")}
                variant={Button.Secondary}
                onClick={_ => Signal.update(currentStep, step => step > 0 ? step - 1 : step)}
              />
              <Button
                label={Static("Next")}
                variant={Button.Primary}
                onClick={_ => Signal.update(currentStep, step => step < 3 ? step + 1 : step)}
              />
            </div>
          </div>
        },
        code: `let currentStep = Signal.make(1)

<Stepper
  steps={[
    {
      title: "Account Details",
      description: Some("Enter your personal information"),
      status: Stepper.Completed,
    },
    {
      title: "Verification",
      description: Some("Verify your email address"),
      status: Stepper.Active,
    },
  ]}
  currentStep={currentStep}
  orientation={Stepper.Horizontal}
/>`,
      },
      {
        title: "Vertical Stepper",
        description: "Vertical layout for detailed step content.",
        demo: {
          let currentStep = Signal.make(0)
          <Stepper
            steps={[
              {
                title: "Create Account",
                description: Some("Sign up with your email"),
                status: Stepper.Active,
              },
              {
                title: "Verify Email",
                description: Some("Check your inbox for verification link"),
                status: Stepper.Inactive,
              },
              {
                title: "Complete Profile",
                description: Some("Add your profile information"),
                status: Stepper.Inactive,
              },
            ]}
            currentStep={currentStep}
            orientation={Stepper.Vertical}
          />
        },
        code: `<Stepper
  steps={[
    {
      title: "Create Account",
      description: Some("Sign up with your email"),
      status: Stepper.Active,
    },
    {
      title: "Verify Email",
      description: Some("Check your inbox"),
      status: Stepper.Inactive,
    },
  ]}
  orientation={Stepper.Vertical}
/>`,
      },
    ]

  | "drawer" => [
      {
        title: "Drawer Positions",
        description: "Drawers can slide in from any edge of the screen.",
        demo: {
          let isRightOpen = Signal.make(false)
          let isLeftOpen = Signal.make(false)
          <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
            <Button
              label={Static("Open Righ)t Drawer")}
              variant={Button.Primary}
              onClick={_ => Signal.set(isRightOpen, true)}
            />
            <Button
              label={Static("Open Lef)t Drawer")}
              variant={Button.Secondary}
              onClick={_ => Signal.set(isLeftOpen, true)}
            />
            <Drawer
              isOpen={isRightOpen}
              onClose={() => Signal.set(isRightOpen, false)}
              position={Drawer.Right}
              title={"Settings"}
            >
              <div style="display: flex; flex-direction: column; gap: 1rem;">
                <Typography text={ReactiveProp.Static("Drawer Content")} variant={Typography.H5} />
                <p> {Component.text("This drawer slides in from the right side.")} </p>
              </div>
            </Drawer>
            <Drawer
              isOpen={isLeftOpen}
              onClose={() => Signal.set(isLeftOpen, false)}
              position={Drawer.Left}
              title={"Navigation"}
            >
              <div style="display: flex; flex-direction: column; gap: 1rem;">
                <Typography text={ReactiveProp.Static("Menu Items")} variant={Typography.H5} />
                <p> {Component.text("This drawer slides in from the left side.")} </p>
              </div>
            </Drawer>
          </div>
        },
        code: `let isOpen = Signal.make(false)

<Button
  label={Signal.make("Open Drawer")}
  onClick={_ => Signal.set(isOpen, true)}
/>

<Drawer
  isOpen={isOpen}
  onClose={() => Signal.set(isOpen, false)}
  position={Drawer.Right}
  title={"Settings"}
>
  <p>{Component.text("Drawer content")}</p>
</Drawer>`,
      },
      {
        title: "Drawer Sizes",
        description: "Control drawer width with size variants.",
        demo: {
          let isSmallOpen = Signal.make(false)
          let isMediumOpen = Signal.make(false)
          let isLargeOpen = Signal.make(false)
          <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
            <Button
              label={Static("Small")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isSmallOpen, true)}
            />
            <Button
              label={Static("Medium")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isMediumOpen, true)}
            />
            <Button
              label={Static("Large")}
              variant={Button.Ghost}
              onClick={_ => Signal.set(isLargeOpen, true)}
            />
            <Drawer
              isOpen={isSmallOpen}
              onClose={() => Signal.set(isSmallOpen, false)}
              size={Drawer.Sm}
              title={"Small Drawer"}
            >
              <p> {Component.text("This is a small drawer (240px).")} </p>
            </Drawer>
            <Drawer
              isOpen={isMediumOpen}
              onClose={() => Signal.set(isMediumOpen, false)}
              size={Drawer.Md}
              title={"Medium Drawer"}
            >
              <p> {Component.text("This is a medium drawer (320px).")} </p>
            </Drawer>
            <Drawer
              isOpen={isLargeOpen}
              onClose={() => Signal.set(isLargeOpen, false)}
              size={Drawer.Lg}
              title={"Large Drawer"}
            >
              <p> {Component.text("This is a large drawer (480px).")} </p>
            </Drawer>
          </div>
        },
        code: `<Drawer
  isOpen={isOpen}
  onClose={() => Signal.set(isOpen, false)}
  size={Drawer.Sm}
  title={"Small Drawer"}
>
  <p>{Component.text("Content")}</p>
</Drawer>`,
      },
    ]

  | "timeline" => [
      {
        title: "Vertical Timeline",
        description: "Display events in chronological order.",
        demo: <Timeline
          items={[
            {
              title: "Project Created",
              timestamp: Some("2 hours ago"),
              description: Some("Initial project setup and configuration"),
              variant: Timeline.Success,
              icon: Some("\u2713"),
            },
            {
              title: "First Commit",
              timestamp: Some("1 hour ago"),
              description: Some("Added basic component structure"),
              variant: Timeline.Primary,
              icon: None,
            },
            {
              title: "Deploy to Staging",
              timestamp: Some("30 minutes ago"),
              description: Some("Deployed latest changes to staging environment"),
              variant: Timeline.Warning,
              icon: None,
            },
            {
              title: "Production Release",
              timestamp: Some("Pending"),
              description: Some("Awaiting final approval"),
              variant: Timeline.Default,
              icon: None,
            },
          ]}
          orientation={Timeline.Vertical}
        />,
        code: `<Timeline
  items={[
    {
      title: "Project Created",
      timestamp: Some("2 hours ago"),
      description: Some("Initial setup"),
      variant: Timeline.Success,
      icon: Some("\u2713"),
    },
    {
      title: "First Commit",
      timestamp: Some("1 hour ago"),
      description: Some("Added components"),
      variant: Timeline.Primary,
      icon: None,
    },
  ]}
  orientation={Timeline.Vertical}
/>`,
      },
      {
        title: "Timeline Variants",
        description: "Different color variants for timeline items.",
        demo: <Timeline
          items={[
            {
              title: "Success Event",
              timestamp: None,
              description: Some("Operation completed successfully"),
              variant: Timeline.Success,
              icon: Some("\u2713"),
            },
            {
              title: "Warning Event",
              timestamp: None,
              description: Some("Action requires attention"),
              variant: Timeline.Warning,
              icon: Some("!"),
            },
            {
              title: "Error Event",
              timestamp: None,
              description: Some("An error occurred"),
              variant: Timeline.Error,
              icon: Some("\u00d7"),
            },
          ]}
          orientation={Timeline.Vertical}
        />,
        code: `<Timeline
  items={[
    {
      title: "Success",
      variant: Timeline.Success,
      icon: Some("\u2713"),
    },
    {
      title: "Warning",
      variant: Timeline.Warning,
      icon: Some("!"),
    },
  ]}
/>`,
      },
    ]

  | "sidebar" => [
      {
        title: "Dark Sidebar",
        description: "Navigation sidebar with dark theme.",
        demo: {
          let activePage = Signal.make("dashboard")
          <div
            style="height: 400px; background: #f9fafb; border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;"
          >
            <Sidebar
              logo={<div> {Component.text("MyApp")} </div>}
              sections={[
                {
                  title: None,
                  items: [
                    {
                      label: "Dashboard",
                      icon: Some("\u{1F4CA}"),
                      active: Signal.get(activePage) == "dashboard",
                      onClick: () => Signal.set(activePage, "dashboard"),
                    },
                    {
                      label: "Projects",
                      icon: Some("\u{1F4C1}"),
                      active: Signal.get(activePage) == "projects",
                      onClick: () => Signal.set(activePage, "projects"),
                    },
                  ],
                },
                {
                  title: Some("Settings"),
                  items: [
                    {
                      label: "Profile",
                      icon: Some("\u{1F464}"),
                      active: Signal.get(activePage) == "profile",
                      onClick: () => Signal.set(activePage, "profile"),
                    },
                    {
                      label: "Preferences",
                      icon: Some("\u2699\uFE0F"),
                      active: Signal.get(activePage) == "preferences",
                      onClick: () => Signal.set(activePage, "preferences"),
                    },
                  ],
                },
              ]}
              footer={<div style="font-size: 0.75rem; color: #9ca3af;">
                {Component.text("v1.0.0")}
              </div>}
            />
          </div>
        },
        code: `let activePage = Signal.make("dashboard")

<Sidebar
  logo={Some(<div>{Component.text("MyApp")}</div>)}
  theme={Sidebar.Dark}
  sections={[
    {
      title: None,
      items: [
        {
          label: "Dashboard",
          icon: Some("\u{1F4CA}"),
          active: Signal.get(activePage) == "dashboard",
          onClick: () => Signal.set(activePage, "dashboard"),
        },
      ],
    },
  ]}
/>`,
      },
      {
        title: "Light Sidebar",
        description: "Sidebar with light theme variant.",
        demo: {
          let activePage = Signal.make("home")
          <div
            style="height: 400px; background: #1f2937; border: 1px solid #374151; border-radius: 0.5rem; overflow: hidden;"
          >
            <Sidebar
              logo={<div> {Component.text("Dashboard")} </div>}
              size={Sidebar.Md}
              sections={[
                {
                  title: Some("Main"),
                  items: [
                    {
                      label: "Home",
                      icon: Some("\u{1F3E0}"),
                      active: Signal.get(activePage) == "home",
                      onClick: () => Signal.set(activePage, "home"),
                    },
                    {
                      label: "Analytics",
                      icon: Some("\u{1F4C8}"),
                      active: Signal.get(activePage) == "analytics",
                      onClick: () => Signal.set(activePage, "analytics"),
                    },
                    {
                      label: "Reports",
                      icon: Some("\u{1F4CB}"),
                      active: Signal.get(activePage) == "reports",
                      onClick: () => Signal.set(activePage, "reports"),
                    },
                  ],
                },
              ]}
            />
          </div>
        },
        code: `<Sidebar
  logo={Some(<div>{Component.text("Dashboard")}</div>)}
  theme={Sidebar.Light}
  sections={[
    {
      title: Some("Main"),
      items: [
        {label: "Home", icon: Some("\u{1F3E0}"), active: true, onClick: () => ()},
        {label: "Analytics", icon: Some("\u{1F4C8}"), active: false, onClick: () => ()},
      ],
    },
  ]}
/>`,
      },
    ]

  | "topbar" => [
      {
        title: "Light Topbar",
        description: "Application header with navigation.",
        demo: {
          let activeNav = Signal.make("home")
          <div style="border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;">
            <Topbar
              logo={<div> {Component.text("Brand")} </div>}
              navItems={[
                {
                  label: "Home",
                  active: Signal.get(activeNav) == "home",
                  onClick: () => Signal.set(activeNav, "home"),
                },
                {
                  label: "Features",
                  active: Signal.get(activeNav) == "features",
                  onClick: () => Signal.set(activeNav, "features"),
                },
                {
                  label: "Pricing",
                  active: Signal.get(activeNav) == "pricing",
                  onClick: () => Signal.set(activeNav, "pricing"),
                },
              ]}
              rightContent={<div style="display: flex; gap: 0.5rem;">
                <Button label={Static("Login")} variant={Button.Ghost} />
                <Button label={Static("Sign Up")} variant={Button.Primary} />
              </div>}
            />
          </div>
        },
        code: `let activeNav = Signal.make("home")

<Topbar
  logo={Some(<div>{Component.text("Brand")}</div>)}
  theme={Topbar.Light}
  navItems={Some([
    {
      label: "Home",
      active: Signal.get(activeNav) == "home",
      onClick: () => Signal.set(activeNav, "home"),
    },
    {label: "Features", active: false, onClick: () => ()},
  ])}
  rightContent={Some(<Button label={Signal.make("Login")} />)}
/>`,
      },
      {
        title: "Dark Topbar with Menu",
        description: "Dark themed topbar with menu button.",
        demo: {
          let menuOpen = Signal.make(false)
          <div style="border: 1px solid #374151; border-radius: 0.5rem; overflow: hidden;">
            <Topbar
              logo={<div> {Component.text("App")} </div>}
              size={Topbar.Md}
              onMenuClick={() => Signal.update(menuOpen, m => !m)}
              rightContent={<div style="display: flex; gap: 0.75rem; align-items: center;">
                <Badge label={Signal.make("3")} variant={Badge.Primary} size={Badge.Sm} />
                <Avatar size={Avatar.Sm} name="User" />
              </div>}
            />
          </div>
        },
        code: `let menuOpen = Signal.make(false)

<Topbar
  logo={Some(<div>{Component.text("App")}</div>)}
  theme={Topbar.Dark}
  onMenuClick={Some(() => Signal.update(menuOpen, m => !m))}
  rightContent={Some(
    <div style="display: flex; gap: 0.75rem;">
      <Badge label={Signal.make("3")} variant={Badge.Primary} />
      <Avatar size={Avatar.Sm} name="User" />
    </div>
  )}
/>`,
      },
    ]

  | "app-layout" => [
      {
        title: "Complete App Layout",
        description: "Full application layout with sidebar and topbar.",
        demo: {
          let activePage = Signal.make("dashboard")
          let activeNav = Signal.make("overview")
          <div
            style="position: relative; height: 500px; border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;"
          >
            <AppLayout
              sidebar={<Sidebar
                logo={<div> {Component.text("MyApp")} </div>}
                size={Sidebar.Md}
                sections={[
                  {
                    title: None,
                    items: [
                      {
                        label: "Dashboard",
                        icon: Some("\u{1F4CA}"),
                        active: Signal.get(activePage) == "dashboard",
                        onClick: () => Signal.set(activePage, "dashboard"),
                      },
                      {
                        label: "Users",
                        icon: Some("\u{1F464}"),
                        active: Signal.get(activePage) == "users",
                        onClick: () => Signal.set(activePage, "users"),
                      },
                    ],
                  },
                ]}
              />}
              topbar={<Topbar
                navItems={[
                  {
                    label: "Overview",
                    active: Signal.get(activeNav) == "overview",
                    onClick: () => Signal.set(activeNav, "overview"),
                  },
                  {
                    label: "Analytics",
                    active: Signal.get(activeNav) == "analytics",
                    onClick: () => Signal.set(activeNav, "analytics"),
                  },
                ]}
                rightContent={<Avatar size={Avatar.Sm} name="User" />}
              />}
              contentWidth={AppLayout.Contained}
            >
              <Card>
                <Typography
                  text={ReactiveProp.Static("Welcome to your dashboard!")} variant={Typography.H4}
                />
                <p style="margin-top: 1rem; color: #6b7280;">
                  {Component.text("This is a complete application layout example.")}
                </p>
              </Card>
            </AppLayout>
          </div>
        },
        code: `<AppLayout
  sidebar={Some(
    <Sidebar
      logo={Some(<div>{Component.text("MyApp")}</div>)}
      sections={[...]}
    />
  )}
  topbar={Some(
    <Topbar
      navItems={Some([...])}
      rightContent={Some(<Avatar name="User" />)}
    />
  )}
  contentWidth={AppLayout.Contained}
>
  <Card>
    <Typography text={ReactiveProp.Static("Content")} variant={Typography.H4} />
  </Card>
</AppLayout>`,
      },
      {
        title: "Simple Layout",
        description: "Layout with topbar only.",
        demo: <div
          style="position: relative; height: 300px; border: 1px solid #e5e7eb; border-radius: 0.5rem; overflow: hidden;"
        >
          <AppLayout
            topbar={<Topbar
              logo={<div> {Component.text("Simple App")} </div>}
              rightContent={<Button label={Static("Get Starte")} variant={Button.Primary} />}
            />}
            contentWidth={AppLayout.FullWidth}
            noPadding={false}
          >
            <div style="padding: 2rem;">
              <Typography
                text={ReactiveProp.Static("Simple layout without sidebar")} variant={Typography.H3}
              />
              <p style="margin-top: 1rem; color: #6b7280;">
                {Component.text("Perfect for landing pages and simple applications.")}
              </p>
            </div>
          </AppLayout>
        </div>,
        code: `<AppLayout
  topbar={Some(
    <Topbar
      logo={Some(<div>{Component.text("App")}</div>)}
      rightContent={Some(<Button label={Signal.make("Start")} />)}
    />
  )}
  contentWidth={AppLayout.FullWidth}
>
  <div>
    <Typography text={ReactiveProp.Static("Content")} variant={Typography.H3} />
  </div>
</AppLayout>`,
      },
    ]

  | _ => [
      {
        title: "Component Examples Coming Soon",
        description: "Documentation for this component is being prepared.",
        demo: <div style="padding: 2rem; text-align: center;">
          <Typography
            text={ReactiveProp.Static("Examples coming soon...")} variant={Typography.Muted}
          />
        </div>,
        code: `// Examples for this component will be added soon`,
      },
    ]
  }
}

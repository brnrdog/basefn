open Xote
open Eita

type example = {
  title: string,
  description: string,
  demo: Component.node,
  code: string,
}

// Helper to get examples for a component
let getExamples = (componentName: string): array<example> => {
  switch componentName {
  | "button" => [
      {
        title: "Button Variants",
        description: "Different button styles for various use cases.",
        demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
          <Button label={Signal.make("Primary")} variant={Button.Primary} />
          <Button label={Signal.make("Secondary")} variant={Button.Secondary} />
          <Button label={Signal.make("Ghost")} variant={Button.Ghost} />
        </div>,
        code: `<Button label={Signal.make("Primary")} variant={Button.Primary} />
<Button label={Signal.make("Secondary")} variant={Button.Secondary} />`,
      },
      {
        title: "Button with Click Handler",
        description: "Buttons can handle click events.",
        demo: {
          let count = Signal.make(0)
          <div style="display: flex; flex-direction: column; align-items: center; gap: 1rem;">
            <Typography
              text={Computed.make(() => "Count: " ++ Int.toString(Signal.get(count)))}
              variant={Typography.H4}
            />
            <Button
              label={Signal.make("Increment")}
              variant={Button.Primary}
              onClick={_ => Signal.update(count, c => c + 1)}
            />
          </div>
        },
        code: `let count = Signal.make(0)

<div>
  <Typography
    text={Computed.make(() =>
      Signal.make("Count: " ++ Int.toString(Signal.get(count)))
    )}
    variant={Typography.H4}
  />
  <Button
    label={Signal.make("Increment")}
    variant={Button.Primary}
    onClick={_ => Signal.update(count, c => c + 1)}
  />
</div>`,
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
          <Typography text={Signal.make("Card Title")} variant={Typography.H4} />
          <p style="margin: 0.5rem 0 0 0; color: #6b7280;">
            {Component.text("This is a basic card component. It can contain any content.")}
          </p>
        </Card>,
        code: `<Card>
  <Typography text={Signal.make("Card Title")} variant={Typography.H4} />
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
          let passwordValue = Signal.make("")

          <div style="display: flex; flex-direction: column; gap: 1rem; max-width: 400px;">
            <Input value={textValue} placeholder="Enter text" type_=Input.Text />
            <Input value={emailValue} placeholder="Enter email" type_=Input.Email />
            <Input value={passwordValue} placeholder={"Enter password"} type_={Input.Password} />
          </div>
        },
        code: `let textValue = Signal.make("")
let emailValue = Signal.make("")
let passwordValue = Signal.make("")

<Input
  value={textValue}
  placeholder={Signal.make("Enter text")}
  inputType={Input.Text}
/>
<Input
  value={emailValue}
  placeholder={Signal.make("Enter email")}
  inputType={Input.Email}
/>
<Input
  value={passwordValue}
  placeholder={Signal.make("Enter password")}
  inputType={Input.Password}
/>`,
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
          let activeTab = Signal.make("tab1")
          <Tabs
            tabs={[
              {
                label: "Profile",
                value: "tab1",
                content: <div style="padding: 1rem;">
                  <Typography text={Signal.make("Profile Settings")} variant={Typography.H5} />
                  <p> {Component.text("Manage your profile information here.")} </p>
                </div>,
              },
              {
                label: "Account",
                value: "tab2",
                content: <div style="padding: 1rem;">
                  <Typography text={Signal.make("Account Settings")} variant={Typography.H5} />
                  <p> {Component.text("Manage your account settings here.")} </p>
                </div>,
              },
              {
                label: "Notifications",
                value: "tab3",
                content: <div style="padding: 1rem;">
                  <Typography
                    text={Signal.make("Notification Preferences")} variant={Typography.H5}
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

  | _ => [
      {
        title: "Component Examples Coming Soon",
        description: "Documentation for this component is being prepared.",
        demo: <div style="padding: 2rem; text-align: center;">
          <Typography text={Signal.make("Examples coming soon...")} variant={Typography.Muted} />
        </div>,
        code: `// Examples for this component will be added soon`,
      },
    ]
  }
}

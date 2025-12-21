// Demo application showcasing Eita-UI components

%%raw(`import './styles/variables.css'`)
%%raw(`import './Eita.css'`)

open Xote
open Eita
open Signals

@get external target: Dom.event => Dom.element = "target"
@set external setValue: (Dom.element, string) => unit = "value"
@get external key: Dom.event => string = "key"

@get external value: Dom.element => string = "value"
@send external preventDefault: Dom.event => unit = "preventDefault"

module Demo = {
  @jsx.component
  let make = () => {
    // Form state using signals
    let name = Signal.make("")
    let email = Signal.make("")
    let password = Signal.make("")
    let message = Signal.make("")
    let agreeToTerms = Signal.make(false)
    let newsletter = Signal.make(false)
    let selectedOption = Signal.make("option1")
    let selectedColor = Signal.make("blue")
    let isSubmitting = Signal.make(false)
    let downloadProgress = Signal.make(65.0)

    // Tier 3 component states
    let isModalOpen = Signal.make(false)
    let sliderValue = Signal.make(50.0)
    let switchEnabled = Signal.make(false)
    let darkModeSwitch = Signal.make(true)
    let notificationsSwitch = Signal.make(false)
    let toastVisible = Signal.make(false)

    // Event handlers
    let handleNameChange = evt => {
      let target = Obj.magic(evt)["target"]
      Signal.set(name, target["value"])
    }

    let handleEmailChange = evt => {
      let target = Obj.magic(evt)["target"]
      Signal.set(email, target["value"])
    }

    let handlePasswordChange = evt => {
      let target = Obj.magic(evt)["target"]
      Signal.set(password, target["value"])
    }

    let handleMessageChange = evt => {
      let target = Obj.magic(evt)["target"]
      Signal.set(message, target["value"])
    }

    let handleTermsChange = _evt => {
      Signal.update(agreeToTerms, prev => !prev)
    }

    let handleNewsletterChange = _evt => {
      Signal.update(newsletter, prev => !prev)
    }

    let handleColorChange = evt => {
      let target = Obj.magic(evt)["target"]
      Signal.set(selectedColor, target["value"])
    }

    let handleSubmit = _evt => {
      Signal.set(isSubmitting, true)
      Console.log("=== Form Submission ===")
      Console.log(`Name: ${Signal.get(name)}`)
      Console.log(`Email: ${Signal.get(email)}`)
      Console.log(`Password: ${Signal.get(password)}`)
      Console.log(`Message: ${Signal.get(message)}`)
      Console.log(`Selected Option: ${Signal.get(selectedOption)}`)
      Console.log(`Selected Color: ${Signal.get(selectedColor)}`)
      Console.log(`Agree to Terms: ${Signal.get(agreeToTerms)->Bool.toString}`)
      Console.log(`Newsletter: ${Signal.get(newsletter)->Bool.toString}`)

      // Simulate API call
      setTimeout(() => {
        Signal.set(isSubmitting, false)
        Console.log("Form submitted successfully!")
      }, 2000)->ignore
    }

    let handleReset = _evt => {
      Signal.set(name, "")
      Signal.set(email, "")
      Signal.set(password, "")
      Signal.set(message, "")
      Signal.set(agreeToTerms, false)
      Signal.set(newsletter, false)
      Signal.set(selectedOption, "option1")
      Signal.set(selectedColor, "blue")
      Console.log("Form reset")
    }

    let selectOptions: array<selectOption> = [
      {value: "option1", label: "Web Development"},
      {value: "option2", label: "Mobile Development"},
      {value: "option3", label: "UI/UX Design"},
      {value: "option4", label: "Other"},
    ]
    let selectOptionsSignal = Signal.make(selectOptions)

    <>
      {Component.textSignal(() => Signal.get(selectedOption))}
      <h1> {Component.text("Eita-UI Component Library")} </h1>
      <p style="color: #6b7280; margin-bottom: 2rem;">
        {Component.text(
          "A demonstration of all form components with both static and reactive values.",
        )}
      </p>

      <Card style="margin-bottom: 2rem;">
        <Grid>
          <Avatar src="https://upload.wikimedia.org/wikipedia/commons/a/ad/Schopfkarakara.jpg" />
          <div>
            <Typography
              text={Signal.make("Crested Caracara")} variant=Typography.Unstyled class="bold"
            />
            <Typography text={Signal.make("Bird of prey")} variant=Typography.Small />
          </div>
        </Grid>
        <br />
        <Grid>
          <Avatar src="https://upload.wikimedia.org/wikipedia/commons/a/ad/Schopfkarakara.jpg" />
          <div>
            <Typography text={Signal.make("Crested Caracara")} variant=Typography.P class="bold" />
          </div>
        </Grid>
        <br />
        <Grid>
          <Avatar
            src="https://upload.wikimedia.org/wikipedia/commons/a/ad/Schopfkarakara.jpg" size={Sm}
          />
          <div>
            <Typography text={Signal.make("Crested Caracara")} variant=Typography.Unstyled />
          </div>
        </Grid>
        <br />
        <Grid gap="1rem">
          <Avatar
            src="https://upload.wikimedia.org/wikipedia/commons/a/ad/Schopfkarakara.jpg" size={Lg}
          />
          <div>
            <Typography text={Signal.make("Crested Caracara")} variant=Typography.H4 />
            <Typography
              text={Signal.make("Bird of prey")} variant=Typography.H6 class="muted font-normal"
            />
          </div>
        </Grid>
      </Card>

      <Card>
        <Label text="Full Name" required={true} />
        <Input value={name} onInput={handleNameChange} type_={Input.Text} placeholder="John Doe" />
        <br />
        <Label text="Email Address" required={true} />
        <Input
          value={email}
          onInput={handleEmailChange}
          type_={Input.Email}
          placeholder="john@example.com"
        />
        <br />
        <Label text="Password" required={true} />
        <Input
          value={password}
          onInput={handlePasswordChange}
          type_={Input.Password}
          placeholder="Enter a secure password"
        />
      </Card>
      <br />
      <Card>
        <Label text="Area of Interest" required={false} />
        <Select
          value={selectedOption}
          options={selectOptionsSignal}
          onChange={e => {
            let target = Obj.magic(e)["target"]
            Signal.set(selectedOption, target["value"])
          }}
        />
        <br />
        <Label text="Favorite Color" required={false} />
        <div style="display: flex; gap: 1rem; margin-top: 0.5rem;">
          <Radio
            checked={Computed.make(() => Signal.get(selectedColor) == "blue")}
            onChange={handleColorChange}
            value="blue"
            label="Blue"
            name="radio"
          />
          <Radio
            checked={Computed.make(() => Signal.get(selectedColor) == "green")}
            onChange={handleColorChange}
            value="green"
            label="Green"
            name="radio"
          />
          <Radio
            checked={Computed.make(() => Signal.get(selectedColor) == "red")}
            onChange={handleColorChange}
            value="red"
            label="Red"
            name="radio"
          />
        </div>
      </Card>
      <br />
      <Card>
        <Label text="Message" required={false} />
        <Textarea
          value={message} onInput={handleMessageChange} placeholder="Tell us more about yourself..."
        />
      </Card>
      <br />
      <Card>
        <div style="margin-bottom: 1.5rem;">
          <Checkbox
            checked={agreeToTerms}
            onChange={handleTermsChange}
            label="I agree to the terms and conditions"
          />
        </div>

        <div style="margin-bottom: 2rem;">
          <Checkbox
            checked={newsletter}
            onChange={handleNewsletterChange}
            label="Subscribe to our newsletter"
          />
        </div>

        <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
          <Button
            label={Computed.make(() => Signal.get(isSubmitting) ? "Submitting..." : "Submit Form")}
            onClick={handleSubmit}
            variant={Button.Primary}
            disabled={Signal.get(isSubmitting)}
          />
          <Button
            label={Signal.make("Reset")}
            onClick={handleReset}
            variant={Button.Secondary}
            disabled={Signal.get(isSubmitting)}
          />
          <Button
            label={Signal.make("Cancel")} variant={Button.Ghost} disabled={Signal.get(isSubmitting)}
          />
        </div>
      </Card>

      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Alerts")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Display important messages with different severity levels.")}
        </p>
        <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Alert
            title="Information"
            message={Signal.make("This is an informational alert message.")}
            variant={Alert.Info}
          />
          <Alert
            title="Success"
            message={Signal.make("Your changes have been saved successfully!")}
            variant={Alert.Success}
          />
          <Alert
            title="Warning"
            message={Signal.make("Please review your input before proceeding.")}
            variant={Alert.Warning}
          />
          <Alert
            title="Error"
            message={Signal.make("An error occurred while processing your request.")}
            variant={Alert.Error}
          />
          <Alert
            message={Signal.make("This is a dismissible alert. Click the X to close it.")}
            variant={Alert.Info}
            dismissible={true}
          />
        </div>
      </div>

      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Progress")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Show progress indicators for ongoing operations.")}
        </p>
        <div style="display: flex; flex-direction: column; gap: 2rem;">
          <div>
            <Progress value={Signal.make(25.0)} variant={Progress.Primary} showLabel={true} />
          </div>
          <div>
            <Progress
              value={Signal.make(50.0)} variant={Progress.Success} showLabel={true} label="Upload"
            />
          </div>
          <div>
            <Progress
              value={Signal.make(75.0)} variant={Progress.Warning} showLabel={true} label="Processing"
            />
          </div>
          <div>
            <Progress
              value={Signal.make(100.0)} variant={Progress.Success} showLabel={true} label="Complete"
            />
          </div>
          <div>
            <Progress
              value={downloadProgress}
              variant={Progress.Primary}
              showLabel={true}
              label="Dynamic Progress"
            />
            <Button
              label={Signal.make("Simulate Progress")}
              onClick={_evt => {
                Signal.set(downloadProgress, 0.0)
                let intervalId = ref(None)
                let id = setInterval(() => {
                  Signal.update(downloadProgress, prev => {
                    let next = prev +. 5.0
                    if next >= 100.0 {
                      switch intervalId.contents {
                      | Some(id) => clearInterval(id)
                      | None => ()
                      }
                      100.0
                    } else {
                      next
                    }
                  })
                }, 100)
                intervalId := Some(id)
              }}
              variant={Button.Secondary}
            />
          </div>
          <div>
            <p style="color: #6b7280; margin-bottom: 0.5rem;">
              {Component.text("Indeterminate progress:")}
            </p>
            <Progress value={Signal.make(0.0)} variant={Progress.Primary} indeterminate={true} />
          </div>
        </div>
      </div>

      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Tabs")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Organize content into tabbed sections.")}
        </p>
        <Tabs
          tabs={[
            {
              value: "account",
              label: "Account",
              content: <div>
                <Typography text={Signal.make("Account Settings")} variant={Typography.H5} />
                <p style="color: #6b7280; margin-top: 0.5rem;">
                  {Component.text(
                    "Manage your account settings and preferences here. You can update your profile information, change your password, and configure notification settings.",
                  )}
                </p>
              </div>,
              disabled: None,
            },
            {
              value: "security",
              label: "Security",
              content: <div>
                <Typography text={Signal.make("Security Settings")} variant={Typography.H5} />
                <p style="color: #6b7280; margin-top: 0.5rem;">
                  {Component.text(
                    "Configure your security preferences including two-factor authentication, active sessions, and security logs.",
                  )}
                </p>
                <div style="margin-top: 1rem;">
                  <Checkbox
                    checked={Signal.make(true)}
                    onChange={_ => ()}
                    label="Enable two-factor authentication"
                  />
                </div>
              </div>,
              disabled: None,
            },
            {
              value: "notifications",
              label: "Notifications",
              content: <div>
                <Typography text={Signal.make("Notification Preferences")} variant={Typography.H5} />
                <p style="color: #6b7280; margin-top: 0.5rem;">
                  {Component.text("Choose how you want to receive notifications.")}
                </p>
                <div style="display: flex; flex-direction: column; gap: 0.75rem; margin-top: 1rem;">
                  <Checkbox checked={Signal.make(true)} onChange={_ => ()} label="Email notifications" />
                  <Checkbox checked={Signal.make(false)} onChange={_ => ()} label="SMS notifications" />
                  <Checkbox
                    checked={Signal.make(true)} onChange={_ => ()} label="Push notifications"
                  />
                </div>
              </div>,
              disabled: None,
            },
            {
              value: "billing",
              label: "Billing",
              content: <div>
                <Typography text={Signal.make("Billing Information")} variant={Typography.H5} />
                <p style="color: #6b7280; margin-top: 0.5rem;">
                  {Component.text(
                    "View and manage your billing information, payment methods, and invoices.",
                  )}
                </p>
              </div>,
              disabled: Some(true),
            },
          ]}
        />
      </div>

      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Accordion")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Collapsible content sections with expand/collapse functionality.")}
        </p>
        <Accordion
          items={[
            {
              value: "faq1",
              title: "What is Eita-UI?",
              content: <p>
                {Component.text(
                  "Eita-UI is a modern, reactive UI component library built with ReScript and Xote. It provides a comprehensive set of accessible and customizable components for building web applications.",
                )}
              </p>,
              disabled: None,
            },
            {
              value: "faq2",
              title: "How do I install Eita-UI?",
              content: <div>
                <p>
                  {Component.text(
                    "You can install Eita-UI via npm or yarn. Here's how to get started:",
                  )}
                </p>
                <br />
                <Typography
                  text={Signal.make("npm install eita-ui")} variant={Typography.Code}
                />
              </div>,
              disabled: None,
            },
            {
              value: "faq3",
              title: "Is Eita-UI customizable?",
              content: <p>
                {Component.text(
                  "Yes! Eita-UI is fully customizable. You can override the default styles using CSS variables or by providing custom CSS classes. Each component accepts standard HTML attributes including className and style.",
                )}
              </p>,
              disabled: None,
            },
            {
              value: "faq4",
              title: "Does Eita-UI support TypeScript?",
              content: <p>
                {Component.text(
                  "Eita-UI is built with ReScript, which provides excellent type safety. While it doesn't directly use TypeScript, ReScript's type system is even more robust and catches errors at compile time.",
                )}
              </p>,
              disabled: None,
            },
          ]}
          multiple={true}
          defaultOpen={["faq1"]}
        />
      </div>

      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Breadcrumb")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Navigation breadcrumbs to show the current page hierarchy.")}
        </p>
        <div style="display: flex; flex-direction: column; gap: 1.5rem;">
          <div>
            <p style="color: #6b7280; margin-bottom: 0.5rem; font-size: 0.875rem;">
              {Component.text("Default separator:")}
            </p>
            <Breadcrumb
              items={[
                {label: "Home", href: Some("#"), onClick: None},
                {label: "Products", href: Some("#"), onClick: None},
                {label: "Electronics", href: Some("#"), onClick: None},
                {label: "Laptops", href: None, onClick: None},
              ]}
            />
          </div>
          <div>
            <p style="color: #6b7280; margin-bottom: 0.5rem; font-size: 0.875rem;">
              {Component.text("Custom separator:")}
            </p>
            <Breadcrumb
              items={[
                {label: "Home", href: Some("#"), onClick: None},
                {label: "Settings", href: Some("#"), onClick: None},
                {label: "Account", href: None, onClick: None},
              ]}
              separator=">"
            />
          </div>
          <div>
            <p style="color: #6b7280; margin-bottom: 0.5rem; font-size: 0.875rem;">
              {Component.text("With onClick handlers:")}
            </p>
            <Breadcrumb
              items={[
                {
                  label: "Dashboard",
                  href: None,
                  onClick: Some(() => Console.log("Navigate to Dashboard")),
                },
                {
                  label: "Users",
                  href: None,
                  onClick: Some(() => Console.log("Navigate to Users")),
                },
                {label: "Profile", href: None, onClick: None},
              ]}
              separator="\u2022"
            />
          </div>
        </div>
      </div>

      <Separator
        orientation={Separator.Horizontal} variant={Separator.Solid} label={"Tier 3"}
      />

      <div style="margin-top: 3rem;">
        <Typography
          text={Signal.make("Interactive Components")}
          variant={Typography.H2}
          align={Typography.Left}
        />
        <Typography
          text={Signal.make("Explore the Tier 3 advanced interactive components below.")}
          variant={Typography.Muted}
        />
      </div>

      // Modal Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Modal / Dialog")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Display content in an overlay dialog.")}
        </p>
        <Button
          label={Signal.make("Open Modal")}
          onClick={_ => Signal.set(isModalOpen, true)}
          variant={Button.Primary}
        />
        <Modal
          isOpen={isModalOpen}
          onClose={() => Signal.set(isModalOpen, false)}
          title="Example Modal"
          size={Modal.Md}
          footer={<div style="display: flex; gap: 0.5rem;">
            <Button
              label={Signal.make("Cancel")}
              onClick={_ => Signal.set(isModalOpen, false)}
              variant={Button.Ghost}
            />
            <Button
              label={Signal.make("Confirm")}
              onClick={_ => {
                Console.log("Confirmed!")
                Signal.set(isModalOpen, false)
              }}
              variant={Button.Primary}
            />
          </div>}
        >
          <p>
            {Component.text(
              "This is a modal dialog. You can include any content here. Click the backdrop or the close button to dismiss.",
            )}
          </p>
          <p style="margin-top: 1rem;">
            {Component.text("Modals are great for focused user interactions and confirmations.")}
          </p>
        </Modal>
      </div>

      // Switch Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Switch / Toggle")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Binary on/off switches for settings and preferences.")}
        </p>
        <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Switch checked={switchEnabled} label="Enable feature" />
          <Switch checked={darkModeSwitch} label="Dark mode" size={Switch.Lg} />
          <Switch checked={notificationsSwitch} label="Push notifications" size={Switch.Sm} />
          <Switch
            checked={Signal.make(true)} label="Disabled switch" disabled={true} size={Switch.Md}
          />
        </div>
      </div>

      // Slider Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Slider")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Select a value from a range.")}
        </p>
        <div style="display: flex; flex-direction: column; gap: 2rem;">
          <Slider value={sliderValue} label="Volume" showValue={true} />
          <Slider
            value={Signal.make(25.0)}
            label="Brightness"
            min={0.0}
            max={100.0}
            step={5.0}
            showValue={true}
          />
          <Slider
            value={Signal.make(3.0)}
            min={0.0}
            max={5.0}
            step={1.0}
            label="Rating"
            showValue={true}
            markers={["0", "1", "2", "3", "4", "5"]}
          />
        </div>
      </div>

      // Tooltip Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Tooltip")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Show contextual information on hover.")}
        </p>
        <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
          <Tooltip content="This appears on top" position={Tooltip.Top}>
            <Button label={Signal.make("Hover me (top)")} variant={Button.Secondary} />
          </Tooltip>
          <Tooltip content="This appears on bottom" position={Tooltip.Bottom}>
            <Button label={Signal.make("Hover me (bottom)")} variant={Button.Secondary} />
          </Tooltip>
          <Tooltip content="This appears on left" position={Tooltip.Left}>
            <Button label={Signal.make("Hover me (left)")} variant={Button.Secondary} />
          </Tooltip>
          <Tooltip content="This appears on right" position={Tooltip.Right}>
            <Button label={Signal.make("Hover me (right)")} variant={Button.Secondary} />
          </Tooltip>
        </div>
      </div>

      // Dropdown Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Dropdown Menu")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Contextual menu with actions.")}
        </p>
        <div style="display: flex; gap: 1rem;">
          <Dropdown
            trigger={<Button label={Signal.make("Actions")} variant={Button.Secondary} />}
            items={[
              Dropdown.Item({
                label: "Edit",
                onClick: () => Console.log("Edit clicked"),
                disabled: None,
                danger: None,
              }),
              Dropdown.Item({
                label: "Duplicate",
                onClick: () => Console.log("Duplicate clicked"),
                disabled: None,
                danger: None,
              }),
              Dropdown.Separator,
              Dropdown.Item({
                label: "Archive",
                onClick: () => Console.log("Archive clicked"),
                disabled: None,
                danger: None,
              }),
              Dropdown.Item({
                label: "Delete",
                onClick: () => Console.log("Delete clicked"),
                disabled: None,
                danger: Some(true),
              }),
            ]}
          />
          <Dropdown
            trigger={<Button label={Signal.make("More options")} variant={Button.Ghost} />}
            items={[
              Dropdown.Item({
                label: "Settings",
                onClick: () => Console.log("Settings"),
                disabled: None,
                danger: None,
              }),
              Dropdown.Item({
                label: "Help",
                onClick: () => Console.log("Help"),
                disabled: None,
                danger: None,
              }),
              Dropdown.Separator,
              Dropdown.Item({
                label: "Disabled item",
                onClick: () => Console.log("Should not fire"),
                disabled: Some(true),
                danger: None,
              }),
            ]}
            align=#right
          />
        </div>
      </div>

      // Toast Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Toast / Notification")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Temporary notification messages.")}
        </p>
        <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
          <Button
            label={Signal.make("Show Toast")}
            onClick={_ => Signal.set(toastVisible, true)}
            variant={Button.Primary}
          />
        </div>
        <Toast
          title="Success!"
          message="Your changes have been saved successfully."
          variant={Toast.Success}
          isVisible={toastVisible}
          onClose={() => Console.log("Toast closed")}
        />
      </div>

      <Separator
        orientation={Separator.Horizontal} variant={Separator.Dashed} label={"Foundational"}
      />

      <div style="margin-top: 3rem;">
        <Typography
          text={Signal.make("Foundation Components")}
          variant={Typography.H2}
          align={Typography.Left}
        />
        <Typography
          text={Signal.make("Explore the Tier 1 foundation components below.")}
          variant={Typography.Muted}
        />
      </div>

      // Badges Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Badges")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Display status indicators and labels with various styles.")}
        </p>
        <div style="display: flex; gap: 0.75rem; flex-wrap: wrap; align-items: center;">
          <Badge label={Signal.make("Default")} variant={Badge.Default} />
          <Badge label={Signal.make("Primary")} variant={Badge.Primary} />
          <Badge label={Signal.make("Secondary")} variant={Badge.Secondary} />
          <Badge label={Signal.make("Success")} variant={Badge.Success} />
          <Badge label={Signal.make("Warning")} variant={Badge.Warning} />
          <Badge label={Signal.make("Error")} variant={Badge.Error} />
        </div>
        <div
          style="display: flex; gap: 0.75rem; flex-wrap: wrap; align-items: center; margin-top: 1rem;"
        >
          <Badge label={Signal.make("Small")} variant={Badge.Primary} size={Badge.Sm} />
          <Badge label={Signal.make("Medium")} variant={Badge.Primary} size={Badge.Md} />
          <Badge label={Signal.make("Large")} variant={Badge.Primary} size={Badge.Lg} />
          <Badge label={Signal.make("Online")} variant={Badge.Success} dot={true} />
          <Badge label={Signal.make("Away")} variant={Badge.Warning} dot={true} />
        </div>
      </div>

      <Separator orientation={Separator.Horizontal} variant={Separator.Dashed} label={"Spinners"} />

      // Spinners Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Spinners")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Loading indicators in different sizes and colors.")}
        </p>
        <div style="display: flex; gap: 2rem; flex-wrap: wrap; align-items: center;">
          <Spinner size={Spinner.Sm} variant={Spinner.Default} />
          <Spinner size={Spinner.Md} variant={Spinner.Primary} />
          <Spinner size={Spinner.Lg} variant={Spinner.Secondary} />
          <Spinner size={Spinner.Xl} variant={Spinner.Primary} />
        </div>
        <div style="display: flex; gap: 2rem; flex-wrap: wrap; margin-top: 1.5rem;">
          <Spinner size={Spinner.Md} variant={Spinner.Primary} label="Loading..." />
          <Spinner
            size={Spinner.Lg}
            variant={Spinner.Default}
            label={Signal.get(isSubmitting) ? "Submitting..." : "Ready"}
          />
        </div>
      </div>

      <Separator orientation={Separator.Horizontal} variant={Separator.Dotted} />

      // Keyboard Shortcuts Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Keyboard Shortcuts")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Display keyboard shortcuts in a visually appealing way.")}
        </p>
        <div style="display: flex; gap: 1.5rem; flex-wrap: wrap; align-items: center;">
          <div>
            <span style="color: #6b7280; margin-right: 0.5rem;"> {Component.text("Copy:")} </span>
            <Kbd keys={Signal.make(["Ctrl", "C"])} size={Kbd.Md} />
          </div>
          <div>
            <span style="color: #6b7280; margin-right: 0.5rem;"> {Component.text("Paste:")} </span>
            <Kbd keys={Signal.make(["Ctrl", "V"])} size={Kbd.Md} />
          </div>
          <div>
            <span style="color: #6b7280; margin-right: 0.5rem;"> {Component.text("Save:")} </span>
            <Kbd keys={Signal.make(["Ctrl", "S"])} size={Kbd.Md} />
          </div>
          <div>
            <span style="color: #6b7280; margin-right: 0.5rem;">
              {Component.text("Select All:")}
            </span>
            <Kbd keys={Signal.make(["Ctrl", "A"])} size={Kbd.Md} />
          </div>
        </div>
        <div style="margin-top: 1rem;">
          <Kbd keys={Signal.make(["Shift", "Alt", "F"])} size={Kbd.Sm} />
          <span style="color: #6b7280; margin-left: 0.5rem;">
            {Component.text("Format Document")}
          </span>
        </div>
      </div>

      <Separator orientation={Separator.Horizontal} variant={Separator.Solid} />

      // Typography Section
      <div style="margin-top: 2rem;">
        <Typography text={Signal.make("Typography")} variant={Typography.H4} />
        <p style="color: #6b7280; margin: 0.5rem 0 1rem 0;">
          {Component.text("Consistent text styling across your application.")}
        </p>
        <div style="display: flex; flex-direction: column; gap: 1rem;">
          <Typography text={Signal.make("Heading 1")} variant={Typography.H1} />
          <Typography text={Signal.make("Heading 2")} variant={Typography.H2} />
          <Typography text={Signal.make("Heading 3")} variant={Typography.H3} />
          <Typography text={Signal.make("Heading 4")} variant={Typography.H4} />
          <Typography text={Signal.make("Heading 5")} variant={Typography.H5} />
          <Typography text={Signal.make("Heading 6")} variant={Typography.H6} />
          <Separator orientation={Separator.Horizontal} variant={Separator.Dashed} />
          <Typography
            text={Signal.make(
              "This is a regular paragraph with normal text styling and comfortable line height.",
            )}
            variant={Typography.P}
          />
          <Typography
            text={Signal.make(
              "This is a lead paragraph that stands out with larger text and is perfect for introductions.",
            )}
            variant={Typography.Lead}
          />
          <Typography
            text={Signal.make("This is small text, useful for captions and helper text.")}
            variant={Typography.Small}
          />
          <Typography
            text={Signal.make("This is muted text with reduced emphasis.")}
            variant={Typography.Muted}
          />
          <Typography text={Signal.make("const hello = 'world'")} variant={Typography.Code} />
        </div>
      </div>

      <div
        style="margin-top: 3rem; padding: 1rem; background-color: #f3f4f6; border-radius: 0.5rem;"
      >
        <h3 style="margin-top: 0; color: #374151;"> {Component.text("Form State (Real-time)")} </h3>
        <pre
          style="background-color: #1f2937; color: #f9fafb; padding: 1rem; border-radius: 0.25rem; overflow-x: auto; font-size: 0.875rem;"
        >
          {Component.textSignal(() => {
            `Name: ${Signal.get(name)}
Email: ${Signal.get(email)}
Password: ${"*"->String.repeat(Signal.get(password)->String.length)}
Interest: ${Signal.get(selectedOption)}
Color: ${Signal.get(selectedColor)}
Message: ${Signal.get(message)->String.slice(~start=0, ~end=50)}${Signal.get(
                message,
              )->String.length > 50
                ? "..."
                : ""}
Terms: ${Signal.get(agreeToTerms)->Bool.toString}
Newsletter: ${Signal.get(newsletter)->Bool.toString}`
          })}
        </pre>
      </div>
    </>
  }
}

// Mount the demo application
Component.mountById(<Demo />, "root")

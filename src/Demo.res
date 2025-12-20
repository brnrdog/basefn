// Demo application showcasing Eita-UI components

%%raw(`import './styles/variables.css'`)

open Xote
open Eita

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

    <div>
      {Component.textSignal(() => Signal.get(selectedOption))}
      <h1> {Component.text("Eita-UI Component Library")} </h1>
      <p style="color: #6b7280; margin-bottom: 2rem;">
        {Component.text(
          "A demonstration of all form components with both static and reactive values.",
        )}
      </p>

      <div style="margin-bottom: 1.5rem;">
        <Label text="Full Name" required={true} />
        <Input value={name} onInput={handleNameChange} type_={Input.Text} placeholder="John Doe" />
      </div>

      <div style="margin-bottom: 1.5rem;">
        <Label text="Email Address" required={true} />
        <Input
          value={email}
          onInput={handleEmailChange}
          type_={Input.Email}
          placeholder="john@example.com"
        />
      </div>

      <div style="margin-bottom: 1.5rem;">
        <Label text="Password" required={true} />
        <Input
          value={password}
          onInput={handlePasswordChange}
          type_={Input.Password}
          placeholder="Enter a secure password"
        />
      </div>

      <div style="margin-bottom: 1.5rem;">
        <Label text="Area of Interest" required={false} />
        <Select
          value={selectedOption}
          options={selectOptionsSignal}
          onChange={e => {
            let target = Obj.magic(e)["target"]
            Signal.set(selectedOption, target["value"])
          }}
        />
      </div>

      <div style="margin-bottom: 1.5rem;">
        <Label text="Favorite Color" required={false} />
        <div style="display: flex; gap: 1rem; margin-top: 0.5rem;">
          <Radio
            checked={Signals.Computed.make(() => Signal.get(selectedColor) == "blue")}
            onChange={handleColorChange}
            value="blue"
            label="Blue"
            name="radio"
          />
          <Radio
            checked={Signals.Computed.make(() => Signal.get(selectedColor) == "green")}
            onChange={handleColorChange}
            value="green"
            label="Green"
            name="radio"
          />
          <Radio
            checked={Signals.Computed.make(() => Signal.get(selectedColor) == "red")}
            onChange={handleColorChange}
            value="red"
            label="Red"
            name="radio"
          />
        </div>
      </div>

      <div style="margin-bottom: 1.5rem;">
        <Label text="Message" required={false} />
        <Textarea
          value={message} onInput={handleMessageChange} placeholder="Tell us more about yourself..."
        />
      </div>

      <div style="margin-bottom: 1.5rem;">
        <Checkbox
          checked={agreeToTerms}
          onChange={handleTermsChange}
          label="I agree to the terms and conditions"
        />
      </div>

      <div style="margin-bottom: 2rem;">
        <Checkbox
          checked={newsletter} onChange={handleNewsletterChange} label="Subscribe to our newsletter"
        />
      </div>

      <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
        <Button
          label={Signals.Computed.make(() =>
            Signal.get(isSubmitting) ? "Submitting..." : "Submit Form"
          )}
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
    </div>
  }
}

// Mount the demo application
Component.mountById(<Demo />, "root")

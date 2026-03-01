open Xote
open Basefn

let examples: array<DocsExample.t> = [
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

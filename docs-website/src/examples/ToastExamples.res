open Xote
open Basefn
open Component

let examples: array<DocsExample.t> = [
  {
    title: "Toast Notifications",
    description: "Temporary notification messages.",
    demo: {
      let showSuccess = Signal.make(false)
      let showError = Signal.make(false)
      let showWarning = Signal.make(false)
      <div style="display: flex; gap: 0.5rem; flex-wrap: wrap;">
        <Button variant={Button.Primary} onClick={_ => Signal.set(showSuccess, true)}>
          {Component.text("Success")}
        </Button>
        <Button variant={Button.Secondary} onClick={_ => Signal.set(showError, true)}>
          {Component.text("Error")}
        </Button>
        <Button variant={Button.Ghost} onClick={_ => Signal.set(showWarning, true)}>
          {Component.text("Warning")}
        </Button>
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

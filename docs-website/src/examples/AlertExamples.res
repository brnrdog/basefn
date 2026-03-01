open Xote
open Basefn

let examples: array<DocsExample.t> = [
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

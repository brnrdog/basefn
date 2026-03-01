open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "Basic Modal",
      description: "Display content in an overlay dialog.",
      demo: {
        let isOpen = Signal.make(false)
        <div>
          <Button onClick={_ => Signal.set(isOpen, true)}>
            {Component.text("Open Modal")}
          </Button>
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
          <Button variant={Button.Ghost} onClick={_ => Signal.set(isSmOpen, true)}>
            {Component.text("Small")}
          </Button>
          <Button variant={Button.Ghost} onClick={_ => Signal.set(isMdOpen, true)}>
            {Component.text("Medium")}
          </Button>
          <Button variant={Button.Ghost} onClick={_ => Signal.set(isLgOpen, true)}>
            {Component.text("Large")}
          </Button>
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
}

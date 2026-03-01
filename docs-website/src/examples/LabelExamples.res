open Xote
open Basefn

let examples: array<DocsExample.t> = [
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

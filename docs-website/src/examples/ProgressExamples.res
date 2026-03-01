open Xote
open Basefn

let examples: array<DocsExample.t> = [
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

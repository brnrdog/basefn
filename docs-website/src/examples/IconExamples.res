open Xote
open Basefn

let examples: array<DocsExample.t> = {
  open Component
  [
    {
      title: "All Available Icons",
      description: "Complete list of icons included in basefn-UI.",
      demo: <div
        style="display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: 1.5rem; padding: 1rem;"
      >
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Check} />
          <Typography text={ReactiveProp.Static("Check")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.X} />
          <Typography text={ReactiveProp.Static("X")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.ChevronDown} />
          <Typography text={ReactiveProp.Static("ChevronDown")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.ChevronUp} />
          <Typography text={ReactiveProp.Static("ChevronUp")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.ChevronLeft} />
          <Typography text={ReactiveProp.Static("ChevronLeft")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.ChevronRight} />
          <Typography text={ReactiveProp.Static("ChevronRight")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Search} />
          <Typography text={ReactiveProp.Static("Search")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Menu} />
          <Typography text={ReactiveProp.Static("Menu")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Home} />
          <Typography text={ReactiveProp.Static("Home")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.User} />
          <Typography text={ReactiveProp.Static("User")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Settings} />
          <Typography text={ReactiveProp.Static("Settings")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Info} />
          <Typography text={ReactiveProp.Static("Info")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.AlertCircle} />
          <Typography text={ReactiveProp.Static("AlertCircle")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.AlertTriangle} />
          <Typography text={ReactiveProp.Static("AlertTriangle")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Loader} />
          <Typography text={ReactiveProp.Static("Loader")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Plus} />
          <Typography text={ReactiveProp.Static("Plus")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Minus} />
          <Typography text={ReactiveProp.Static("Minus")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Trash} />
          <Typography text={ReactiveProp.Static("Trash")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Edit} />
          <Typography text={ReactiveProp.Static("Edit")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Copy} />
          <Typography text={ReactiveProp.Static("Copy")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.ExternalLink} />
          <Typography text={ReactiveProp.Static("ExternalLink")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Download} />
          <Typography text={ReactiveProp.Static("Download")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Upload} />
          <Typography text={ReactiveProp.Static("Upload")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Heart} />
          <Typography text={ReactiveProp.Static("Heart")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Star} />
          <Typography text={ReactiveProp.Static("Star")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Sun} />
          <Typography text={ReactiveProp.Static("Sun")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Moon} />
          <Typography text={ReactiveProp.Static("Moon")} variant={Typography.Small} />
        </div>
      </div>,
      code: `<Icon name={Icon.Check} />
<Icon name={Icon.Search} />
<Icon name={Icon.Settings} />
<Icon name={Icon.Heart} />
// See all icons in the example above`,
    },
    {
      title: "Icon Sizes",
      description: "Icons come in four sizes: small, medium, large, and extra large.",
      demo: <div style="display: flex; gap: 2rem; align-items: center;">
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Heart} size={Icon.Sm} />
          <Typography text={ReactiveProp.Static("Small (16px)")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Heart} size={Icon.Md} />
          <Typography text={ReactiveProp.Static("Medium (24px)")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Heart} size={Icon.Lg} />
          <Typography text={ReactiveProp.Static("Large (32px)")} variant={Typography.Small} />
        </div>
        <div style="display: flex; flex-direction: column; align-items: center; gap: 0.5rem;">
          <Icon name={Icon.Heart} size={Icon.Xl} />
          <Typography text={ReactiveProp.Static("XLarge (48px)")} variant={Typography.Small} />
        </div>
      </div>,
      code: `<Icon name={Icon.Heart} size={Icon.Sm} />
<Icon name={Icon.Heart} size={Icon.Md} />
<Icon name={Icon.Heart} size={Icon.Lg} />
<Icon name={Icon.Heart} size={Icon.Xl} />`,
    },
    {
      title: "Colored Icons",
      description: "Icons inherit color from their context or can be colored explicitly.",
      demo: <div style="display: flex; gap: 1.5rem; align-items: center; flex-wrap: wrap;">
        <Icon name={Icon.Heart} color={ReactiveProp.static("red")} size={Icon.Lg} />
        <Icon name={Icon.Star} color={ReactiveProp.static("gold")} size={Icon.Lg} />
        <Icon name={Icon.Check} color={ReactiveProp.static("green")} size={Icon.Lg} />
        <Icon name={Icon.AlertCircle} color={ReactiveProp.static("orange")} size={Icon.Lg} />
        <Icon name={Icon.X} color={ReactiveProp.static("red")} size={Icon.Lg} />
        <Icon name={Icon.Info} color={ReactiveProp.static("blue")} size={Icon.Lg} />
      </div>,
      code: `<Icon name={Icon.Heart} color={ReactiveProp.static("red")} />
<Icon name={Icon.Star} color={ReactiveProp.static("gold")} />
<Icon name={Icon.Check} color={ReactiveProp.static("green")} />`,
    },
    {
      title: "Icons in Buttons",
      description: "Icons work great alongside text in buttons and other components.",
      demo: <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
        <Button variant={Button.Primary}>
          <div style="display: flex; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Download} size={Icon.Sm} />
            {Component.text("Download")}
          </div>
        </Button>
        <Button variant={Button.Secondary}>
          <div style="display: flex; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Upload} size={Icon.Sm} />
            {Component.text("Upload")}
          </div>
        </Button>
        <Button variant={Button.Ghost}>
          <div style="display: flex; align-items: center; gap: 0.5rem;">
            <Icon name={Icon.Trash} size={Icon.Sm} />
            {Component.text("Delete")}
          </div>
        </Button>
        <Button variant={Button.Primary}>
          <div style="display: flex; align-items: center; gap: 0.5rem;">
            {Component.text("Next")}
            <Icon name={Icon.ChevronRight} size={Icon.Sm} />
          </div>
        </Button>
      </div>,
      code: `<Button variant={Button.Primary}>
  <div style="display: flex; align-items: center; gap: 0.5rem;">
    <Icon name={Icon.Download} size={Icon.Sm} />
    {Component.text("Download")}
  </div>
</Button>`,
    },
  ]
}

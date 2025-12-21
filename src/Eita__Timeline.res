%%raw(`import './Eita__Timeline.css'`)

open Xote

type orientation = Vertical | Horizontal

type variant = Default | Primary | Success | Warning | Error

let variantToString = (variant: variant) => {
  switch variant {
  | Default => "default"
  | Primary => "primary"
  | Success => "success"
  | Warning => "warning"
  | Error => "error"
  }
}

type timelineItem = {
  title: string,
  timestamp: option<string>,
  description: option<string>,
  variant: variant,
  icon: option<string>,
}

@jsx.component
let make = (~items: array<timelineItem>, ~orientation: orientation=Vertical) => {
  let getTimelineClass = () => {
    let orientationClass = switch orientation {
    | Vertical => "eita-timeline--vertical"
    | Horizontal => "eita-timeline--horizontal"
    }
    "eita-timeline " ++ orientationClass
  }

  let getMarkerClass = (variant: variant) => {
    let variantClass = "eita-timeline__marker--" ++ variantToString(variant)
    "eita-timeline__marker " ++ variantClass
  }

  <div class={getTimelineClass()}>
    {items
    ->Array.mapWithIndex((item, index) => {
      <div key={Int.toString(index)} class="eita-timeline__item">
        <div class="eita-timeline__marker-wrapper">
          <div class={getMarkerClass(item.variant)}>
            {switch item.icon {
            | Some(iconText) => Component.text(iconText)
            | None => Component.text(Int.toString(index + 1))
            }}
          </div>
          <div class="eita-timeline__connector" />
        </div>
        <div class="eita-timeline__content">
          <div class="eita-timeline__title"> {Component.text(item.title)} </div>
          {switch item.timestamp {
          | Some(time) =>
            <div class="eita-timeline__timestamp"> {Component.text(time)} </div>
          | None => <> </>
          }}
          {switch item.description {
          | Some(desc) =>
            <div class="eita-timeline__description"> {Component.text(desc)} </div>
          | None => <> </>
          }}
        </div>
      </div>
    })
    ->Component.fragment}
  </div>
}

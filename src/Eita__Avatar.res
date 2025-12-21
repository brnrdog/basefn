%%raw(`import './Eita__Avatar.css'`)

type size = Sm | Md | Lg

let sizeToString = (size: size) => {
  switch size {
  | Sm => "sm"
  | Md => "md"
  | Lg => "lg"
  }
}

@jsx.component
let make = (~src, ~name=?, ~size=Md) => {
  let class = {
    let sizeClass = "eita-avatar--" ++ sizeToString(size)
    "eita-avatar " ++ sizeClass
  }

  <div class>
    <img src={src} alt={name} />
  </div>
}

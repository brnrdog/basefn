let target = (e: Dom.event) => Obj.magic(e)["target"]

let preventDefault = (e: Dom.event) => %raw(`e.preventDefault()`)

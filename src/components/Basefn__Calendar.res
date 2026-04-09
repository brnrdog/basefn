%%raw(`import './Basefn__Calendar.css'`)

open Xote

let getDaysInMonth: (int, int) => int = %raw(`function(year, month) {
  return new Date(year, month + 1, 0).getDate();
}`)

let getFirstDayOfWeek: (int, int) => int = %raw(`function(year, month) {
  return new Date(year, month, 1).getDay();
}`)

let monthNames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
]

let dayLabels = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

type date = {
  year: int,
  month: int,
  day: int,
}

let dateToString = (d: date) =>
  Int.toString(d.year) ++
  "-" ++
  String.padStart(Int.toString(d.month + 1), 2, "0") ++
  "-" ++
  String.padStart(Int.toString(d.day), 2, "0")

let todayDate: unit => date = %raw(`function() {
  var d = new Date();
  return { year: d.getFullYear(), month: d.getMonth(), day: d.getDate() };
}`)

@jsx.component
let make = (
  ~selected: Signal.t<option<date>>,
  ~onSelect: option<date => unit>=?,
  ~className: string="",
) => {
  let today = todayDate()
  let viewYear = Signal.make(today.year)
  let viewMonth = Signal.make(today.month)

  let prevMonth = _ => {
    let m = Signal.peek(viewMonth)
    let y = Signal.peek(viewYear)
    if m === 0 {
      Signal.set(viewMonth, 11)
      Signal.set(viewYear, y - 1)
    } else {
      Signal.set(viewMonth, m - 1)
    }
  }

  let nextMonth = _ => {
    let m = Signal.peek(viewMonth)
    let y = Signal.peek(viewYear)
    if m === 11 {
      Signal.set(viewMonth, 0)
      Signal.set(viewYear, y + 1)
    } else {
      Signal.set(viewMonth, m + 1)
    }
  }

  let handleDayClick = (day: int) => {
    let d = {
      year: Signal.peek(viewYear),
      month: Signal.peek(viewMonth),
      day,
    }
    Signal.set(selected, Some(d))
    switch onSelect {
    | Some(cb) => cb(d)
    | None => ()
    }
  }

  let calendarClass = "basefn-calendar" ++ (className !== "" ? " " ++ className : "")

  let content = Computed.make(() => {
    let year = Signal.get(viewYear)
    let month = Signal.get(viewMonth)
    let sel = Signal.get(selected)
    let daysInMonth = getDaysInMonth(year, month)
    let firstDay = getFirstDayOfWeek(year, month)
    let monthName = monthNames->Array.getUnsafe(month)

    let isSelected = (day: int) =>
      switch sel {
      | Some(d) => d.year === year && d.month === month && d.day === day
      | None => false
      }

    let isToday = (day: int) =>
      today.year === year && today.month === month && today.day === day

    // Build grid cells
    let cells: array<Component.node> = []

    // Empty cells for offset
    for _ in 1 to firstDay {
      cells->Array.push(<div class="basefn-calendar__cell" />)->ignore
    }

    // Day cells
    for day in 1 to daysInMonth {
      let className =
        "basefn-calendar__day" ++
        (isSelected(day) ? " basefn-calendar__day--selected" : "") ++
        (isToday(day) ? " basefn-calendar__day--today" : "")
      let d = day
      cells
      ->Array.push(
        <button class={className} onClick={_ => handleDayClick(d)}>
          {Component.text(Int.toString(day))}
        </button>,
      )
      ->ignore
    }

    [
      <div class={calendarClass}>
        <div class="basefn-calendar__header">
          <button class="basefn-calendar__nav" onClick={prevMonth}>
            {Basefn__Icon.make({name: ChevronLeft, size: Sm})}
          </button>
          <span class="basefn-calendar__title">
            {Component.text(monthName ++ " " ++ Int.toString(year))}
          </span>
          <button class="basefn-calendar__nav" onClick={nextMonth}>
            {Basefn__Icon.make({name: ChevronRight, size: Sm})}
          </button>
        </div>
        <div class="basefn-calendar__grid">
          {dayLabels
          ->Array.map(label =>
            <div class="basefn-calendar__weekday"> {Component.text(label)} </div>
          )
          ->Component.fragment}
          {cells->Component.fragment}
        </div>
      </div>,
    ]
  })

  Component.signalFragment(content)
}

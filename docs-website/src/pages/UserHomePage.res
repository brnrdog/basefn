open Xote
open Xote.Component
open Basefn

%%raw(`import './UserHomePage.css'`)

// JS Date bindings
type date

@new external makeDate: unit => date = "Date"
@send external getHours: date => int = "getHours"
@send external toLocaleTimeString: (date, string, {..}) => string = "toLocaleTimeString"
@send
external toLocaleDateString: (date, string, {..}) => string = "toLocaleDateString"

let formatTime = () => {
  let d = makeDate()
  d->toLocaleTimeString("en-US", {"hour": "numeric", "minute": "2-digit", "hour12": true})
}

let formatDate = () => {
  let d = makeDate()
  d->toLocaleDateString(
    "en-US",
    {"weekday": "long", "year": "numeric", "month": "long", "day": "numeric"},
  )
}

let getCurrentHours = () => {
  makeDate()->getHours
}

module EventItem = {
  @jsx.component
  let make = (~event: HomePageData.event) => {
    let spaceLabel = Signal.make(event.space)

    <div class="uhp-event-item">
      <span class="uhp-event-time"> {text(event.time)} </span>
      <span class="uhp-event-title"> {text(event.title)} </span>
      <Badge label={spaceLabel} variant={Secondary} size={Sm} />
    </div>
  }
}

module TaskItem = {
  @jsx.component
  let make = (~task: HomePageData.task) => {
    let checked = Signal.make(task.completed)
    let spaceLabel = Signal.make(task.space)

    <div class="uhp-task-item">
      <Checkbox checked label={task.title} />
      <Badge label={spaceLabel} variant={Secondary} size={Sm} />
    </div>
  }
}

module UpcomingTaskItem = {
  @jsx.component
  let make = (~task: HomePageData.task) => {
    let checked = Signal.make(task.completed)
    let spaceLabel = Signal.make(task.space)

    <div class="uhp-task-item">
      <Checkbox checked label={task.title} />
      <div class="uhp-task-meta">
        <Typography
          text={ReactiveProp.Static(task.dueDate)} variant={Typography.Small} class="uhp-muted"
        />
        <Badge label={spaceLabel} variant={Secondary} size={Sm} />
      </div>
    </div>
  }
}

module UpcomingEventItem = {
  @jsx.component
  let make = (~event: HomePageData.event) => {
    let spaceLabel = Signal.make(event.space)

    <div class="uhp-event-item">
      <span class="uhp-event-date"> {text(event.date)} </span>
      <span class="uhp-event-time"> {text(event.time)} </span>
      <span class="uhp-event-title"> {text(event.title)} </span>
      <Badge label={spaceLabel} variant={Secondary} size={Sm} />
    </div>
  }
}

@jsx.component
let make = () => {
  let currentTime = Signal.make(formatTime())
  let currentDate = Signal.make(formatDate())
  let greeting = Signal.make(HomePageData.getGreeting(getCurrentHours()))

  // Update time every minute
  let _ = setInterval(() => {
    Signal.set(currentTime, formatTime())
    Signal.set(currentDate, formatDate())
    Signal.set(greeting, HomePageData.getGreeting(getCurrentHours()))
  }, 60_000)

  let user = HomePageData.currentUser
  let weather = HomePageData.weather
  let todayEvents = HomePageData.getTodayEvents()
  let todayTasks = HomePageData.getTodayTasks()
  let upcomingEvents = HomePageData.getUpcomingEvents()
  let upcomingTasks = HomePageData.getUpcomingTasks()

  let greetingMessage = Computed.make(() => {
    Signal.get(greeting) ++ ", " ++ user.name ++ "! Here's your day."
  })

  <div class="uhp">
    // Welcome Header
    <div class="uhp-header">
      <div class="uhp-avatar-xl">
        <Avatar src={user.avatarUrl} name={user.name} size={Lg} />
      </div>
      <div class="uhp-header-info">
        <Typography text={ReactiveProp.Static(user.name)} variant={Typography.H2} />
        <Typography text={ReactiveProp.Reactive(currentDate)} variant={Typography.Muted} />
        <div class="uhp-time-weather">
          <span class="uhp-time"> {SignalText(currentTime)} </span>
          <span class="uhp-weather-divider"> {text(" · ")} </span>
          <span class="uhp-weather">
            <Icon name={Sun} size={Sm} />
            {text(" " ++ weather.temperature ++ ", " ++ weather.condition)}
          </span>
        </div>
        <Typography
          text={ReactiveProp.Reactive(greetingMessage)} variant={Typography.Lead} class="uhp-greeting"
        />
      </div>
    </div>
    <Separator />
    // Today's Schedule
    <div class="uhp-section">
      <Typography text={ReactiveProp.Static("Today's Schedule")} variant={Typography.H3} />
      <Grid columns={Count(2)} gap="1.5rem" class={ReactiveProp.Static("uhp-grid")}>
        <Card header="Events">
          {if Array.length(todayEvents) > 0 {
            <div class="uhp-list">
              {todayEvents
              ->Array.map(event => <EventItem event />)
              ->Component.fragment}
            </div>
          } else {
            <Typography
              text={ReactiveProp.Static("No events today.")} variant={Typography.Muted}
            />
          }}
        </Card>
        <Card header="Tasks">
          {if Array.length(todayTasks) > 0 {
            <div class="uhp-list">
              {todayTasks
              ->Array.map(task => <TaskItem task />)
              ->Component.fragment}
            </div>
          } else {
            <Typography
              text={ReactiveProp.Static("No tasks for today.")} variant={Typography.Muted}
            />
          }}
        </Card>
      </Grid>
    </div>
    <Separator />
    // Upcoming 30 Days
    <div class="uhp-section">
      <Typography text={ReactiveProp.Static("Upcoming 30 Days")} variant={Typography.H3} />
      <Grid columns={Count(2)} gap="1.5rem" class={ReactiveProp.Static("uhp-grid")}>
        <Card header="Events">
          {if Array.length(upcomingEvents) > 0 {
            <div class="uhp-list">
              {upcomingEvents
              ->Array.map(event => <UpcomingEventItem event />)
              ->Component.fragment}
            </div>
          } else {
            <Typography
              text={ReactiveProp.Static("No upcoming events.")} variant={Typography.Muted}
            />
          }}
        </Card>
        <Card header="Tasks">
          {if Array.length(upcomingTasks) > 0 {
            <div class="uhp-list">
              {upcomingTasks
              ->Array.map(task => <UpcomingTaskItem task />)
              ->Component.fragment}
            </div>
          } else {
            <Typography
              text={ReactiveProp.Static("No upcoming tasks.")} variant={Typography.Muted}
            />
          }}
        </Card>
      </Grid>
    </div>
  </div>
}

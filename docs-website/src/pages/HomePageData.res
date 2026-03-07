type user = {
  name: string,
  avatarUrl: string,
}

type event = {
  title: string,
  time: string,
  space: string,
  date: string,
}

type task = {
  title: string,
  completed: bool,
  space: string,
  dueDate: string,
  assignee: string,
}

type weather = {
  temperature: string,
  condition: string,
}

let currentUser: user = {
  name: "Alex Morgan",
  avatarUrl: "https://i.pravatar.cc/150?u=alex-morgan",
}

let weather: weather = {
  temperature: "72°F",
  condition: "Sunny",
}

let today = "2026-03-07"

let allEvents: array<event> = [
  {title: "Daily Standup", time: "9:00 AM", space: "Engineering", date: "2026-03-07"},
  {title: "Design Review", time: "2:00 PM", space: "Design", date: "2026-03-07"},
  {title: "Sprint Retro", time: "4:00 PM", space: "Engineering", date: "2026-03-07"},
  {title: "Roadmap Planning", time: "10:00 AM", space: "Product", date: "2026-03-09"},
  {title: "1:1 with Manager", time: "11:00 AM", space: "Engineering", date: "2026-03-10"},
  {title: "Team Lunch", time: "12:30 PM", space: "Social", date: "2026-03-12"},
  {title: "Architecture Review", time: "3:00 PM", space: "Engineering", date: "2026-03-14"},
  {title: "All Hands Meeting", time: "10:00 AM", space: "Company", date: "2026-03-17"},
  {title: "User Research Sync", time: "2:00 PM", space: "Design", date: "2026-03-20"},
  {title: "Release Planning", time: "11:00 AM", space: "Product", date: "2026-03-24"},
  {title: "Hackathon Kickoff", time: "9:00 AM", space: "Engineering", date: "2026-03-28"},
  {title: "Q1 Review", time: "10:00 AM", space: "Company", date: "2026-04-01"},
]

let allTasks: array<task> = [
  {
    title: "Review pull request #42",
    completed: true,
    space: "Engineering",
    dueDate: "2026-03-07",
    assignee: "Alex Morgan",
  },
  {
    title: "Deploy v1.7 to staging",
    completed: false,
    space: "Engineering",
    dueDate: "2026-03-07",
    assignee: "Alex Morgan",
  },
  {
    title: "Write integration tests",
    completed: false,
    space: "Engineering",
    dueDate: "2026-03-07",
    assignee: "Jordan Lee",
  },
  {
    title: "Update design tokens",
    completed: false,
    space: "Design",
    dueDate: "2026-03-07",
    assignee: "Sam Chen",
  },
  {
    title: "Fix sidebar navigation bug",
    completed: false,
    space: "Engineering",
    dueDate: "2026-03-09",
    assignee: "Alex Morgan",
  },
  {
    title: "Write API documentation",
    completed: false,
    space: "Product",
    dueDate: "2026-03-11",
    assignee: "Alex Morgan",
  },
  {
    title: "Implement dark mode for charts",
    completed: false,
    space: "Design",
    dueDate: "2026-03-15",
    assignee: "Alex Morgan",
  },
  {
    title: "Set up CI/CD pipeline",
    completed: false,
    space: "Engineering",
    dueDate: "2026-03-18",
    assignee: "Alex Morgan",
  },
  {
    title: "Accessibility audit",
    completed: false,
    space: "Design",
    dueDate: "2026-03-22",
    assignee: "Alex Morgan",
  },
  {
    title: "Performance optimization",
    completed: false,
    space: "Engineering",
    dueDate: "2026-03-30",
    assignee: "Alex Morgan",
  },
]

let getTodayEvents = () => {
  allEvents->Array.filter(e => e.date == today)
}

let getTodayTasks = () => {
  allTasks->Array.filter(t => t.dueDate == today)
}

let getUpcomingEvents = () => {
  allEvents->Array.filter(e => e.date > today)
}

let getUpcomingTasks = () => {
  allTasks->Array.filter(t => t.dueDate > today && t.assignee == currentUser.name)
}

let getGreeting = (hours: int): string => {
  if hours >= 5 && hours <= 11 {
    "Good morning"
  } else if hours >= 12 && hours <= 16 {
    "Good afternoon"
  } else if hours >= 17 && hours <= 20 {
    "Good evening"
  } else {
    "Good night"
  }
}

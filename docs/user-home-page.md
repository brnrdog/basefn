# User Home Page

## Overview

Implement an authenticated user's home page that displays their profile, local time, weather information, a welcoming message, and an overview of today's and upcoming tasks and events.

This page lives in the docs-website demo app and showcases Basefn components in a realistic application context: a personal dashboard powered by mock data and Xote Signals.

## Context

- **Framework**: ReScript + Xote (Signals-based reactivity)
- **Component library**: Basefn (40+ components, CSS variables theming)
- **Routing**: Xote Router (pattern-based, client-side)
- **State management**: Xote Signals + Computed
- **Icons**: Lucide (via `Basefn.Icon`)
- **Styling**: BEM-like CSS with CSS variables for theming

The project is a UI component library. There is no backend, no authentication system, and no database. All data (user profile, tasks, events, weather) will be mocked with Signals to demonstrate how Basefn components compose into a real page.

## Design

### Page Layout

```
┌──────────────────────────────────────────────────┐
│                  Welcome Header                   │
│  ┌──────────┐                                    │
│  │          │  User Name                         │
│  │  Avatar  │  Saturday, March 7, 2026           │
│  │  (big)   │  2:34 PM                           │
│  │          │  ☀ 72°F, Sunny                     │
│  └──────────┘                                    │
│  "Good afternoon, Alex! Here's your day."        │
├──────────────────────────────────────────────────┤
│              Today's Schedule                     │
│  ┌──────────────────┐  ┌──────────────────┐      │
│  │  Today's Events  │  │  Today's Tasks   │      │
│  │  (all spaces)    │  │  (all spaces)    │      │
│  │  - 9am Standup   │  │  ☑ Review PR     │      │
│  │  - 2pm Design    │  │  ☐ Deploy v1.7   │      │
│  │  - 4pm Retro     │  │  ☐ Write tests   │      │
│  └──────────────────┘  └──────────────────┘      │
├──────────────────────────────────────────────────┤
│           Upcoming 30 Days                        │
│  ┌──────────────────┐  ┌──────────────────┐      │
│  │ Upcoming Events  │  │ Upcoming Tasks   │      │
│  │ (assigned to me) │  │ (assigned to me) │      │
│  │  Mar 10 - ...    │  │  Mar 8 - ...     │      │
│  │  Mar 15 - ...    │  │  Mar 12 - ...    │      │
│  │  ...             │  │  ...             │      │
│  └──────────────────┘  └──────────────────┘      │
└──────────────────────────────────────────────────┘
```

### Data Model (Mock)

```rescript
// User
type user = {
  name: string,
  avatarUrl: string,
  timezone: string,
}

// Event
type event = {
  title: string,
  time: string,
  space: string,
  date: string,
}

// Task
type task = {
  title: string,
  completed: bool,
  space: string,
  dueDate: string,
  assignee: string,
}

// Weather
type weather = {
  temperature: string,
  condition: string,
}
```

### Welcoming Message Logic

The greeting varies by time of day:
- 5am-11am: "Good morning"
- 12pm-4pm: "Good afternoon"
- 5pm-8pm: "Good evening"
- 9pm-4am: "Good night"

### Components Used

From the Basefn library:
- `Avatar` — large user avatar (custom CSS for XL size)
- `Card` — section containers for events/tasks
- `Typography` — headings, text, muted captions
- `Badge` — space name labels, status indicators
- `Grid` — responsive two-column layout for cards
- `Separator` — visual dividers between sections
- `Icon` — decorative icons (Sun, Moon, Star, Check, etc.)
- `Checkbox` — task completion status (read-only display)

### Sections Breakdown

1. **Welcome Header**: Avatar (large), user name (H2), formatted date + live clock (Muted), weather info, personalized greeting (Lead).

2. **Today's Schedule**: Two-column grid. Left card lists today's events from all spaces with time and space badge. Right card lists today's tasks from all spaces with checkbox and space badge.

3. **Upcoming 30 Days**: Two-column grid. Left card lists upcoming events assigned to the current user, grouped or listed by date. Right card lists upcoming tasks assigned to the user with due dates.

## Implementation Plan

### Step 1: Create mock data module

**File**: `docs-website/src/pages/HomePageData.res`

- Define types: `user`, `event`, `task`, `weather`
- Create mock user with name, avatar URL, timezone
- Create mock events (mix of today and upcoming 30 days, from multiple spaces)
- Create mock tasks (mix of today and upcoming 30 days, assigned to different users)
- Create mock weather data
- Export helper functions: `getTodayEvents`, `getTodayTasks`, `getUpcomingEvents`, `getUpcomingTasks`
- Time-of-day greeting function

### Step 2: Create the UserHomePage component

**File**: `docs-website/src/pages/UserHomePage.res`

- Import Basefn components (Avatar, Card, Typography, Badge, Grid, Separator, Icon, Checkbox)
- Create a `currentTime` Signal updated every minute via `setInterval`
- Build the Welcome Header section with large avatar, name, date/time, weather
- Build Today's Schedule section with Grid of two Cards
- Build Upcoming 30 Days section with Grid of two Cards
- Render events with time, title, and space Badge
- Render tasks with Checkbox, title, due date, and space Badge

### Step 3: Create accompanying CSS

**File**: `docs-website/src/pages/UserHomePage.css`

- Style the large avatar (override to ~120px)
- Style the welcome header layout (flexbox, alignment)
- Style event and task list items (spacing, alignment)
- Responsive breakpoints (single column on mobile)
- Weather info styling
- Ensure compatibility with light/dark themes via CSS variables

### Step 4: Add route to DocsApp

**File**: `docs-website/src/DocsApp.res`

- Add route `{ pattern: "/home", render: ... }` that renders `<UserHomePage />`
- Wrap in `<DocsLayout>` with `showSidebar={false}` (like Homepage)

### Step 5: Build and verify

- Run `npm run build` to compile ReScript
- Run `npm run dev` to verify the page renders
- Check light/dark theme compatibility

## File Changes Summary

| File | Action |
|------|--------|
| `docs-website/src/pages/HomePageData.res` | Create |
| `docs-website/src/pages/UserHomePage.res` | Create |
| `docs-website/src/pages/UserHomePage.css` | Create |
| `docs-website/src/DocsApp.res` | Modify (add route) |

## Out of Scope

- Real authentication / login flow
- Backend API integration
- Real weather API calls
- Persistent task state (localStorage, DB)
- Drag-and-drop reordering
- Notifications or real-time updates

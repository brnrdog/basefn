%%raw(`import './eita.css'`)
// Main eita UI module - exposes all components and utilities

// Re-export component types
type selectOption = Eita__Select.selectOption
type inputType = Eita__Input.inputType
type buttonVariant = Eita__Button.variant
type badgeVariant = Eita__Badge.variant
type badgeSize = Eita__Badge.size
type spinnerSize = Eita__Spinner.size
type spinnerVariant = Eita__Spinner.variant
type separatorOrientation = Eita__Separator.orientation
type separatorVariant = Eita__Separator.variant
type kbdSize = Eita__Kbd.size
type typographyVariant = Eita__Typography.variant
type typographyAlign = Eita__Typography.align
type alertVariant = Eita__Alert.variant
type progressSize = Eita__Progress.size
type progressVariant = Eita__Progress.variant
type tab = Eita__Tabs.tab
type accordionItem = Eita__Accordion.accordionItem
type breadcrumbItem = Eita__Breadcrumb.breadcrumbItem
type modalSize = Eita__Modal.size
type tooltipPosition = Eita__Tooltip.position
type switchSize = Eita__Switch.size
type dropdownMenuItem = Eita__Dropdown.menuItem
type dropdownMenuContent = Eita__Dropdown.menuContent
type toastVariant = Eita__Toast.variant
type toastPosition = Eita__Toast.position
type stepperOrientation = Eita__Stepper.orientation
type stepStatus = Eita__Stepper.stepStatus
type stepperStep = Eita__Stepper.step
type drawerPosition = Eita__Drawer.position
type drawerSize = Eita__Drawer.size
type timelineOrientation = Eita__Timeline.orientation
type timelineVariant = Eita__Timeline.variant
type timelineItem = Eita__Timeline.timelineItem
type sidebarTheme = Eita__Sidebar.theme
type sidebarSize = Eita__Sidebar.size
type sidebarNavItem = Eita__Sidebar.navItem
type sidebarNavSection = Eita__Sidebar.navSection
type topbarTheme = Eita__Topbar.theme
type topbarSize = Eita__Topbar.size
type topbarNavItem = Eita__Topbar.navItem
type appLayoutContentWidth = Eita__AppLayout.contentWidth

// Form Components
module Button = Eita__Button
module Input = Eita__Input
module Textarea = Eita__Textarea
module Select = Eita__Select
module Checkbox = Eita__Checkbox
module Radio = Eita__Radio
module Label = Eita__Label

// Tier 1 Foundation Components
module Badge = Eita__Badge
module Spinner = Eita__Spinner
module Separator = Eita__Separator
module Kbd = Eita__Kbd
module Typography = Eita__Typography

// Tier 2
module Card = Eita__Card
module Avatar = Eita__Avatar
module Grid = Eita__Grid
module Alert = Eita__Alert
module Progress = Eita__Progress
module Tabs = Eita__Tabs
module Accordion = Eita__Accordion
module Breadcrumb = Eita__Breadcrumb

// Tier 3
module Modal = Eita__Modal
module Tooltip = Eita__Tooltip
module Switch = Eita__Switch
module Slider = Eita__Slider
module Dropdown = Eita__Dropdown
module Toast = Eita__Toast

// Tier 4 - Navigation & Layout
module Stepper = Eita__Stepper
module Drawer = Eita__Drawer
module Timeline = Eita__Timeline

// Application Layout
module Sidebar = Eita__Sidebar
module Topbar = Eita__Topbar
module AppLayout = Eita__AppLayout

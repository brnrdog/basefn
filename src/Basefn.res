%%raw(`import './basefn.css'`)
// Main basefn UI module - exposes all components and utilities

// Re-export component types
type selectOption = Basefn__Select.selectOption
type inputType = Basefn__Input.inputType
type buttonVariant = Basefn__Button.variant
type badgeVariant = Basefn__Badge.variant
type badgeSize = Basefn__Badge.size
type spinnerSize = Basefn__Spinner.size
type spinnerVariant = Basefn__Spinner.variant
type separatorOrientation = Basefn__Separator.orientation
type separatorVariant = Basefn__Separator.variant
type kbdSize = Basefn__Kbd.size
type typographyVariant = Basefn__Typography.variant
type typographyAlign = Basefn__Typography.align
type alertVariant = Basefn__Alert.variant
type progressSize = Basefn__Progress.size
type progressVariant = Basefn__Progress.variant
type tab = Basefn__Tabs.tab
type accordionItem = Basefn__Accordion.accordionItem
type breadcrumbItem = Basefn__Breadcrumb.breadcrumbItem
type modalSize = Basefn__Modal.size
type tooltipPosition = Basefn__Tooltip.position
type switchSize = Basefn__Switch.size
type dropdownMenuItem = Basefn__Dropdown.menuItem
type dropdownMenuContent = Basefn__Dropdown.menuContent
type toastVariant = Basefn__Toast.variant
type toastPosition = Basefn__Toast.position
type stepperOrientation = Basefn__Stepper.orientation
type stepStatus = Basefn__Stepper.stepStatus
type stepperStep = Basefn__Stepper.step
type drawerPosition = Basefn__Drawer.position
type drawerSize = Basefn__Drawer.size
type timelineOrientation = Basefn__Timeline.orientation
type timelineVariant = Basefn__Timeline.variant
type timelineItem = Basefn__Timeline.timelineItem
type sidebarSize = Basefn__Sidebar.size
type sidebarNavItem = Basefn__Sidebar.navItem
type sidebarNavSection = Basefn__Sidebar.navSection
type topbarSize = Basefn__Topbar.size
type topbarNavItem = Basefn__Topbar.navItem
type appLayoutContentWidth = Basefn__AppLayout.contentWidth

// Form Components
module Button = Basefn__Button
module Input = Basefn__Input
module Textarea = Basefn__Textarea
module Select = Basefn__Select
module Checkbox = Basefn__Checkbox
module Radio = Basefn__Radio
module Label = Basefn__Label

// Tier 1 Foundation Components
module Badge = Basefn__Badge
module Spinner = Basefn__Spinner
module Separator = Basefn__Separator
module Kbd = Basefn__Kbd
module Typography = Basefn__Typography

// Tier 2
module Card = Basefn__Card
module Avatar = Basefn__Avatar
module Grid = Basefn__Grid
module Alert = Basefn__Alert
module Progress = Basefn__Progress
module Tabs = Basefn__Tabs
module Accordion = Basefn__Accordion
module Breadcrumb = Basefn__Breadcrumb

// Tier 3
module Modal = Basefn__Modal
module Tooltip = Basefn__Tooltip
module Switch = Basefn__Switch
module Slider = Basefn__Slider
module Dropdown = Basefn__Dropdown
module Toast = Basefn__Toast

// Tier 4 - Navigation & Layout
module Stepper = Basefn__Stepper
module Drawer = Basefn__Drawer
module Timeline = Basefn__Timeline

// Application Layout
module Sidebar = Basefn__Sidebar
module Topbar = Basefn__Topbar
module AppLayout = Basefn__AppLayout

// Theme
module Theme = Basefn__Theme
module ThemeToggle = Basefn__ThemeToggle

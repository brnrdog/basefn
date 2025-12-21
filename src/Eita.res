%%raw(`import './Eita.css'`)
// Main Eita UI module - exposes all components and utilities

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

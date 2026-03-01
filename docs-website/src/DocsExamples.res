let getExamples = (componentName: string): array<DocsExample.t> => {
  switch componentName {
  | "button" => ButtonExamples.examples
  | "badge" => BadgeExamples.examples
  | "card" => CardExamples.examples
  | "input" => InputExamples.examples
  | "alert" => AlertExamples.examples
  | "tabs" => TabsExamples.examples
  | "textarea" => TextareaExamples.examples
  | "select" => SelectExamples.examples
  | "checkbox" => CheckboxExamples.examples
  | "radio" => RadioExamples.examples
  | "label" => LabelExamples.examples
  | "typography" => TypographyExamples.examples
  | "spinner" => SpinnerExamples.examples
  | "separator" => SeparatorExamples.examples
  | "kbd" => KbdExamples.examples
  | "avatar" => AvatarExamples.examples
  | "grid" => GridExamples.examples
  | "progress" => ProgressExamples.examples
  | "breadcrumb" => BreadcrumbExamples.examples
  | "accordion" => AccordionExamples.examples
  | "modal" => ModalExamples.examples
  | "switch" => SwitchExamples.examples
  | "slider" => SliderExamples.examples
  | "tooltip" => TooltipExamples.examples
  | "dropdown" => DropdownExamples.examples
  | "toast" => ToastExamples.examples
  | "stepper" => StepperExamples.examples
  | "drawer" => DrawerExamples.examples
  | "timeline" => TimelineExamples.examples
  | "sidebar" => SidebarExamples.examples
  | "topbar" => TopbarExamples.examples
  | "icon" => IconExamples.examples
  | "app-layout" => AppLayoutExamples.examples
  | _ => []
  }
}

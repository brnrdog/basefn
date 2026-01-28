open Xote
open Basefn

module VersionEntry = {
  @jsx.component
  let make = (~version: string, ~date: string, ~changes: array<(string, string)>) => {
    let changesSignal = Signal.make(changes)
    <Card style="margin-bottom: 1.5rem;">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0.5rem;">
        <Typography text={ReactiveProp.Static(version)} variant={Typography.H4} />
        <Badge label={Signal.make(date)} variant={Badge.Secondary} />
      </div>
      <div>
        {Component.list(changesSignal, change => {
          let (changeType, description) = change
          <div style="display: flex; gap: 0.5rem; margin-bottom: 0.25rem;">
            <Badge
              label={Signal.make(changeType)}
              variant={switch changeType {
              | "feat" => Badge.Primary
              | "fix" => Badge.Secondary
              | _ => Badge.Default
              }}
            />
            <Typography text={ReactiveProp.Static(description)} variant={Typography.P} />
          </div>
        })}
      </div>
    </Card>
  }
}

@jsx.component
let make = () => {
  <div class="docs-component-page">
    <Typography text={ReactiveProp.Static("Changelog")} variant={Typography.H2} />
    <Typography
      text={ReactiveProp.Static("Release history and updates.")}
      variant={Typography.Lead}
    />
    <VersionEntry
      version="1.3.0"
      date="2026-01-22"
      changes={[
        ("feat", "Remove scrolling effect from topbar"),
        ("feat", "Update xote from 4.10.0 to 4.11.0"),
      ]}
    />
    <VersionEntry
      version="1.2.0"
      date="2026-01-13"
      changes={[("feat", "Add topbar position option to layout")]}
    />
    <VersionEntry
      version="1.1.6"
      date="2026-01-10"
      changes={[("fix", "Different router instance when using basefn and xote")]}
    />
    <VersionEntry
      version="1.1.5"
      date="2026-01-10"
      changes={[("fix", "Base path for GitHub Pages")]}
    />
    <VersionEntry
      version="1.1.4"
      date="2026-01-09"
      changes={[("fix", "Base path in path utils"), ("fix", "Sidebar links")]}
    />
    <VersionEntry
      version="1.1.3"
      date="2026-01-08"
      changes={[
        ("fix", "Add base path support for GitHub Pages routing"),
        ("fix", "Docs router for GitHub Pages"),
      ]}
    />
    <VersionEntry
      version="1.1.2"
      date="2026-01-08"
      changes={[("fix", "Rename Basefn.css to basefn.css for case-sensitive filesystems")]}
    />
  </div>
}

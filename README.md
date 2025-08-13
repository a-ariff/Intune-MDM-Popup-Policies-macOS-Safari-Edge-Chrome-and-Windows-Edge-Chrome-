Comprehensive, cross-platform Microsoft Intune MDM popup policy templates and automation scripts for browser management on macOS and Windows endpoints.

Overview

Supports macOS: Safari, Edge, Chrome

Supports Windows: Edge, Chrome

Block-all by default with allow-list examples

PowerShell script injects allow/block lists per browser schema

GitHub Actions validate PowerShell and policy files

Repository Structure
Intune-MDM-Popup-Policies/
├─ scripts/
│ └─ New-IntunePopupPolicy.ps1
├─ policies/
│ ├─ macOS/
│ │ ├─ safari-popup-policy.xml
│ │ ├─ edge-popup-policy.json
│ │ └─ chrome-popup-policy.json
│ └─ windows/
│ ├─ edge-popup-policy.json
│ └─ chrome-popup-policy.json
└─ .github/workflows/
├─ ps-lint.yml
└─ validate-policies.yml

Features

Cross-platform coverage (macOS and Windows)

Multi-browser support (Safari, Edge, Chrome)

Intune-friendly templates (Graph-ready JSON, Safari XML)

Dynamic allow/block injection via PowerShell

CI checks: PowerShell lint and JSON/XML validation

Lint-safe logging and ShouldProcess

Quick Start

Clone
git clone https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-.git

Customize templates

macOS Chrome/Edge JSON: PopupsAllowedForUrls, PopupsBlockedForUrls, DefaultPopupsSetting

macOS Safari XML: AllowedPopupDomains / PerSitePreferences (script maps for you), plus default popup control

Windows Chrome/Edge JSON: PopupsAllowedForUrls, PopupsBlockedForUrls, DefaultPopupsSetting

Create a policy (example)
pwsh -NoProfile -File ./scripts/New-IntunePopupPolicy.ps1 -PolicyName "Corp Chrome Policy"
-Platform Windows -Browser Chrome
-PopupAction Block `
-AllowedSites "https://ww6.autotask.net","https://portal.office.com"

Keys Reference

Chrome/Edge (macOS and Windows)

DefaultPopupsSetting: 2 = Block, 1 = Allow

PopupsAllowedForUrls: ["https://example.com"]

PopupsBlockedForUrls: ["*"]

Safari (macOS XML)

Uses AllowedPopupDomains or PerSitePreferences for site-specific allow

Default behavior is controlled via the JavaScript-can-open-windows setting; the script maps this for you

CI/CD

PowerShell lint runs on script changes

Policy validation ensures JSON parses and XML is well-formed

Keep commits small and let CI verify before deployment

Security

Never store credentials in scripts or repo

Test policy changes in non-production first

Review CI output and policy effect before broad rollout

Contributing

PRs welcome. Ensure CI passes and follow clear commit messages.

Support

Open a GitHub issue for questions or feature requests

License

MIT


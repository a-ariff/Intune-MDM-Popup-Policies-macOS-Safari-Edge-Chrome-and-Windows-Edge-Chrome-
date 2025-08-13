# Intune MDM Popup Policies
Comprehensive cross-platform Microsoft Intune MDM popup policy templates and automation scripts for browser management on macOS and Windows endpoints.
## Overview
- **Platforms**: macOS (Safari, Edge, Chrome) | Windows (Edge, Chrome)
- **Default**: Block-all with allow-list examples
- **Automation**: PowerShell script injects allow/block lists per browser schema
- **CI/CD**: GitHub Actions validate PowerShell and policy files
## Repository Structure
```
Intune-MDM-Popup-Policies/
├── scripts/
│   └── New-IntunePopupPolicy.ps1
├── policies/
│   ├── macOS/
│   │   ├── safari-popup-policy.xml
│   │   ├── edge-popup-policy.json
│   │   └── chrome-popup-policy.json
│   └── windows/
│       ├── edge-popup-policy.json
│       └── chrome-popup-policy.json
└── .github/workflows/
    ├── ps-lint.yml
    └── validate-policies.yml
```
## Features
- Cross-platform coverage (macOS and Windows)
- Multi-browser support (Safari, Edge, Chrome)
- Intune-friendly templates (Graph-ready JSON, Safari XML)
- Dynamic allow/block injection via PowerShell
- CI checks: PowerShell lint and JSON/XML validation
- Lint-safe logging and ShouldProcess
## Quick Start
### 1. Clone Repository
```bash
git clone https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-.git
```
### 2. Customize Templates
**macOS Chrome/Edge JSON**: `PopupsAllowedForUrls`, `PopupsBlockedForUrls`, `DefaultPopupsSetting`
**macOS Safari XML**: `AllowedPopupDomains` / `PerSitePreferences` (script maps for you), plus default popup control
**Windows Chrome/Edge JSON**: `PopupsAllowedForUrls`, `PopupsBlockedForUrls`, `DefaultPopupsSetting`
### macOS Chrome (plist) quick deploy
1. **Upload plist**: Navigate to Intune Admin Center > Devices > Configuration profiles > Create profile
2. **Platform**: Select macOS > Settings Catalog
3. **Add settings**: Search "Google Chrome" > Upload chrome-popup-allow-ww6.plist
4. **Assign**: Target device groups and deploy
5. **Verify**: On target Mac, open Chrome and navigate to `chrome://policy` to confirm policy application
### Keys Reference
#### Chrome/Edge Popup Policy Keys
- **PopupsAllowedForUrls**: Array of URL patterns where popups are explicitly allowed
- **PopupsBlockedForUrls**: Array of URL patterns where popups are explicitly blocked
- **DefaultPopupsSetting**: Default popup behavior (1 = allow, 2 = block)
#### Safari Popup Policy Keys (macOS)
- **AllowedPopupDomains**: Array of domains permitted to show popups
- **PerSitePreferences**: Dictionary mapping domains to popup preferences
- **PopupPolicy**: Global popup policy setting
#### Key Assignments by Platform
| Platform | Browser | Allow Key | Block Key | Default Key |
|----------|---------|-----------|-----------|-------------|
| macOS | Chrome | PopupsAllowedForUrls | PopupsBlockedForUrls | DefaultPopupsSetting |
| macOS | Edge | PopupsAllowedForUrls | PopupsBlockedForUrls | DefaultPopupsSetting |
| macOS | Safari | AllowedPopupDomains | PerSitePreferences | PopupPolicy |
| Windows | Chrome | PopupsAllowedForUrls | PopupsBlockedForUrls | DefaultPopupsSetting |
| Windows | Edge | PopupsAllowedForUrls | PopupsBlockedForUrls | DefaultPopupsSetting |

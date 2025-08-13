---
title: "Intune Browser Pop-up Policy Guide"
---
# Intune Browser Pop-up Policy Guide
**Table of Contents**
- [macOS Chrome (JSON)](#macos-chrome-json)
- [macOS Chrome (plist)](#macos-chrome-plist)
- [macOS Edge (JSON)](#macos-edge-json)
- [macOS Safari (XML)](#macos-safari-xml)
- [Windows Chrome (JSON)](#windows-chrome-json)
- [Windows Edge (JSON)](#windows-edge-json)
- [Keys Reference](#keys-reference)
- [Step-by-Step Deployment](#step-by-step-deployment)
- [Troubleshooting & Verification](#troubleshooting--verification)

---

## macOS Chrome (JSON)
This configuration blocks pop-ups on all websites and prevents users from changing the permission. Only domains in PopupsAllowedForUrls are permitted.
```json
{
  "@odata.type": "#microsoft.graph.macOSOfficeSuiteApp",
  "displayName": "Chrome Popup Blocker Policy - macOS",
  "bundleId": "com.google.Chrome",
  "settings": {
    "DefaultPopupsSetting": 2,
    "PopupsAllowedForUrls": ["https://your-allowed-domain.example"],
    "PopupsBlockedForUrls": ["*"]
  }
}
```
**Deploy via Settings Catalog**
1. In Intune Admin Center → Devices → Configuration profiles → Create profile
2. Platform: **macOS**, Profile type: **Settings catalog**
3. Add settings for **Google Chrome**:
   - DefaultPopupsSetting = 2
   - PopupsAllowedForUrls = `["https://your-allowed-domain.example"]`
   - PopupsBlockedForUrls = `["*"]`

Verify on device via chrome://policy.

---

## macOS Chrome (plist)
This keeps Chrome's default popup behavior but explicitly allows pop-ups on the listed sites. You can verify applied policy in chrome://policy.

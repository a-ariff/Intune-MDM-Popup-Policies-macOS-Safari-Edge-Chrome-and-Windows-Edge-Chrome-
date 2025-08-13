---
title: "Complete Guide — Allowing Specific Pop-ups (Block All Others) in Chrome, Edge, and Safari via Intune"
---
# Complete Guide — Allowing Specific Pop-ups (Block All Others) in Chrome, Edge, and Safari via Intune

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

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>PopupsAllowedForUrls</key>
  <array>
    <string>https://your-allowed-domain.example</string>
  </array>
</dict>
</plist>
```

**Deploy via Custom Profile (macOS)**

1. In Intune Admin Center → Devices → Configuration profiles → Create profile
2. Platform: **macOS**, Profile type: **Custom**
3. Upload the plist file above, set Bundle ID: `com.google.Chrome`
4. Assign and deploy → verify in chrome://policy

---

## macOS Edge (JSON)

```json
{
  "@odata.type": "#microsoft.graph.macOSOfficeSuiteApp",
  "displayName": "Edge Popup Blocker Policy - macOS",
  "bundleId": "com.microsoft.Edge",
  "settings": {
    "DefaultPopupsSetting": 2,
    "PopupsAllowedForUrls": ["https://your-allowed-domain.example"],
    "PopupsBlockedForUrls": ["*"]
  }
}
```

---

## macOS Safari (XML)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>PopupBlocking</key>
  <true/>
  <key>AllowedPopupDomains</key>
  <array>
    <string>your-allowed-domain.example</string>
  </array>
</dict>
</plist>
```

**Deploy via Custom Profile (macOS)**

1. In Intune Admin Center → Devices → Configuration profiles → Create profile
2. Platform: **macOS**, Profile type: **Custom**
3. Upload the XML file above, set Bundle ID: `com.apple.Safari`
4. Assign and deploy → verify in Safari Preferences/Settings

**Optional:** If MDM profiles cannot be used, you can apply an allow entry via script. See scripts/Set-SafariPopupAllow.zsh (uses your-allowed-domain.example placeholder). Note: DB edits are brittle—prefer MDM profiles when possible.

---

## Windows Chrome (JSON)

```json
{
  "@odata.type": "#microsoft.graph.windowsUpdateForBusinessConfiguration",
  "displayName": "Chrome Popup Blocker Policy - Windows",
  "settings": {
    "DefaultPopupsSetting": 2,
    "PopupsAllowedForUrls": ["https://your-allowed-domain.example"],
    "PopupsBlockedForUrls": ["*"]
  }
}
```

---

## Windows Edge (JSON)

```json
{
  "@odata.type": "#microsoft.graph.windowsUpdateForBusinessConfiguration",
  "displayName": "Edge Popup Blocker Policy - Windows",
  "settings": {
    "DefaultPopupsSetting": 2,
    "PopupsAllowedForUrls": ["https://your-allowed-domain.example"],
    "PopupsBlockedForUrls": ["*"]
  }
}
```

---

## Keys Reference

| Browser / Platform | Allow Key               | Block Key               | Default Key            |
|--------------------|-------------------------|-------------------------|------------------------|
| Chrome & Edge      | PopupsAllowedForUrls    | PopupsBlockedForUrls    | DefaultPopupsSetting   |
| Safari (macOS)     | AllowedPopupDomains     | N/A                     | PopupBlocking          |

---

## Step-by-Step Deployment

1. **Settings Catalog (Windows/macOS Chrome & Edge)**
   - Create profile → Settings catalog
   - Select browser → configure keys as above
   - Assign and deploy → verify via `chrome://policy` or `edge://policy`

2. **Custom Profile (macOS plist & XML)**
   - Create profile → Custom
   - Upload plist (Chrome) or XML (Safari)
   - Assign and deploy → verify in browser or Safari Profiles/Settings

---

## Troubleshooting & Verification

- **Verify on device**:
- `chrome://policy` or `edge://policy` for JSON profiles
- System Preferences → Profiles (macOS) for XML/plist
- **Common fixes**:
- Confirm device enrollment & group assignment
- Force sync or restart browser/device
- Check syntax with `jq` (JSON) or `xmllint` (XML)

---

After that, your guide will be live at:

`https://a-ariff.github.io/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/popup-policy-guide.html`

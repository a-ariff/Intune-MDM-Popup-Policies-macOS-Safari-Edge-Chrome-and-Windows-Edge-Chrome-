---
title: "Intune Browser Pop-up Policy Guide"
---

![Repository Icon](assets/icon.svg)

[![PowerShell Lint](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/ps-lint.yml/badge.svg?branch=main)](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/ps-lint.yml?branch=main)
[![Validate Policies](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/validate-policies.yml/badge.svg?branch=main)](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/validate-policies.yml?branch=main)

# Intune Browser Pop-up Policy Guide

> **⚠️ IMPORTANT:** Before deploying any of these policies, make sure to replace all example domains (like `your-allowed-domain.example`) with your actual domain names. Failing to do so will result in non-functional popup policies.

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

### Multi-Domain Allow-list Example

```json
{
  "@odata.type": "#microsoft.graph.macOSOfficeSuiteApp",
  "displayName": "Chrome Popup Blocker Policy - macOS (Multi-Domain)",
  "bundleId": "com.google.Chrome",
  "settings": {
    "DefaultPopupsSetting": 2,
    "PopupsAllowedForUrls": [
      "https://example.com",
      "https://subdomain.example.com",
      "https://another-domain.com"
    ],
    "PopupsBlockedForUrls": ["*"]
  }
}
```

---

## macOS Chrome (plist)

Alternative plist format for macOS Chrome configuration.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>PayloadContent</key>
    <array>
        <dict>
            <key>PayloadDisplayName</key>
            <string>Chrome Policy</string>
            <key>PayloadIdentifier</key>
            <string>com.google.Chrome</string>
            <key>PayloadType</key>
            <string>com.google.Chrome</string>
            <key>PayloadUUID</key>
            <string>550e8400-e29b-41d4-a716-446655440000</string>
            <key>PayloadVersion</key>
            <integer>1</integer>
            <key>DefaultPopupsSetting</key>
            <integer>2</integer>
            <key>PopupsAllowedForUrls</key>
            <array>
                <string>https://your-allowed-domain.example</string>
            </array>
            <key>PopupsBlockedForUrls</key>
            <array>
                <string>*</string>
            </array>
        </dict>
    </array>
    <key>PayloadDisplayName</key>
    <string>Chrome Popup Policy</string>
    <key>PayloadIdentifier</key>
    <string>com.example.chrome.popup</string>
    <key>PayloadType</key>
    <string>Configuration</string>
    <key>PayloadUUID</key>
    <string>550e8400-e29b-41d4-a716-446655440001</string>
    <key>PayloadVersion</key>
    <integer>1</integer>
</dict>
</plist>
```

---

## macOS Edge (JSON)

Microsoft Edge configuration for macOS.

```json
{
  "@odata.type": "#microsoft.graph.macOSOfficeSuiteApp",
  "displayName": "Edge Popup Blocker Policy - macOS",
  "bundleId": "com.microsoft.edgemac",
  "settings": {
    "DefaultPopupsSetting": 2,
    "PopupsAllowedForUrls": ["https://your-allowed-domain.example"],
    "PopupsBlockedForUrls": ["*"]
  }
}
```

---

## macOS Safari (XML)

Safari configuration profile for macOS.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>PayloadContent</key>
    <array>
        <dict>
            <key>PayloadDisplayName</key>
            <string>Safari Restrictions</string>
            <key>PayloadIdentifier</key>
            <string>com.apple.Safari</string>
            <key>PayloadType</key>
            <string>com.apple.Safari</string>
            <key>PayloadUUID</key>
            <string>550e8400-e29b-41d4-a716-446655440002</string>
            <key>PayloadVersion</key>
            <integer>1</integer>
            <key>com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically</key>
            <false/>
            <key>WebKitJavaScriptCanOpenWindowsAutomatically</key>
            <false/>
        </dict>
    </array>
    <key>PayloadDisplayName</key>
    <string>Safari Popup Blocker</string>
    <key>PayloadIdentifier</key>
    <string>com.example.safari.popup</string>
    <key>PayloadType</key>
    <string>Configuration</string>
    <key>PayloadUUID</key>
    <string>550e8400-e29b-41d4-a716-446655440003</string>
    <key>PayloadVersion</key>
    <integer>1</integer>
</dict>
</plist>
```

---

## Windows Chrome (JSON)

Chrome configuration for Windows devices.

```json
{
  "@odata.type": "#microsoft.graph.windows10GeneralConfiguration",
  "displayName": "Chrome Popup Blocker Policy - Windows",
  "description": "Blocks popups on Chrome for Windows",
  "defenderBlockOnAccessProtection": false,
  "defenderRealTimeScanDirection": "monitorAllFiles",
  "defenderScheduleScanDay": "everyday",
  "defenderScanType": "quick",
  "defenderSystemScanSchedule": "0",
  "defenderScheduledScanTime": "120",
  "defenderScheduledQuickScanTime": "120",
  "defenderCloudBlockLevel": "high",
  "defenderCloudExtendedTimeout": 50,
  "defenderDaysBeforeDeletingQuarantinedMalware": 30,
  "defenderDetectedMalwareActions": {
    "lowSeverity": "clean",
    "moderateSeverity": "quarantine",
    "highSeverity": "remove",
    "severeSeverity": "allow"
  },
  "chromeConfiguration": {
    "DefaultPopupsSetting": 2,
    "PopupsAllowedForUrls": ["https://your-allowed-domain.example"],
    "PopupsBlockedForUrls": ["*"]
  }
}
```

---

## Windows Edge (JSON)

Microsoft Edge configuration for Windows devices.

```json
{
  "@odata.type": "#microsoft.graph.windows10GeneralConfiguration",
  "displayName": "Edge Popup Blocker Policy - Windows",
  "description": "Blocks popups on Edge for Windows",
  "edgeConfiguration": {
    "DefaultPopupsSetting": 2,
    "PopupsAllowedForUrls": ["https://your-allowed-domain.example"],
    "PopupsBlockedForUrls": ["*"]
  }
}
```

---

## Keys Reference

### DefaultPopupsSetting Values
- `1`: Allow all sites to show pop-ups
- `2`: Block all sites from showing pop-ups (recommended)
- `3`: Ask user when a site wants to show pop-ups

### URL Pattern Examples
- `"*"`: All URLs
- `"https://*"`: All HTTPS URLs
- `"https://example.com"`: Specific domain
- `"https://*.example.com"`: All subdomains of example.com
- `"https://example.com/*"`: All pages on example.com

---

## Step-by-Step Deployment

### For macOS Devices:

1. **Open Microsoft Endpoint Manager**
   - Navigate to [https://endpoint.microsoft.com](https://endpoint.microsoft.com)
   - Sign in with your admin credentials

2. **Create Configuration Profile**
   - Go to **Devices** > **Configuration profiles**
   - Click **+ Create profile**
   - Select **Platform**: macOS
   - Select **Profile type**: Custom

3. **Configure Settings**
   - Enter a **Name** and **Description**
   - In **Configuration settings**, upload your plist file or paste the JSON configuration
   - **IMPORTANT**: Replace `your-allowed-domain.example` with your actual domains

4. **Assign to Groups**
   - Go to **Assignments**
   - Select the device groups or users to target
   - Review and create the policy

### For Windows Devices:

1. **Create Device Configuration**
   - Go to **Devices** > **Configuration profiles**
   - Click **+ Create profile**
   - Select **Platform**: Windows 10 and later
   - Select **Profile type**: Administrative Templates

2. **Configure Browser Settings**
   - Navigate to browser-specific settings (Chrome/Edge)
   - Configure popup blocker settings
   - Add allowed/blocked URL lists

3. **Deploy and Monitor**
   - Assign to appropriate groups
   - Monitor compliance and deployment status

---

## Troubleshooting & Verification

### Verification Steps:

1. **Check Policy Application**
   ```bash
   # macOS Chrome
   defaults read com.google.Chrome DefaultPopupsSetting
   
   # macOS Edge
   defaults read com.microsoft.edgemac DefaultPopupsSetting
   ```

2. **Browser Verification**
   - Open browser settings
   - Navigate to Privacy/Security settings
   - Check popup blocker configuration
   - Test with known popup sites

3. **Intune Reporting**
   - Check device compliance status
   - Review configuration profile deployment reports
   - Monitor for any errors or conflicts

### Common Issues:

- **Policy not applying**: Check device enrollment and group assignment
- **Popups still appearing**: Verify URL patterns and allowed domains
- **User can override**: Ensure policy is set to "Force" or "Required"
- **Conflicts with existing policies**: Review all browser-related configurations

### Logs and Diagnostics:

```bash
# macOS - Check system logs
sudo log show --predicate 'subsystem == "com.apple.ManagedClient"' --last 1h

# Windows - Check Event Viewer
# Navigate to: Applications and Services Logs > Microsoft > Windows > DeviceManagement-Enterprise-Diagnostics-Provider
```

---

*Last updated: 2024*

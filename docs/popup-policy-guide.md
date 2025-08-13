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

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>PayloadContent</key>
  <array>
    <dict>
      <key>PayloadDisplayName</key>
      <string>Chrome Popup Blocker Policy</string>
      <key>PayloadIdentifier</key>
      <string>com.google.Chrome.popup-policy</string>
      <key>PayloadType</key>
      <string>com.google.Chrome</string>
      <key>PayloadUUID</key>
      <string>REPLACE_WITH_GENERATED_UUID</string>
      <key>PayloadVersion</key>
      <integer>1</integer>
      <key>PopupsAllowedForUrls</key>
      <array>
        <string>https://your-allowed-domain.example</string>
      </array>
    </dict>
  </array>
  <key>PayloadDisplayName</key>
  <string>Chrome Popup Policy</string>
  <key>PayloadIdentifier</key>
  <string>chrome.popup.policy</string>
  <key>PayloadType</key>
  <string>Configuration</string>
  <key>PayloadUUID</key>
  <string>REPLACE_WITH_GENERATED_UUID</string>
  <key>PayloadVersion</key>
  <integer>1</integer>
</dict>
</plist>
```

---

## macOS Edge (JSON)

This blocks pop-ups on all websites except those explicitly allowed.

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

This configuration disables pop-ups in Safari.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>PayloadContent</key>
  <array>
    <dict>
      <key>PayloadDisplayName</key>
      <string>Safari Popup Blocker</string>
      <key>PayloadIdentifier</key>
      <string>com.apple.Safari.popup-policy</string>
      <key>PayloadType</key>
      <string>com.apple.Safari</string>
      <key>PayloadUUID</key>
      <string>REPLACE_WITH_GENERATED_UUID</string>
      <key>PayloadVersion</key>
      <integer>1</integer>
      <key>com.apple.Safari.ContentPageGroupIdentifier.WebKitJavaScriptCanOpenWindowsAutomatically</key>
      <false/>
    </dict>
  </array>
  <key>PayloadDisplayName</key>
  <string>Safari Popup Blocker Policy</string>
  <key>PayloadIdentifier</key>
  <string>safari.popup.policy</string>
  <key>PayloadType</key>
  <string>Configuration</string>
  <key>PayloadUUID</key>
  <string>REPLACE_WITH_GENERATED_UUID</string>
  <key>PayloadVersion</key>
  <integer>1</integer>
</dict>
</plist>
```

---

## Windows Chrome (JSON)

This blocks pop-ups on all websites except those explicitly allowed.

```json
{
  "@odata.type": "#microsoft.graph.windows10GeneralConfiguration",
  "displayName": "Chrome Popup Blocker Policy - Windows",
  "chromeDefaultPopupsSetting": 2,
  "chromePopupsAllowedForUrls": ["https://your-allowed-domain.example"],
  "chromePopupsBlockedForUrls": ["*"]
}
```

### Deploy via Templates

Use Intune Settings Catalog templates for Chrome or ADMX-backed templates:

1. **Create profile** → Devices → Configuration profiles → Create profile
2. Platform: **Windows 10 and later**, Profile type: **Templates**
3. Select **Administrative Templates**
4. **Select Chrome** (Google Chrome or Microsoft Edge)
5. **Configure popup settings keys**:
   - Navigate to Chrome/Edge policies
   - Set **Default pop-up setting** = Block (2)
   - Configure **Pop-ups allowed for URLs** = `https://your-allowed-domain.example`
   - Configure **Pop-ups blocked for URLs** = `*`

The JSON method above remains available as an alternative deployment approach.

---

## Windows Edge (JSON)

This blocks pop-ups on all websites except those explicitly allowed.

```json
{
  "@odata.type": "#microsoft.graph.windows10GeneralConfiguration",
  "displayName": "Edge Popup Blocker Policy - Windows",
  "edgeDefaultPopupsSetting": 2,
  "edgePopupsAllowedForUrls": ["https://your-allowed-domain.example"],
  "edgePopupsBlockedForUrls": ["*"]
}
```

### Deploy via Templates

Use Intune Settings Catalog templates for Edge or ADMX-backed templates:

1. **Create profile** → Devices → Configuration profiles → Create profile
2. Platform: **Windows 10 and later**, Profile type: **Templates**
3. Select **Administrative Templates**
4. **Select Edge** (Microsoft Edge)
5. **Configure popup settings keys**:
   - Navigate to Edge policies
   - Set **Default pop-up setting** = Block (2)
   - Configure **Pop-ups allowed for URLs** = `https://your-allowed-domain.example`
   - Configure **Pop-ups blocked for URLs** = `*`

The JSON method above remains available as an alternative deployment approach.

---

## Keys Reference

### Popup Settings Values

• 0 = Allow all pop-ups
• 1 = Block all pop-ups (default)
• 2 = Block all pop-ups (enforced)

### URL Format Examples

• https://example.com - Specific domain
• https://*.example.com - All subdomains
• * - All websites (wildcard)

---

## Step-by-Step Deployment

### 1. Prepare Your Configuration

• Choose the appropriate configuration for your platform
• Replace placeholder domains with your actual allowed sites
• Generate UUIDs where required (see [Generate a UUID](#generate-a-uuid) section)

### 2. Deploy via Intune

1. Sign in to Microsoft Intune Admin Center
2. Navigate to Devices → Configuration profiles
3. Click Create profile
4. Select your platform (Windows/macOS) and profile type
5. Configure the policy settings
6. Assign to appropriate groups
7. Review and create

### 3. Monitor Deployment

• Check deployment status in Intune
• Verify policy application on test devices
• Monitor for any deployment failures

### Generate a UUID

When working with configuration profiles that require UUIDs (such as plist files), you'll need to generate unique identifiers. Here are the commands for different operating systems:

**macOS:**
```bash
uuidgen
```

**Windows (PowerShell):**
```powershell
[System.Guid]::NewGuid().ToString()
```

**Linux:**
```bash
uuidgen
# or
cat /proc/sys/kernel/random/uuid
```

**Note:** UUIDs generated are in standard GUID format (8-4-4-4-12 hexadecimal digits). Replace `REPLACE_WITH_GENERATED_UUID` placeholders in configuration files with the generated UUID.

---

## Troubleshooting & Verification

### Verify Policy Application

**Chrome (macOS/Windows):**
1. Open Chrome
2. Navigate to `chrome://policy`
3. Look for popup-related settings
4. Verify values match your configuration

**Edge (macOS/Windows):**
1. Open Edge
2. Navigate to `edge://policy`
3. Look for popup-related settings
4. Verify values match your configuration

**Safari (macOS):**
1. Check System Preferences → Profiles
2. Verify your profile is installed
3. Test popup behavior on websites

### Common Issues

**Policy Not Applying:**
- Check device compliance status
- Verify group assignments
- Allow 15-30 minutes for policy sync
- Try manual sync from Company Portal

**Pop-ups Still Appearing:**
- Verify URL formatting in allowed/blocked lists
- Check for conflicting browser extensions
- Test in incognito/private mode
- Clear browser cache and restart

**plist Deployment Issues:**
- Ensure valid XML formatting
- Verify UUID format is correct
- Check payload identifiers are unique
- Validate plist syntax with `plutil -lint filename.plist`

### Testing Your Configuration

1. **Test Blocked Sites:**
   - Visit known popup-heavy websites
   - Verify popups are blocked

2. **Test Allowed Sites:**
   - Visit domains in your allow list
   - Verify legitimate popups work

3. **Test User Restrictions:**
   - Try to change popup settings in browser
   - Settings should be grayed out/disabled

### Support Resources

- [Microsoft Intune Documentation](https://docs.microsoft.com/en-us/mem/intune/)
- [Chrome Enterprise Policy List](https://chromeenterprise.google/policies/)
- [Edge Enterprise Policy Reference](https://docs.microsoft.com/en-us/deployedge/microsoft-edge-policies)
- [Apple Configuration Profile Reference](https://developer.apple.com/business/documentation/Configuration-Profile-Reference.pdf)

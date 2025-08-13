# Intune MDM Popup Policies

Comprehensive cross-platform Microsoft Intune MDM popup policy templates and automation scripts for browser management on macOS and Windows endpoints.

## Overview
- **Platforms**: macOS (Safari, Edge, Chrome) | Windows (Edge, Chrome)
- **Default**: Block-all with allow-list examples
- **Automation**: PowerShell script injects allow/block lists per browser schema
- **CI/CD**: GitHub Actions validate PowerShell and policy files
- 📄 [Complete Deployment Guide (GitHub Pages)](https://a-ariff.github.io/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/popup-policy-guide)

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

## Step-by-step deployment guide

### Windows Chrome/Edge (Settings Catalog)

#### Prerequisites
- Microsoft Intune subscription
- Windows devices enrolled in Intune
- Admin access to Microsoft Intune Admin Center

#### Steps
1. Navigate to Intune Admin Center
   - Go to https://intune.microsoft.com
   - Sign in with admin credentials

2. Create Configuration Profile
   - Navigate to Devices > Configuration profiles
   - Click "Create profile"
   - Platform: Select "Windows 10 and later"
   - Profile type: Select "Settings catalog"
   - Click "Create"

3. Add Browser Settings
   - Click "Add settings"
   - Search for "Microsoft Edge" or "Google Chrome"
   - Expand the browser section
   - Select popup-related settings:
     - PopupsAllowedForUrls
     - PopupsBlockedForUrls
     - DefaultPopupsSetting

4. Configure Popup Policies
   - PopupsAllowedForUrls: Add allowed URL patterns (e.g., "https://trusted-site.com/*")
   - PopupsBlockedForUrls: Add blocked URL patterns (e.g., "https://malicious-site.com/*")
   - DefaultPopupsSetting: Set to 2 (block by default)

5. Assign and Deploy
   - Click "Next" through configuration
   - Assign to target device groups
   - Review settings and click "Create"

6. Verification
   - On target Windows device, open browser
   - Navigate to edge://policy (Edge) or chrome://policy (Chrome)
   - Verify policies are applied

### macOS Chrome/Edge (Settings Catalog)

#### Prerequisites
- Microsoft Intune subscription
- macOS devices enrolled in Intune
- Admin access to Microsoft Intune Admin Center

#### Steps
1. Navigate to Intune Admin Center
   - Go to https://intune.microsoft.com
   - Sign in with admin credentials

2. Create Configuration Profile
   - Navigate to Devices > Configuration profiles
   - Click "Create profile"
   - Platform: Select "macOS"
   - Profile type: Select "Settings catalog"
   - Click "Create"

3. Add Browser Settings
   - Click "Add settings"
   - Search for "Microsoft Edge" or "Google Chrome"
   - Expand the browser section
   - Select popup-related settings:
     - PopupsAllowedForUrls
     - PopupsBlockedForUrls
     - DefaultPopupsSetting

4. Configure Popup Policies
   - PopupsAllowedForUrls: Add allowed URL patterns
   - PopupsBlockedForUrls: Add blocked URL patterns
   - DefaultPopupsSetting: Set to 2 (block by default)

5. Assign and Deploy
   - Click "Next" through configuration
   - Assign to target device groups
   - Review settings and click "Create"

6. Verification
   - On target macOS device, open browser
   - Navigate to chrome://policy or edge://policy
   - Verify policies are applied

### macOS Chrome (plist)

#### Prerequisites
- Chrome plist file from repository
- macOS devices enrolled in Intune
- Admin access to Microsoft Intune Admin Center

#### Steps
1. Download Policy File
   - Download chrome-popup-policy.json from repository
   - Convert to plist format if needed

2. Navigate to Intune Admin Center
   - Go to https://intune.microsoft.com
   - Sign in with admin credentials

3. Create Configuration Profile
   - Navigate to Devices > Configuration profiles
   - Click "Create profile"
   - Platform: Select "macOS"
   - Profile type: Select "Custom"
   - Click "Create"

4. Upload Configuration
   - Configuration profile name: "Chrome Popup Policy"
   - Deployment channel: Select "Device channel"
   - Custom configuration profile name: "com.google.Chrome"
   - Upload the plist file

5. Assign and Deploy
   - Click "Next" through configuration
   - Assign to target device groups
   - Review settings and click "Create"

6. Verification
   - On target macOS device, open Chrome
   - Navigate to chrome://policy
   - Verify popup policies are applied

### macOS Safari (XML)

#### Prerequisites
- Safari XML policy file from repository
- macOS devices enrolled in Intune
- Admin access to Microsoft Intune Admin Center

#### Steps
1. Download Policy File
   - Download safari-popup-policy.xml from repository

2. Navigate to Intune Admin Center
   - Go to https://intune.microsoft.com
   - Sign in with admin credentials

3. Create Configuration Profile
   - Navigate to Devices > Configuration profiles
   - Click "Create profile"
   - Platform: Select "macOS"
   - Profile type: Select "Custom"
   - Click "Create"

4. Upload Configuration
   - Configuration profile name: "Safari Popup Policy"
   - Deployment channel: Select "Device channel"
   - Custom configuration profile name: "com.apple.Safari"
   - Upload the XML file

5. Configure Safari Settings
   - Ensure XML contains:
     - AllowedPopupDomains array
     - PerSitePreferences dictionary
     - PopupPolicy global setting

6. Assign and Deploy
   - Click "Next" through configuration
   - Assign to target device groups
   - Review settings and click "Create"

7. Verification
   - On target macOS device, open Safari
   - Navigate to Safari Preferences > Websites > Pop-up Windows
   - Verify policy settings are applied

### References
- **Microsoft Intune Configuration Profiles**: https://docs.microsoft.com/en-us/mem/intune/configuration/
- **Chrome Enterprise Policy List**: https://chromeenterprise.google/policies/
- **Microsoft Edge Policy Reference**: https://docs.microsoft.com/en-us/deployedge/4f30c79d
- **Safari Configuration Profile Keys**: https://developer.apple.com/documentation/devicemanagement/safari
- **Intune Settings Catalog**: https://docs.microsoft.com/en-us/mem/intune/configuration/settings-catalog

### Baseline Recommendations

#### Security Baseline
- Default Popup Setting: Block (value: 2)
- Allowed URLs: Only trusted corporate domains
- Blocked URLs: Known malicious or problematic sites
- Testing: Always test in pilot group before production deployment

#### Corporate Environment Baseline
```json
{
  "DefaultPopupsSetting": 2,
  "PopupsAllowedForUrls": [
    "https://*.company.com/*",
    "https://trusted-partner.com/*",
    "https://office.com/*",
    "https://*.sharepoint.com/*"
  ],
  "PopupsBlockedForUrls": [
    "https://*.ads.com/*",
    "https://malicious-site.com/*"
  ]
}
```

#### Educational Environment Baseline
```json
{
  "DefaultPopupsSetting": 2,
  "PopupsAllowedForUrls": [
    "https://*.edu/*",
    "https://classroom.google.com/*",
    "https://teams.microsoft.com/*",
    "https://*.instructure.com/*"
  ]
}
```

### Troubleshooting

#### Common Issues

**Policy Not Applying**
- Check device enrollment status in Intune
- Verify policy assignment to correct groups
- Force sync on target device
- Check for conflicting policies

**Chrome/Edge Policies Not Visible**
- Navigate to chrome://policy or edge://policy
- If policies are missing:
  - Check policy syntax in JSON files
  - Verify Settings Catalog configuration
  - Restart browser after policy deployment

**Safari Policies Not Working**
- Check System Preferences > Profiles for policy installation
- Verify XML syntax and structure
- Restart Safari after policy deployment
- Check Safari preferences for applied restrictions

**macOS Custom Profile Issues**
- Verify plist/XML file format
- Check bundle identifier matches browser
- Ensure proper signing of configuration profile
- Review device logs for deployment errors

#### Diagnostic Commands

**Windows PowerShell**
```powershell
# Check registry for Edge policies
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge"

# Check registry for Chrome policies
Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome"

# Force Intune sync
Get-ScheduledTask | Where-Object {$_.TaskName -eq 'PushLaunch'} | Start-ScheduledTask
```

**macOS Terminal**
```bash
# Check Chrome preferences
defaults read com.google.Chrome

# Check Safari preferences
defaults read com.apple.Safari

# Check installed profiles
sudo profiles -P

# Force policy refresh
sudo profiles renew -type enrollment
```

#### Policy Validation

**JSON Validation**
```bash
# Validate JSON syntax
jq . policies/windows/chrome-popup-policy.json
```

**XML Validation**
```bash
# Validate XML syntax
xmllint --noout policies/macOS/safari-popup-policy.xml
```

**PowerShell Policy Testing**
```powershell
# Test policy generation script
.\scripts\New-IntunePopupPolicy.ps1 -WhatIf
```

#### Support Resources
- **Microsoft Intune Support**: https://docs.microsoft.com/en-us/mem/get-support
- **Chrome Enterprise Support**: https://support.google.com/chrome/a/
- **Microsoft Edge Support**: https://docs.microsoft.com/en-us/deployedge/
- **Apple Configuration Profile Support**: https://developer.apple.com/support/

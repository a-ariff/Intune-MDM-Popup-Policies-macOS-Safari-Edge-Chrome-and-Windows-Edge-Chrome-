---
title: "Intune Browser Pop-up Policy Guide"
---

# Intune Browser Pop-up Policy Guide

## Status

[![Lint](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/workflows/Lint/badge.svg)](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/lint.yml)
[![Pages](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/workflows/Pages/badge.svg)](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/pages.yml)

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

For organizations that need to allow pop-ups on multiple domains:

```json
{
  "@odata.type": "#microsoft.graph.macOSOfficeSuiteApp",
  "displayName": "Chrome Popup Blocker Policy - macOS (Multi-Domain)",
  "bundleId": "com.google.Chrome",
  "settings": {
    "DefaultPopupsSetting": 2,
    "PopupsAllowedForUrls": [
      "https://app.company.com",
      "https://portal.company.com",
      "https://helpdesk.company.com",
      "https://training.company.com"
    ],
    "PopupsBlockedForUrls": ["*"]
  }
}
```

**Deploy via Settings Catalog**

1. In Intune Admin Center → Devices → Configuration profiles → Create profile

![Repository Icon](docs/assets/icon.svg)

# Intune MDM Popup Policies
[![PowerShell Lint](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/ps-lint.yml/badge.svg)](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/ps-lint.yml)
[![pages-build-deployment](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/pages/pages-build-deployment)

Comprehensive cross-platform Microsoft Intune MDM popup policy templates and automation scripts for browser management on macOS and Windows endpoints.

📄 **Complete Deployment Guide:** [View on GitHub](docs/popup-policy-guide.md) | [View on GitHub Pages](https://a-ariff.github.io/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/popup-policy-guide) - Essential setup and configuration instructions

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

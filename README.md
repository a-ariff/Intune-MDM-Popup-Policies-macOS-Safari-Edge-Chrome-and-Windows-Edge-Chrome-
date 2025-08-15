![Repository Icon](docs/assets/icon.svg)

# Intune MDM Popup Policies for Windows/macOS (Edge, Chrome, Safari)

[![PowerShell Lint](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/ps-lint.yml/badge.svg?branch=main)](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/ps-lint.yml?branch=main)
[![Validate Policies](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/validate-policies.yml/badge.svg?branch=main)](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/actions/workflows/validate-policies.yml?branch=main)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Comprehensive cross-platform Microsoft Intune MDM popup policy templates and automation scripts for browser management on macOS and Windows endpoints.

📄 **Complete Deployment Guide:** [View on GitHub](docs/popup-policy-guide.md) | [View on GitHub Pages](https://a-ariff.github.io/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/popup-policy-guide) - Essential setup and configuration instructions

## Overview

- **Platforms**: macOS (Safari, Edge, Chrome) | Windows (Edge, Chrome)
- **Default**: Block-all with allow-list examples
- **Automation**: PowerShell script injects allow/block lists per browser schema
- **CI/CD**: GitHub Actions validate PowerShell and policy files

## Features

- ✅ Cross-platform coverage (macOS and Windows)
- ✅ Multi-browser support (Safari, Edge, Chrome)
- ✅ Intune-friendly templates (Graph-ready JSON, Safari XML)
- ✅ Dynamic allow/block injection via PowerShell
- ✅ CI checks: PowerShell lint and JSON/XML validation
- ✅ Lint-safe logging and ShouldProcess

## Quickstart (5-min)

### 1. Clone Repository
```bash
git clone https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-.git
cd Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-
```

### 2. Customize Templates
```powershell
# Edit allow/block lists in policies folder
# macOS Chrome/Edge JSON: PopupsAllowedForUrls, PopupsBlockedForUrls, DefaultPopupsSetting
# Windows Chrome/Edge JSON: Same structure
# macOS Safari XML: PopupsBlockedForUrls, DefaultPopupsSetting
```

### 3. Deploy to Intune
```powershell
# Use provided PowerShell script
.\scripts\New-IntunePopupPolicy.ps1 -Platform macOS -Browser Chrome
```

## Compatibility Matrix

| Platform | Safari | Edge | Chrome | Status |
|----------|--------|------|--------|---------|
| macOS 11+ | ✅ | ✅ | ✅ | Tested |
| macOS 10.15 | ✅ | ❌ | ✅ | Partial |
| Windows 10 | ❌ | ✅ | ✅ | Tested |
| Windows 11 | ❌ | ✅ | ✅ | Tested |
| iOS | ❌ | ❌ | ❌ | N/A |

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
├── docs/
│   ├── popup-policy-guide.md
│   └── assets/
└── .github/workflows/
    ├── ps-lint.yml
    └── validate-policies.yml
```

## Configuration

### Browser-Specific Settings

#### Chrome & Edge (JSON)
```json
{
  "PopupsAllowedForUrls": [
    "https://example.com",
    "https://trusted-site.com"
  ],
  "PopupsBlockedForUrls": [
    "https://malicious-site.com"
  ],
  "DefaultPopupsSetting": 2
}
```

#### Safari (XML)
```xml
<dict>
  <key>PopupsBlockedForUrls</key>
  <array>
    <string>https://malicious-site.com</string>
  </array>
  <key>DefaultPopupsSetting</key>
  <integer>2</integer>
</dict>
```

## Troubleshooting

### Common Issues

**Policy not applying**
- Check device compliance in Intune admin center
- Verify policy assignment to correct groups
- Allow 24-48 hours for policy propagation

**Browser not recognizing policy**
- Ensure browser is managed by Intune
- Check browser version compatibility
- Restart browser after policy deployment

**PowerShell script errors**
- Run with `-Verbose` flag for detailed logging
- Check execution policy: `Set-ExecutionPolicy RemoteSigned`
- Verify all dependencies are installed

## Roadmap

- [ ] **Q1 2025**: Add Firefox support
- [ ] **Q2 2025**: Mobile browser policies (iOS Safari)
- [ ] **Q3 2025**: Automated policy compliance reporting
- [ ] **Q4 2025**: Integration with Microsoft Graph PowerShell SDK v2

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 📖 [Documentation](docs/popup-policy-guide.md)
- 🐛 [Issues](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/issues)
- 💬 [Discussions](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/discussions)

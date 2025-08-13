# Intune MDM Popup Policies — macOS (Safari, Edge, Chrome) and Windows (Edge, Chrome)

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://github.com/PowerShell/PowerShell) [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE) [![Intune](https://img.shields.io/badge/Intune-MDM-blue.svg)](https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-)

Comprehensive Intune MDM popup policies for managing browser behavior across macOS (Safari, Edge, Chrome) and Windows (Edge, Chrome) endpoints. This repository provides PowerShell scripts and policy configurations to streamline cross-platform browser management in enterprise environments.

## 🚀 Overview

This project demonstrates enterprise-ready Intune MDM configurations for managing popup policies across multiple browsers and operating systems. The tools provided help automate the creation, deployment, and monitoring of browser popup policies that enhance security, user experience, and compliance with organizational requirements.

## 📁 Repository Structure

```
Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-/
├── scripts/
│   └── New-IntunePopupPolicy.ps1       # Main PowerShell automation script
├── policies/
│   ├── macOS/
│   │   ├── safari-popup-policy.xml     # Safari popup policy for macOS
│   │   ├── edge-popup-policy.xml       # Microsoft Edge policy for macOS
│   │   └── chrome-popup-policy.xml     # Google Chrome policy for macOS
│   └── windows/
│       ├── edge-popup-policy.xml       # Microsoft Edge policy for Windows
│       └── chrome-popup-policy.xml     # Google Chrome policy for Windows
├── .gitignore                          # Git ignore rules for Visual Studio/PowerShell
└── README.md                           # This documentation file
```

## 🛠️ Features

- **Cross-Platform Support**: Unified policies for macOS and Windows environments
- **Multi-Browser Coverage**: Safari, Microsoft Edge, and Google Chrome policy management
- **Intune Integration**: Native Microsoft Intune MDM policy deployment
- **Automated Policy Creation**: Streamlined creation of browser popup policies
- **Policy Validation**: Built-in validation for Intune policy configurations
- **Comprehensive Logging**: Detailed logging with configurable levels (INFO, WARNING, ERROR)
- **Error Handling**: Robust error handling and graceful failure management
- **Compliance Reporting**: Automated generation of policy compliance reports
- **Flexible Configuration**: Support for various popup policy types and trigger conditions

## 📋 Requirements

- **PowerShell**: Version 5.1 or higher
- **Microsoft Intune**: Valid Intune administrator access and credentials
- **Azure AD**: Azure Active Directory tenant with Intune licensing
- **Supported Browsers**: Safari (macOS), Microsoft Edge, Google Chrome
- **Operating Systems**: 
  - macOS 10.14 or higher
  - Windows 10/11 (Professional, Enterprise, Education)
- **Network Access**: Internet connectivity for Intune Graph API calls

## 🚦 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/a-ariff/Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-.git
cd Intune-MDM-Popup-Policies-macOS-Safari-Edge-Chrome-and-Windows-Edge-Chrome-
```

### 2. Configure Intune Connection

Edit the configuration section in `scripts/New-IntunePopupPolicy.ps1`:

```powershell
$config = @{
    TenantId = 'your-tenant-id'                    # Azure AD Tenant ID
    ClientId = 'your-client-id'                    # Azure App Registration Client ID
    ClientSecret = 'your-client-secret'            # Use secure credential storage
    IntuneBaseUrl = 'https://graph.microsoft.com/v1.0/deviceManagement'
}
```

### 3. Deploy Popup Policies

```powershell
# Example 1: Deploy Safari popup policy for macOS
.\scripts\New-IntunePopupPolicy.ps1 `
    -PolicyName "macOS Safari Popup Control" `
    -Platform "macOS" `
    -Browser "Safari" `
    -PopupAction "Block" `
    -AllowedSites @("intranet.company.com", "portal.office.com") `
    -Enabled $true

# Example 2: Deploy Chrome popup policy for Windows
.\scripts\New-IntunePopupPolicy.ps1 `
    -PolicyName "Windows Chrome Popup Management" `
    -Platform "Windows" `
    -Browser "Chrome" `
    -PopupAction "BlockExceptAllowList" `
    -AllowedSites @("*.company.com", "*.microsoft.com") `
    -Enabled $true

# Example 3: Deploy Edge popup policy for both platforms
.\scripts\New-IntunePopupPolicy.ps1 `
    -PolicyName "Cross-Platform Edge Popup Policy" `
    -Platform "Both" `
    -Browser "Edge" `
    -PopupAction "AskUser" `
    -BlockedSites @("*.malicious.com", "*.ads.com") `
    -Enabled $true
```

## 📖 Detailed Usage

### Script Parameters

The main script `New-IntunePopupPolicy.ps1` accepts the following parameters:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| PolicyName | String | Yes | Name of the Intune popup policy to create |
| Platform | String | Yes | Target platform (macOS, Windows, Both) |
| Browser | String | Yes | Target browser (Safari, Edge, Chrome, All) |
| PopupAction | String | Yes | Popup behavior (Block, Allow, AskUser, BlockExceptAllowList) |
| AllowedSites | Array | No | List of sites allowed to show popups |
| BlockedSites | Array | No | List of sites blocked from showing popups |
| Enabled | Boolean | No | Whether the policy should be enabled (default: $true) |

### Popup Actions

- **Block**: Block all popups on all sites
- **Allow**: Allow all popups on all sites
- **AskUser**: Prompt user for each popup request
- **BlockExceptAllowList**: Block popups except on specified allowed sites

### Supported Platforms

- **macOS**: Supports Safari, Edge, and Chrome browsers
- **Windows**: Supports Edge and Chrome browsers
- **Both**: Deploy policies to both macOS and Windows endpoints

### Browser Coverage

#### macOS Browsers:
- Safari (native macOS browser)
- Microsoft Edge (Chromium-based)
- Google Chrome

#### Windows Browsers:
- Microsoft Edge (Chromium-based)
- Google Chrome

## 🔧 Advanced Configuration

### Intune Policy Templates

The repository includes pre-configured policy templates in the `policies/` directory:

- **macOS Safari**: Optimized for Safari's WebKit engine
- **macOS Edge/Chrome**: Chromium-based browser policies for macOS
- **Windows Edge/Chrome**: Chromium-based browser policies for Windows

### Custom Policy Creation

Create custom popup policies by modifying the XML templates:

```xml
<!-- Example: Custom Safari popup policy -->
<dict>
    <key>PopupBlockingEnabled</key>
    <true/>
    <key>PopupAllowedForDomains</key>
    <array>
        <string>company.com</string>
        <string>intranet.local</string>
    </array>
</dict>
```

### Logging Configuration

Logs are automatically created in `./logs/IntunePopupPolicy-YYYYMMDD.log` with the following levels:
- **INFO**: General operational information
- **WARNING**: Warning conditions that don't prevent execution
- **ERROR**: Error conditions that prevent successful execution

### Secure Credential Storage

For production use, implement secure credential storage:

```powershell
# Store credentials securely
$credential = Get-Credential
$credential.Password | ConvertFrom-SecureString | Set-Content "C:\Secure\intune-creds.txt"

# Retrieve credentials
$securePassword = Get-Content "C:\Secure\intune-creds.txt" | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)
```

## 📊 Compliance Reporting

The script includes a compliance reporting function that generates:

- Total number of active popup policies
- Platform and browser coverage statistics
- Policy deployment success rates
- User compliance metrics
- Exception and violation reports

## 🛡️ Security Considerations

- **Azure Credentials**: Never store credentials in plain text
- **Network Security**: Ensure secure HTTPS connections to Microsoft Graph API
- **Access Control**: Implement proper RBAC for Intune policy management
- **Audit Logging**: Enable comprehensive logging for security audits
- **Policy Testing**: Test policies in non-production environments first

## 🔄 Integration Workflow

1. **Policy Design**: Define popup control requirements for each browser/platform
2. **Template Configuration**: Customize policy templates for organizational needs
3. **Testing**: Validate policy behavior in test Intune environment
4. **Deployment**: Deploy policies to production Intune tenant
5. **Monitoring**: Monitor policy compliance and user impact
6. **Optimization**: Continuously improve policies based on feedback and metrics

## 📝 Development Roadmap

- [x] Basic popup policy framework
- [x] macOS Safari policy support
- [x] Windows Edge/Chrome policy support
- [ ] macOS Edge/Chrome policy refinement
- [ ] Advanced popup exception handling
- [ ] Group-based policy targeting
- [ ] Automated policy testing framework
- [ ] Policy backup and restore functionality
- [ ] Real-time compliance monitoring
- [ ] PowerShell module for easier distribution
- [ ] GUI interface for non-technical users
- [ ] Integration with Microsoft Defender for Endpoint
- [ ] Advanced analytics and reporting

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/popup-policy-enhancement`)
3. Commit your changes (`git commit -m 'Add enhanced popup policy support'`)
4. Push to the branch (`git push origin feature/popup-policy-enhancement`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

For support, please:

- Open an issue in this repository
- Check the [Wiki](wiki) for additional documentation
- Contact: [aariff@outlook.co.nz](mailto:aariff@outlook.co.nz)

## 👨‍💻 Author

**Ariff Mohamed**  
Cloud Solutions Engineer

- LinkedIn: [linkedin.com/in/ariff-mohamed](https://linkedin.com/in/ariff-mohamed)
- Email: [aariff@outlook.co.nz](mailto:aariff@outlook.co.nz)
- Location: Wellington, New Zealand

Specializing in Azure, Intune, PowerShell automation, and cybersecurity solutions for enterprise and MSP environments.

## 🏷️ Tags

`intune` `mdm` `popup-policies` `macos` `windows` `safari` `edge` `chrome` `browser-management` `powershell` `automation` `azure` `compliance` `security`

⭐ Star this repository if you find it useful! ⭐

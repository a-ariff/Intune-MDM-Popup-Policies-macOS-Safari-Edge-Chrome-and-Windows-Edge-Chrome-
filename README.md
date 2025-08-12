# Popup Policies for Autotask

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue.svg)](https://github.com/PowerShell/PowerShell)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![MSP](https://img.shields.io/badge/MSP-Automation-orange.svg)](https://github.com/a-ariff/popup-policies-autotask)

Automation toolset for managing Autotask popup policies and PSA configurations. This repository provides PowerShell scripts and frameworks to streamline MSP operations with automated policy enforcement and compliance reporting.

## 🚀 Overview

This project demonstrates enterprise-ready automation workflows for Managed Service Providers (MSPs) using Autotask PSA. The tools provided help automate the creation, management, and monitoring of popup policies that enhance operational efficiency and ensure compliance with business processes.

## 📁 Repository Structure

```
popup-policies-autotask/
├── scripts/
│   └── New-AutotaskPopupPolicy.ps1    # Main PowerShell automation script
├── .gitignore                         # Git ignore rules for Visual Studio/PowerShell
└── README.md                          # This documentation file
```

## 🛠️ Features

- **Automated Policy Creation**: Streamlined creation of Autotask popup policies
- **Multi-Module Support**: Works across Tickets, Companies, Contacts, Projects, and more
- **Policy Validation**: Built-in validation for policy configurations
- **Comprehensive Logging**: Detailed logging with configurable levels (INFO, WARNING, ERROR)
- **Error Handling**: Robust error handling and graceful failure management
- **Compliance Reporting**: Automated generation of policy compliance reports
- **Flexible Configuration**: Support for various policy types and trigger conditions

## 📋 Requirements

- **PowerShell**: Version 5.1 or higher
- **Autotask PSA**: Valid API access and credentials
- **Windows**: Windows 10/11 or Windows Server 2016+
- **Network Access**: Internet connectivity for Autotask API calls

## 🚦 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/a-ariff/popup-policies-autotask.git
cd popup-policies-autotask
```

### 2. Configure API Settings

Edit the configuration section in `scripts/New-AutotaskPopupPolicy.ps1`:

```powershell
$config = @{
    AutotaskAPIUrl = 'https://webservices.autotask.net/atservices/1.6/atws.asmx'
    Username = 'your-username'              # Replace with your credentials
    Password = 'your-password'              # Use secure credential storage
    IntegrationCode = 'your-integration-code'  # Replace with your integration code
}
```

### 3. Run a Sample Policy Creation

```powershell
# Example 1: Create a critical priority alert
.\scripts\New-AutotaskPopupPolicy.ps1 -PolicyName "High Priority Alert" -PolicyType "Critical" -TargetModule "Tickets" -TriggerCondition "Priority = 'Critical'" -PopupMessage "URGENT: Critical ticket requires immediate attention!" -Enabled $true

# Example 2: Create a contract expiry warning
.\scripts\New-AutotaskPopupPolicy.ps1 -PolicyName "Contract Expiry Warning" -PolicyType "Warning" -TargetModule "Companies" -TriggerCondition "Contract End Date < 30 days" -PopupMessage "Warning: Contract expires within 30 days" -Enabled $true
```

## 📖 Detailed Usage

### Script Parameters

The main script `New-AutotaskPopupPolicy.ps1` accepts the following parameters:

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `PolicyName` | String | Yes | Name of the popup policy to create |
| `PolicyType` | String | Yes | Type of popup (Alert, Warning, Information, Critical) |
| `TargetModule` | String | Yes | Autotask module (Tickets, Companies, Contacts, Projects, Opportunities, Quotes) |
| `TriggerCondition` | String | Yes | Condition that triggers the popup display |
| `PopupMessage` | String | Yes | Message content to display in the popup |
| `Enabled` | Boolean | No | Whether the policy should be enabled (default: $true) |

### Policy Types

- **Critical**: High-priority alerts requiring immediate attention
- **Warning**: Important notifications that need user awareness
- **Alert**: General alerts for operational events
- **Information**: Informational messages for user guidance

### Target Modules

Supported Autotask modules:
- Tickets
- Companies
- Contacts
- Projects
- Opportunities
- Quotes

## 🔧 Advanced Configuration

### Logging Configuration

Logs are automatically created in `./logs/AutotaskPopupPolicy-YYYYMMDD.log` with the following levels:
- **INFO**: General operational information
- **WARNING**: Warning conditions that don't prevent execution
- **ERROR**: Error conditions that prevent successful execution

### Secure Credential Storage

For production use, implement secure credential storage:

```powershell
# Store credentials securely
$credential = Get-Credential
$credential.Password | ConvertFrom-SecureString | Set-Content "C:\Secure\autotask-creds.txt"

# Retrieve credentials
$securePassword = Get-Content "C:\Secure\autotask-creds.txt" | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)
```

## 📊 Compliance Reporting

The script includes a compliance reporting function that generates:
- Total number of active policies
- Policy usage statistics
- Last triggered timestamps
- Policy effectiveness metrics

## 🛡️ Security Considerations

- **API Credentials**: Never store credentials in plain text
- **Network Security**: Ensure secure HTTPS connections to Autotask API
- **Access Control**: Implement proper RBAC for script execution
- **Audit Logging**: Enable comprehensive logging for security audits

## 🔄 Integration Workflow

1. **Policy Design**: Define business requirements and trigger conditions
2. **Script Configuration**: Set up API credentials and policy parameters
3. **Testing**: Validate policy behavior in a test environment
4. **Deployment**: Deploy policies to production Autotask instance
5. **Monitoring**: Monitor policy effectiveness and compliance metrics
6. **Optimization**: Continuously improve policies based on operational data

## 📝 Development Roadmap

- [ ] Implement actual Autotask API integration
- [ ] Add authentication handling with secure credential storage
- [ ] Create policy templates for common MSP scenarios
- [ ] Develop automated policy testing framework
- [ ] Add policy backup and restore functionality
- [ ] Implement policy version control and rollback capabilities
- [ ] Create PowerShell module for easier distribution
- [ ] Add support for bulk policy operations
- [ ] Develop GUI interface for non-technical users
- [ ] Create detailed performance metrics and analytics

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

For support, please:
- Open an issue in this repository
- Check the [Wiki](https://github.com/a-ariff/popup-policies-autotask/wiki) for additional documentation
- Contact: [aariff@outlook.co.nz](mailto:aariff@outlook.co.nz)

## 👨‍💻 Author

**Ariff Mohamed**  
*Cloud Solutions Engineer*

- LinkedIn: [linkedin.com/in/ariff-mohamed](https://linkedin.com/in/ariff-mohamed)
- Email: aariff@outlook.co.nz
- Location: Wellington, New Zealand

*Specializing in Azure, Intune, PowerShell automation, and cybersecurity solutions for enterprise and MSP environments.*

## 🏷️ Tags

`powershell` `autotask` `msp` `automation` `psa` `policy-management` `compliance` `reporting` `azure` `intune`

---

⭐ **Star this repository if you find it useful!** ⭐

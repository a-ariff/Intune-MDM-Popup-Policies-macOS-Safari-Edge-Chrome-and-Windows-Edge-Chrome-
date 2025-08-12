# Contributing to Popup Policies for Autotask

Thank you for your interest in contributing to this project! We welcome contributions from the community and appreciate your help in making this automation toolkit better.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
- [Development Guidelines](#development-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)
- [Style Guide](#style-guide)
- [Testing](#testing)
- [Documentation](#documentation)
- [Community](#community)

## Code of Conduct

This project and everyone participating in it are governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## Getting Started

### Prerequisites

- PowerShell 5.1 or higher
- Git for version control
- Basic understanding of Autotask PSA (helpful but not required)
- Windows development environment

### Setting Up Your Development Environment

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub, then clone your fork
   git clone https://github.com/YOUR-USERNAME/popup-policies-autotask.git
   cd popup-policies-autotask
   ```

2. **Add the upstream remote**
   ```bash
   git remote add upstream https://github.com/a-ariff/popup-policies-autotask.git
   ```

3. **Create a development branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

## How to Contribute

### Types of Contributions

We welcome several types of contributions:

- **Bug fixes**: Fix issues in existing code
- **Feature additions**: Add new functionality
- **Documentation improvements**: Enhance README, comments, or guides
- **Code optimization**: Improve performance or readability
- **Test coverage**: Add or improve tests
- **Security enhancements**: Identify and fix security issues

### Contribution Workflow

1. **Check existing issues** before starting work
2. **Create an issue** for new features or major changes
3. **Fork and clone** the repository
4. **Create a feature branch** from main
5. **Make your changes** following our guidelines
6. **Test your changes** thoroughly
7. **Submit a pull request** with a clear description

## Development Guidelines

### PowerShell Best Practices

- **Use approved verbs** for function names (Get-, Set-, New-, etc.)
- **Follow PascalCase** for function names and variables
- **Include parameter validation** using `[Parameter()]` attributes
- **Add comprehensive help** using comment-based help
- **Handle errors gracefully** with try/catch blocks
- **Use meaningful variable names** that describe their purpose

### Code Structure

```powershell
<#
.SYNOPSIS
    Brief description of the function

.DESCRIPTION
    Detailed description of what the function does

.PARAMETER ParameterName
    Description of the parameter

.EXAMPLE
    Example usage of the function

.NOTES
    Additional notes about the function
#>
function Verb-Noun {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$RequiredParameter,
        
        [Parameter()]
        [string]$OptionalParameter = "DefaultValue"
    )
    
    try {
        # Implementation here
        Write-Verbose "Performing operation..."
        
        # Return result
        return $result
    }
    catch {
        Write-Error "Error occurred: $($_.Exception.Message)"
        throw
    }
}
```

### Logging Standards

- Use `Write-Verbose` for detailed operational information
- Use `Write-Warning` for non-critical issues
- Use `Write-Error` for error conditions
- Include timestamps in log entries
- Use structured logging where possible

### Security Considerations

- Never commit credentials or API keys
- Use secure string handling for sensitive data
- Validate all user inputs
- Follow principle of least privilege
- Document security implications of changes

## Pull Request Process

### Before Submitting

1. **Sync your fork** with the upstream repository
2. **Test your changes** thoroughly
3. **Run code analysis** tools if available
4. **Update documentation** if needed
5. **Add tests** for new functionality

### Pull Request Guidelines

1. **Use a clear title** that describes the change
2. **Provide detailed description** of what and why
3. **Reference related issues** using `#issue-number`
4. **Include test results** or screenshots if applicable
5. **Ensure CI checks pass** (if configured)

### Pull Request Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring
- [ ] Security fix

## Testing
- [ ] Tested locally
- [ ] Added unit tests
- [ ] Updated integration tests

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or documented)
```

### Review Process

1. **Automated checks** will run on your PR
2. **Maintainers will review** your code
3. **Address feedback** promptly
4. **Approval required** from at least one maintainer
5. **Merge** will be handled by maintainers

## Issue Reporting

### Bug Reports

When reporting bugs, please include:

- **Environment details** (PowerShell version, OS, etc.)
- **Steps to reproduce** the issue
- **Expected behavior** vs actual behavior
- **Error messages** or logs
- **Screenshots** if applicable

### Feature Requests

For feature requests, please include:

- **Use case description** and business justification
- **Proposed solution** or implementation ideas
- **Alternative approaches** considered
- **Additional context** or examples

## Style Guide

### PowerShell Style

- **Indentation**: Use 4 spaces (no tabs)
- **Line length**: Maximum 120 characters
- **Braces**: Opening brace on same line
- **Comments**: Use `#` for single-line, `<# #>` for multi-line
- **String quotes**: Use single quotes unless interpolation needed

### Markdown Style

- **Headers**: Use `#` syntax, not underlines
- **Lists**: Use `-` for unordered, numbers for ordered
- **Code blocks**: Specify language for syntax highlighting
- **Links**: Use descriptive link text

### Commit Messages

- **Format**: `type: description`
- **Types**: feat, fix, docs, style, refactor, test, chore
- **Description**: Imperative mood, lowercase, no period
- **Examples**:
  - `feat: add policy validation function`
  - `fix: handle null values in API response`
  - `docs: update installation instructions`

## Testing

### Test Requirements

- **Unit tests** for all new functions
- **Integration tests** for API interactions
- **Mock external dependencies** where possible
- **Test edge cases** and error conditions

### Testing Framework

```powershell
# Example using Pester
Describe "New-AutotaskPopupPolicy" {
    Context "When parameters are valid" {
        It "Should create policy successfully" {
            # Arrange
            $params = @{
                PolicyName = "Test Policy"
                PolicyType = "Alert"
                TargetModule = "Tickets"
            }
            
            # Act
            $result = New-AutotaskPopupPolicy @params
            
            # Assert
            $result | Should -Not -BeNullOrEmpty
            $result.Success | Should -Be $true
        }
    }
}
```

### Manual Testing

- Test in multiple PowerShell versions if possible
- Verify functionality with different parameter combinations
- Test error handling and edge cases
- Validate against real Autotask environment (if available)

## Documentation

### Code Documentation

- **Comment-based help** for all functions
- **Inline comments** for complex logic
- **README updates** for new features
- **Examples** in documentation

### Documentation Standards

- Keep documentation up-to-date with code changes
- Use clear, concise language
- Include practical examples
- Explain "why" not just "what"

## Community

### Communication Channels

- **GitHub Issues**: Bug reports and feature requests
- **Pull Requests**: Code discussions and reviews
- **Email**: [aariff@outlook.co.nz](mailto:aariff@outlook.co.nz) for sensitive matters

### Getting Help

- Check existing documentation and issues first
- Provide context when asking questions
- Be respectful and patient with responses
- Help others when you can

### Recognition

Contributors will be:
- Listed in the project's contributors section
- Mentioned in release notes for significant contributions
- Thanked publicly for their efforts

## License

By contributing to this project, you agree that your contributions will be licensed under the same MIT License that covers the project.

---

**Thank you for contributing to Popup Policies for Autotask!** 🚀

Your contributions help make MSP automation better for everyone.

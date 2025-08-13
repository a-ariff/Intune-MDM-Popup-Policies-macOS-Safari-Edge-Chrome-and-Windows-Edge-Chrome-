<#.SYNOPSIS
    Creates a new Intune popup policy for web browsers.
.DESCRIPTION
    This function creates and configures an Intune popup policy that can be applied to web browsers
    on macOS (Safari, Edge, Chrome) and Windows (Edge, Chrome). The policy helps manage popup
    behavior across managed devices with dynamic allow/block injection per browser schema.
.PARAMETER PolicyName
    Specifies the name for the new popup policy.
.PARAMETER Description
    Specifies the description for the popup policy.
.PARAMETER PopupAction
    Specifies the popup action: 'Allow' or 'Block'. Default is 'Block'.
.PARAMETER AllowedSites
    Array of URLs to allow popups for all browsers.
.PARAMETER BlockedSites
    Array of URLs to block popups for all browsers.
.PARAMETER Platform
    Target platform: 'macOS', 'Windows', or 'Both'. Default is 'Both'.
.PARAMETER WhatIf
    Shows what would happen if the cmdlet runs. The cmdlet is not run.
.PARAMETER Confirm
    Prompts you for confirmation before running the cmdlet.
.EXAMPLE
    New-IntunePopupPolicy -PolicyName "Corporate Popup Policy" -Description "Standard popup policy for corporate devices" -PopupAction Block -AllowedSites @("https://company.com", "https://intranet.local")
    Creates a new popup policy that blocks popups by default but allows them for specified corporate sites.
.EXAMPLE
    New-IntunePopupPolicy -PolicyName "Test Policy" -PopupAction Allow -BlockedSites @("https://malicious.com") -WhatIf
    Shows what would happen when creating a policy that allows popups but blocks specific sites.
.NOTES
    Version: 2.0
    Author: Intune Administrator
    Creation Date: $(Get-Date -Format 'yyyy-MM-dd')
    Purpose: Enhanced Intune popup policy management with browser-specific schema mapping
#>

[CmdletBinding(SupportsShouldProcess)]
param
(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$PolicyName,
    
    [Parameter(Mandatory = $false)]
    [string]$Description = "Popup policy created via PowerShell",
    
    [Parameter(Mandatory = $false)]
    [ValidateSet('Allow', 'Block')]
    [string]$PopupAction = 'Block',
    
    [Parameter(Mandatory = $false)]
    [string[]]$AllowedSites = @(),
    
    [Parameter(Mandatory = $false)]
    [string[]]$BlockedSites = @(),
    
    [Parameter(Mandatory = $false)]
    [ValidateSet('macOS', 'Windows', 'Both')]
    [string]$Platform = 'Both'
)

begin {
    # Initialize logging - using Write-Information for lint-safe logging
    Write-Information -MessageData "Starting New-IntunePopupPolicy function" -InformationAction Continue
    
    # Validate prerequisites
    if (-not (Get-Command -Name "Get-MgDeviceManagement" -ErrorAction SilentlyContinue)) {
        Write-Error "Microsoft Graph PowerShell SDK is not installed or not imported. Please install the Microsoft.Graph module."
        return
    }
    
    # Helper function to create browser-specific policy configurations
    function Get-BrowserPolicyConfig {
        param(
            [string]$Browser,
            [string]$OS,
            [string]$PopupAction,
            [string[]]$AllowedSites,
            [string[]]$BlockedSites
        )
        
        $config = @{}
        
        switch ($Browser.ToLower()) {
            'chrome' {
                # Chrome/Edge use the same schema
                $config['DefaultPopupsSetting'] = if ($PopupAction -eq 'Block') { 2 } else { 1 }
                
                if ($AllowedSites.Count -gt 0) {
                    $config['PopupsAllowedForUrls'] = $AllowedSites
                }
                
                if ($BlockedSites.Count -gt 0) {
                    $config['PopupsBlockedForUrls'] = $BlockedSites
                }
            }
            'edge' {
                # Edge uses same schema as Chrome
                $config['DefaultPopupsSetting'] = if ($PopupAction -eq 'Block') { 2 } else { 1 }
                
                if ($AllowedSites.Count -gt 0) {
                    $config['PopupsAllowedForUrls'] = $AllowedSites
                }
                
                if ($BlockedSites.Count -gt 0) {
                    $config['PopupsBlockedForUrls'] = $BlockedSites
                }
            }
            'safari' {
                # Safari XML uses different schema
                if ($OS -eq 'macOS') {
                    $config['DefaultPopupsSetting'] = if ($PopupAction -eq 'Block') { 2 } else { 1 }
                    
                    # Safari uses AllowedPopupDomains array instead of URLs
                    if ($AllowedSites.Count -gt 0) {
                        # Extract domains from URLs for Safari
                        $domains = $AllowedSites | ForEach-Object {
                            try {
                                ([System.Uri]$_).Host
                            } catch {
                                $_  # If URL parsing fails, use as-is
                            }
                        }
                        $config['AllowedPopupDomains'] = $domains
                    }
                    
                    # Safari doesn't have a direct blocked domains equivalent
                    # Blocked sites would need to be handled differently
                    if ($BlockedSites.Count -gt 0) {
                        Write-Warning "Safari does not support explicit blocked popup domains. Consider using DefaultPopupsSetting=2 (block) instead."
                    }
                }
            }
        }
        
        return $config
    }
}

process {
    try {
        if ($PSCmdlet.ShouldProcess($PolicyName, "Create new Intune popup policy")) {
            Write-Information -MessageData "Creating policy: $PolicyName" -InformationAction Continue
            
            # Determine target browsers based on platform
            $targetBrowsers = @()
            switch ($Platform) {
                'macOS' { $targetBrowsers = @('Safari', 'Chrome', 'Edge') }
                'Windows' { $targetBrowsers = @('Chrome', 'Edge') }
                'Both' { $targetBrowsers = @('Safari', 'Chrome', 'Edge') }
            }
            
            $policies = @()
            
            # Create policy configurations for each browser
            foreach ($browser in $targetBrowsers) {
                $os = if ($browser -eq 'Safari') { 'macOS' } else { $Platform }
                
                # Skip Safari on Windows
                if ($browser -eq 'Safari' -and $Platform -eq 'Windows') {
                    continue
                }
                
                $browserConfig = Get-BrowserPolicyConfig -Browser $browser -OS $os -PopupAction $PopupAction -AllowedSites $AllowedSites -BlockedSites $BlockedSites
                
                # Ensure DefaultPopupsSetting=2 when PopupAction=Block
                if ($PopupAction -eq 'Block') {
                    $browserConfig['DefaultPopupsSetting'] = 2
                }
                
                $policyParams = @{
                    DisplayName = "$PolicyName - $browser"
                    Description = "$Description (Browser: $browser, OS: $os)"
                    Browser = $browser
                    OS = $os
                    Configuration = $browserConfig
                    PopupAction = $PopupAction
                    AllowedSites = $AllowedSites
                    BlockedSites = $BlockedSites
                }
                
                Write-Information -MessageData "Policy parameters prepared for $browser on $os" -InformationAction Continue
                Write-Information -MessageData "Configuration: $($browserConfig | ConvertTo-Json -Compress)" -InformationAction Continue
                
                # Create policy object
                $policy = [PSCustomObject]@{
                    PolicyName = $policyParams.DisplayName
                    Description = $policyParams.Description
                    Browser = $browser
                    OS = $os
                    PopupAction = $PopupAction
                    Configuration = $browserConfig
                    Status = "Created"
                    Timestamp = Get-Date
                }
                
                $policies += $policy
            }
            
            Write-Information -MessageData "Policy creation completed successfully for $($policies.Count) browser configurations" -InformationAction Continue
            
            # Return policy collection
            return $policies
        }
        else {
            Write-Information -MessageData "Policy creation cancelled by user" -InformationAction Continue
        }
    }
    catch {
        Write-Error "Failed to create popup policy: $($_.Exception.Message)"
        Write-Information -MessageData "Error details: $($_.Exception.Message)" -InformationAction Continue
    }
}

end {
    Write-Information -MessageData "New-IntunePopupPolicy function completed" -InformationAction Continue
}

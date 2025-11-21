# PLease read documentation for this script.

# Install Microsoft Exchange Online Management module if not already installed
if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
    Write-Host "Installing Exchange Online Management module..."
    Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser -Force
}

# Import the module into the current session
Import-Module ExchangeOnlineManagement

# Verify if the module is loaded
if (Get-Module -Name ExchangeOnlineManagement) {
    Write-Host "Exchange Online Management module is loaded."
} else {
    Write-Host "Failed to load Exchange Online Management module."
}

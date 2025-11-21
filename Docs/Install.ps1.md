**Install.ps1 — Script Documentation**

- **Location:** `Install.ps1`
- **Purpose:** Ensure the `ExchangeOnlineManagement` PowerShell module is installed and imported for the current user session.

Summary
- This script checks whether the `ExchangeOnlineManagement` module is available locally. If not present, it installs the module for the current user. It then imports the module into the active session and reports whether the import succeeded.

Step-by-step explanation (matching `Install.ps1`)

1. Check whether the module is available
- Code: `if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) { ... }`
- Explanation: Calls `Get-Module -ListAvailable -Name ExchangeOnlineManagement` to search all module directories for a module named `ExchangeOnlineManagement`. If no result is returned, the `-not` operator evaluates to `$true` and the script proceeds to install the module.

2. Install the module (if required)
- Code inside the `if` block:
  - `Write-Host "Installing Exchange Online Management module..."`
  - `Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser -Force`
- Explanation: Writes an informational message then invokes `Install-Module` from the PowerShell Gallery. `-Scope CurrentUser` installs the module only for the current user (no admin elevation required). `-Force` suppresses prompts and forces overwrite of existing versions if necessary.

3. Import the module into the current session
- Code: `Import-Module ExchangeOnlineManagement`
- Explanation: Loads the module into the current PowerShell session so its cmdlets (e.g., `Connect-ExchangeOnline`) are available immediately without requiring a new shell.

4. Verify import and report
- Code:
  - `if (Get-Module -Name ExchangeOnlineManagement) { Write-Host "Exchange Online Management module is loaded." } else { Write-Host "Failed to load Exchange Online Management module." }`
- Explanation: Calls `Get-Module -Name ExchangeOnlineManagement` (without `-ListAvailable`) to check the session's loaded modules. If the module is present in the imported modules list, it prints a success message; otherwise, it prints a failure message.

Notes and recommendations
- Execution Policy: If the user's execution policy prevents running scripts or installing modules, instruct the user to run `pwsh -ExecutionPolicy Bypass -File .\Install.ps1` or temporarily set an appropriate policy for the session.
- Elevated permissions: `-Scope CurrentUser` avoids needing Administrator privileges. If you want a machine-wide install, remove `-Scope CurrentUser` and run as Administrator.
- Module source: `Install-Module` pulls from the PowerShell Gallery by default. If your environment uses an internal repository, supply `-Repository <Name>`.
- Idempotence: This script is safe to run multiple times — it only installs if the module is missing and always attempts to import.

Troubleshooting
- Network/Proxy issues: If `Install-Module` fails due to network restrictions, download the module offline and install with `Install-Module -Path` or `Save-Module` from a machine with access.
- TLS/SSL errors: Ensure TLS 1.2 is available or force it within the session: `[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12`
- Verify module location: Run `Get-Module -ListAvailable ExchangeOnlineManagement | Select-Object -Property Name,ModuleBase,Version` to inspect installed versions and path.

How to run
- From PowerShell (PowerShell 7+ recommended):

```powershell
pwsh .\Install.ps1
```

- To test behavior without installing in an automated environment, you can run the `Get-Module -ListAvailable` check manually first.

Suggested small improvements
- Add `-ErrorAction Stop` on `Install-Module` and wrap in `try/catch` to provide clearer error messages and non-zero exit codes for automation.
- Add a `-Verbose` switch and/or use `Write-Verbose` for non-interactive logging compatibility.

---
Generated on: 2025-11-20

# Microsoft-365
This Repository is based on Microsoft 365 PowerShell best practices.

## Git identity and GitHub relay email

To protect your personal email and ensure consistent commit authorship, set your git user.name and use your GitHub relay (noreply) email.

1. Find your GitHub relay (noreply) email
- In GitHub: Settings → Emails.
- Enable "Keep my email address private" to use a GitHub-provided relay address.
- Common formats:
  - username@users.noreply.github.com
  - or ID+username@users.noreply.github.com (older/alternate formats)
- Copy the address shown in GitHub and use it below.

2. Set identity (global or per-repo)
- Global (applies to all repos on this machine):
```bash
git config --global user.name "Your Name"
git config --global user.email "your-github-noreply@example.com"
```
- Per-repo (run inside a repo to avoid exposing your email elsewhere):
```bash
git config user.name "Your Name"
git config user.email "your-github-noreply@example.com"
```

3. Verify your configuration
```bash
git config --get user.name
git config --get user.email
```

4. Update the author of the most recent commit (if needed)
- Amend last commit to use the new identity:
```bash
git commit --amend --reset-author --no-edit
```

5. Quick test
- Create an empty test commit and inspect the author:
```bash
git commit --allow-empty -m "Test commit for email configuration"
git show --summary HEAD
```

Notes
- Prefer per-repo config if you must use different emails across projects.
- For CI or automation, set GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL (use the relay email).
- Using the GitHub-provided noreply address prevents exposing your personal email in public commits.

## Install.ps1 — step-by-step explanation

This section explains the included Install.ps1 script (c:\GitHub - Harrby Pty Ltd\Microsoft-365\Install.ps1) so contributors can understand what it does and how to run it.

1. Purpose
- Installs and loads the Exchange Online Management PowerShell module so you can manage Exchange Online from PowerShell.

2. Script steps (line-by-line)
- Check for existing module:
  - Command: Get-Module -ListAvailable -Name ExchangeOnlineManagement
  - What it does: Searches installed modules (in standard module paths) for ExchangeOnlineManagement.
  - Why: Avoids reinstalling the module if it's already available.

- Install if missing:
  - Condition: if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) { ... }
  - Inside: Write-Host "Installing Exchange Online Management module..." and Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser -Force
  - Notes:
    - Install-Module downloads from PSGallery. Using -Scope CurrentUser installs to your user profile (no admin required).
    - -Force suppresses prompts to reinstall/overwrite; remove if you prefer interactive confirmation.
    - You may be prompted to trust the PSGallery source the first time. Approve or run: Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

- Import the module:
  - Command: Import-Module ExchangeOnlineManagement
  - What it does: Loads the module into the current PowerShell session so cmdlets become available immediately.

- Verify load and report:
  - Command: if (Get-Module -Name ExchangeOnlineManagement) { Write-Host "loaded" } else { Write-Host "Failed to load" }
  - What it does: Checks the session modules and writes a simple success or failure message.

3. How to run
- From PowerShell (recommended: PowerShell 7+ or Windows PowerShell 5.1):
  - Open terminal and run:
    - .\Install.ps1
  - If you get an execution policy error run:
    - powershell -ExecutionPolicy Bypass -File .\Install.ps1
- To install for all users (requires Administrator):
  - Run PowerShell as Administrator and modify the script or run:
    - Install-Module -Name ExchangeOnlineManagement -Scope AllUsers

4. Troubleshooting & tips
- If PSGallery prompts about untrusted repository:
  - Run: Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
- If Install-Module fails due to TLS or network:
  - Ensure TLS 1.2: [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
- To verify module version and path:
  - Get-Module -ListAvailable ExchangeOnlineManagement | Select-Object Name, Version, Path

5. Security note
- Installing modules from PSGallery is common, but verify modules and keep them up-to-date.
- Use -Scope CurrentUser when you lack admin rights or want to avoid system-wide changes.

This explanation is suitable for copying into documentation or onboarding guides.

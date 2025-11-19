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

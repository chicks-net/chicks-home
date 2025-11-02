# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Repository Overview

This is Christopher Hicks' home directory configuration repository for managing
Unix/Linux environments across multiple servers. The repo includes shell
configuration, utility scripts, and automation tools for maintaining consistent
development environments.

## Development Commands

### Just Commands

This repository uses [just](https://github.com/casey/just) as the primary task
runner. Run `just list` to see all available recipes.

Key workflows:

- `just branch <name>` - Create a new branch with timestamp prefix (format:
  `chicks/YYYY-MM-DD-<name>`)
- `just pr` - Create a pull request from current branch, watch checks
  automatically
- `just watch_checks` - Monitor PR checks progress
- `just merge` - Merge PR with squash, delete branch, return to main
- `just sync` - Return to main branch and pull latest changes
- `just compliance_check` - Verify repo has expected documentation and
  configuration files

### Git Configuration

Custom git aliases are defined in `.gitconfig`:

- `git stp` - Status in porcelain format for scripting
- `git pushup` - Push current branch and set upstream (`push -u origin HEAD`)
- `git cim <message>` - Commit with message (only works on non-main/master
  branches as safety check)
- `git hh` - Show abbreviated commit history (last 15 commits)

**Important**: The `cim` alias intentionally prevents commits on main/master
branches. Always work on feature branches.

## Repository Structure

### Core Configuration Files

- `.functions` - Bash function library for package management and system checks
  - `check_packages` - Verify required packages are installed (cross-distro: RPM/DEB)
  - `check_os` - Detect OS type and set CHICKOS environment variable
  - `check_all_permissions` - Validate SSH file permissions
- `.bashrc`, `.bash_profile` - Shell initialization
- `.tmux.conf` - tmux configuration
- `.gitconfig` - Git configuration with custom aliases

### Script Collections

#### `bin/` Directory (50+ utilities)

Notable scripts mentioned in README:

- `closefh` - Close inherited file handles
- `roll` - D&D-style dice roller (Python)
- `ruler` - Command-line character counting
- `comify` - Convert newlines to commas
- `watch_constate` - Monitor network connection states
- `check_ssl` - Check SSL certificate expiration dates
- `daily_mysql_backup` - MySQL backup automation (experimental)
- `lib.sh` - Shared shell library with spinner() function

#### `github/` Directory

GitHub automation and configuration:

- `apply-ruleset` - Apply repository rulesets via GitHub API
- `github_fix_https` - Convert HTTPS remotes to SSH
- `rulesets/` - Pre-configured GitHub ruleset definitions

#### `google/` Directory

Google Apps Script code for Google Workspace automation. See
`google/AppScript/` for scripts that automate document updates and maintenance.

### GitHub Actions Workflows

- `.github/workflows/markdownlint.yml` - Markdown linting with markdownlint-cli2
- `.github/workflows/claude-code-review.yml` - Automated Claude Code PR
  reviews
- Other workflows for actionlint, checkov security scanning, and general linting

## Code Style and Quality

### Markdown

All Markdown files must pass `markdownlint-cli2` validation. Run locally:

```bash
markdownlint-cli2 "**/*.md"
```

### Shell Scripts

- Use bash strict mode when appropriate: `set -euo pipefail`
- Include shebang lines: `#!/bin/bash` or `#!/usr/bin/env bash`
- Source shared functions from `.functions` when needed

## Branch Protection

The repository enforces:

- No direct commits to main branch (use the `just branch` workflow)
- Pull requests required for all changes
- Automated Claude Code review on all PRs
- Linear history preferred (no merge commits)

## Platform Compatibility

The codebase supports:

- macOS (primary development platform based on git status)
- Linux distributions: CentOS/RHEL (RPM-based) and Debian/Ubuntu/Mint (DEB-based)
- Cross-platform package management via `.functions`

## Testing and Validation

Before submitting PRs:

1. Ensure markdown files pass markdownlint: `markdownlint-cli2 "**/*.md"`
2. Run `just compliance_check` to verify repository standards
3. Test shell scripts on target platforms when possible
4. Use `just pr` to create PR and automatically watch checks

## Notes

- This is a personal configuration repository, so some paths and settings are
  specific to Christopher Hicks' environment
- Many scripts assume symlinks from home directory to repo contents
- The repository intentionally avoids Ansible due to maintainer preferences
- Some experimental features (tmux setup, MySQL backups) are works in progress

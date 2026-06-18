# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Repository Overview

This is Christopher Hicks' home directory configuration repository for managing
Unix/Linux environments across multiple servers. The repo includes shell
configuration, utility scripts, and automation tools for maintaining consistent
development environments.

**Personal Configuration Note**: This is a personal configuration repository
with paths and settings specific to Christopher Hicks' environment. Many
scripts assume symlinks from home directory to repo contents. The repository
intentionally avoids Ansible due to maintainer preferences.

## Development Commands

### Just Commands

This repository uses [just](https://github.com/casey/just) as the primary task
runner. The justfile imports 13 modular recipe files from `.just/`.

**Standard PR Workflow** (use this pattern for all changes):

```bash
just branch <name>    # Creates timestamped branch: chicks/YYYY-MM-DD-<name>
# Make your changes and commit
just pr               # Creates PR, pushes branch, watches checks automatically
just merge            # Squash-merges PR, deletes branch, returns to main
```

**Other Commands**:

- `just sync` - Return to main branch and pull latest changes
- `just compliance_check` - Verify repo has expected documentation and
  configuration files. See AGENTS.md for guidance for agentic coding assistants.
- `just shellcheck` - Run shellcheck on shell scripts, including bash embedded
  in just recipes (extracts via awk before linting)
- `just prweb` - View current PR in web browser
- `just release <version>` - Create a GitHub release with auto-generated notes
- `just mergepdf <dest> <src...>` - Merge PDF files (macOS only)

**Claude Code Commands**:

- `just claude_permissions_sort` - Sorts `.claude/settings.local.json`
  permissions into canonical order (Bash → WebFetch → WebSearch → Other),
  creates a backup first. Runs automatically as part of `_pr-hook` before
  every PR.
- `just claude_permissions_check` - Validates the permissions structure and
  shows counts by type (Bash/WebFetch/WebSearch/Other)

### Git Configuration

Custom git aliases defined in `.gitconfig`:

- `git stp` - Status in porcelain format for scripting
- `git pushup` - Push current branch and set upstream (`push -u origin HEAD`)
- `git cim <message>` - Commit with message (safety: only works on
  non-main/master branches)
- `git hh` - Show abbreviated commit history (last 15 commits with graph)
- `git hist` - Full commit history with graph visualization

**Important**: The `cim` alias intentionally prevents commits on main/master
branches. Always work on feature branches using the `just branch` workflow.

## Core Architecture

### Cross-Platform Package Management (`.functions`)

The `.functions` library provides distro-agnostic package management:

- **`check_os`** - Detects OS and sets `$CHICKOS` environment variable
  (RPM_CENTOS, DEB_MINT, or broken_shit)
- **`check_packages`** - Verifies required packages are installed; uses
  timestamp caching (1-hour) to avoid repeated checks
- **`check_packages -i`** - Auto-installs missing packages via appropriate
  package manager (yum/apt-get)
- **`check_all_permissions`** - Validates SSH directory and file permissions
  (700 for `.ssh/`, 600 for private keys, 644 for public keys)

**Package Lists**:

- `UNIVERSAL_PKGS` - Cross-distro essentials (mtr, screen, tmux, perl, bash,
  curl, wget, git, git-svn)
- `RPM_PKGS` - Red Hat specific (vim-enhanced, pcre, jwhois)
- `DEB_PKGS` - Debian/Ubuntu specific (vim, pcregrep, whois, libdatetime-perl)

### Shared Shell Library (`bin/lib.sh`)

Contains reusable shell functions:

- **`spinner()`** - Visual progress indicator for long-running commands; pass
  PID as argument

## Directory Structure

### `bin/` - Command-Line Utilities (50+)

**Text Processing**:

- `ruler` - Visual character counting on command line
- `comify` - Convert newlines to comma-separated lists
- `closefh` - Close inherited file handles cleanly

**Network & Security**:

- `check_ssl` - Check SSL certificate expiration dates for multiple endpoints
- `watch_constate` - Monitor network connection states (like vmstat but for
  connections)
- `watch_zk_conns` - Monitor ZooKeeper connections

**GitHub Workflow**:

- `repos-summary` - Generate summary reports across multiple repositories
- Located in `github/` directory:
  - `github_fix_https` - Convert HTTPS remotes to SSH for password-free
    operations
  - `apply-ruleset` - Apply repository rulesets via GitHub API
  - `rulesets/` - Pre-configured ruleset definitions (require-pr.json,
    default-linear.json)

**Utilities**:

- `roll` - D&D-style dice roller (Python implementation in `roll.py`)
- `countdown` - Timer utility
- `whenis` - Date calculation helper

**Experimental/WIP**:

- `daily_mysql_backup` - MySQL backup automation (work in progress)
- `start_tmux` - tmux initialization automation (also see
  [libtmux](https://github.com/chicks-net/libtmux) project)

**Documentation Maintenance**:

- `bin/claude-init` - Runs `claude --permission-mode acceptEdits -p "/init"`
  to regenerate/update CLAUDE.md, then stages the result. Run when the repo
  structure changes significantly.

### `google/` - Google Workspace Automation

`google/AppScript/` contains Google Apps Script code for automating Google
Docs, Sheets, and other Workspace tasks. Includes day-of-week updater scripts
with comprehensive documentation links.

### `.just/` - Modular Justfile Components

These recipes are synced from [`fini-net/template-repo`](https://github.com/fini-net/template-repo)
via the numbered `github/gh-process-*` automation scripts. Run
`.just/lib/install-prerequisites.sh` to install required tools (just, gh,
shellcheck, markdownlint-cli2, jq) on macOS or Linux before using any just
recipes.

- **`gh-process.just`** - Git/GitHub PR workflow (branch/pr/merge/sync)
- **`compliance.just`** - Checks for README, LICENSE, templates, CODEOWNERS,
  config files with color-coded feedback
- **`shellcheck.just`** - Validates shell scripts and bash embedded in just
  recipes (uses awk to extract indented shell blocks)
- **`claude.just`** - Claude Code permission management
  (`claude_permissions_sort`, `claude_permissions_check`)
- **`copilot.just`** - Interactive Copilot suggestion picker (`copilot_pick`),
  requires `gum`
- **`pr-hook.just`** - Pre-PR gate (`_pr-hook`): runs shellcheck then
  `claude_permissions_sort` before every PR; add more checks here
- **`launchd.just`** - macOS launchd service management for the
  `daily_desktop_cleanup` Go binary (`launchd-install`, `launchd-status`,
  `launchd-reload`, `launchd-logs`, `launchd-validate`)
- **`template-sync.just`** - Keep `.just/` modules in sync with template-repo
  (`checksums_generate`, `checksums_verify`, `update_from_template`)
- **`repo-toml.just`** - Generate `.repo.toml` metadata from repo state
- **`cue-verify.just`** - Validate `.repo.toml` against its CUE schema
  (`docs/repo-toml.cue`)
- **`test.just`** - Placeholder for future test recipes

## GitHub Actions Workflows

All Markdown must pass `markdownlint-cli2` before merge:

```bash
markdownlint-cli2 "**/*.md"
```

**Active Workflows**:

- `markdownlint.yml` - Markdown linting (DavidAnson/markdownlint-cli2-action)
- `claude-code-review.yml` - Automated Claude Code PR reviews
- `opencode.yml` - OpenCode agent integration
- `actionlint.yml` - GitHub Actions workflow validation
- `checkov.yml` - Security scanning with Checkov
- `linter.yml` - General linting
- `auto-assign.yml` - Auto-assign PR reviewers
- `gitleaks.yml` - Secret scanning
- `scorecards.yml` - OpenSSF Scorecard (added by `bin/add-scorecards`)

**Standards**: See `docs/github-actions.md` for GitHub Actions requirements and
standards. See `docs/writing-style-economist.md` for documentation style guidance
(based on The Economist's style guide, with a "For Technical Writing" section
applied to chicks.net content).

## Code Style and Quality

### Shell Scripts

- Use bash strict mode when appropriate: `set -euo pipefail`
- Include shebang lines: `#!/bin/bash` or `#!/usr/bin/env bash`
- Source shared functions from `.functions` for package management utilities
- Source `bin/lib.sh` for spinner() and other shared utilities

### Markdown

All Markdown files must pass `markdownlint-cli2` validation:

```bash
markdownlint-cli2 "**/*.md"
```

This runs automatically in GitHub Actions on all PRs.

## Branch Protection

- **No direct commits to main branch** - Use `just branch <name>` workflow
- **Pull requests required** - All changes go through PR process
- **Automated reviews** - Claude Code review runs on all PRs
- **Linear history preferred** - Use squash merge (enforced by `just merge`)
- **Safety checks** - The `git cim` alias and just recipes prevent accidental
  commits to main/master

## Platform Compatibility

**Supported Platforms**:

- **macOS** - Primary development platform (see `uname -n` detection in
  gh-process.just)
- **Linux** - CentOS/RHEL (RPM-based) and Debian/Ubuntu/Mint (DEB-based)
- Cross-platform package management handles distro differences automatically

**Detection**: Use `check_os` function from `.functions` to set `$CHICKOS`
variable for platform-specific logic.

## PR Workflow Details

The `just pr` command performs these steps:

1. Runs `_has_commits` check to ensure branch has commits
2. Runs `_pr-hook` (shellcheck + claude_permissions_sort)
3. Pushes branch with `git pushup`
4. Creates PR body using heredoc with last commit message
5. Sleeps 10s for GitHub API lag
6. Watches PR checks with `gh pr checks --watch -i 5`
7. Queries Copilot PR reviewer comments via GitHub GraphQL API
8. Displays Claude PR review comments

The `just merge` command:

1. Verifies you're on a branch (not main)
2. Merges PR with squash (`-s`) and deletes branch (`-d`)
3. Returns to main and pulls latest via `sync`

## macOS Automation

### launchd Service (`launchd/`)

A daily desktop cleanup Go binary (`launchd/daily_desktop_cleanup`) is
managed as a launchd service via
`launchd/net.chicks.daily-desktop-cleanup.plist`. Use the `just launchd-*`
recipes to install, reload, and inspect it.

### Cron Jobs (`cron.d/`)

`cron.d/daily/` and `cron.d/hourly/` hold scripts run by `bin/do_home_cron`,
a Perl dispatcher that executes all scripts in the appropriate subdirectory.
`cron.d/daily/home-git-pull` pulls this repo automatically each day.

## Repository Metadata

`.repo.toml` stores structured metadata (description, topics, feature flags
like `claude`, `claude-review`, `copilot-review`, `standard-release`).
Validate it with `just cue-verify` against the CUE schema in
`docs/repo-toml.cue`. Regenerate it with `just repo_toml_generate`.

## Configuration Files

- `.bashrc`, `.bash_profile` - Shell initialization (source `.functions` here)
- `.tmux.conf` - tmux configuration
- `.gitconfig` - Git configuration with custom aliases
- `.editorconfig` - Editor configuration for tabs/spaces consistency
- `.gitignore` - Standard ignore patterns
- `.gitattributes` - Line ending and binary file handling

# chicks-home

[![Open Source Love png2](https://badges.frapsoft.com/os/v2/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)
[![GPLv2 license](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://github.com/chicks-net/chicks-home/blob/master/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/chicks-net/chicks-home/graphs/commit-activity)

A battle-tested collection of shell configurations, automation scripts, and
command-line utilities for managing Unix/Linux development environments. Born
from years of maintaining home directories across dozens of servers running
different distros, this repo contains tools that solve real problems you've
probably encountered yourself.

## What's Inside

### Modern Development Workflow

- **[justfile](justfile)** - Streamlined PR workflow with `just branch`,
  `just pr`, `just merge` automation.  This workflow is also available
  through our [template-repo](https://github.com/fini-net/template-repo).
- **Custom git aliases** - `git pushup`, `git stp`, `git hh` and more
  time-savers in [.gitconfig](.gitconfig)
- **GitHub Actions** - Automated markdownlint, security scanning, and
  [Claude Code PR reviews](.github/workflows/claude-code-review.yml)
- **GitHub CLI tools** - Scripts for applying rulesets and managing repos via
  API

### Command-Line Utilities You'll Actually Use

**Text Processing:**

- `ruler` - Count characters visually on the command line (beats counting by
  hand)
- `comify` - Convert newlines to comma-separated lists
- `closefh` - Close inherited file handles cleanly

**Network & Security:**

- `check_ssl` - Quick SSL certificate expiration checker for monitoring
  multiple endpoints
- `watch_constate` - Monitor network connection states like `vmstat` but for
  connections

**Fun & Games:**

- `roll` - D&D-style dice roller for when you need to make random decisions
  (critical infrastructure)

**GitHub Workflow:**

- `github_fix_https` - Convert HTTPS clones to SSH for password-free git
  operations
- `apply-ruleset` - Apply repository rulesets via GitHub API

### Cross-Distro Package Management

The [.functions](.functions) library handles package installation across
RPM-based (CentOS/RHEL) and DEB-based (Debian/Ubuntu/Mint) systems:

```bash
. .functions
check_packages      # See what's missing
check_packages -i   # Install missing packages automatically
```

Includes automatic permission checking for SSH keys and smart timestamp-based
caching to avoid hammering package managers.

### Google Workspace Automation

The [google/AppScript/](google/AppScript/) directory contains Google Apps
Script utilities for automating Google Docs, Sheets, and other Workspace tasks.
Includes day-of-week updater scripts and comprehensive documentation links.

## Quick Start Examples

### Package Management Across Distros

```bash
# Check what packages are missing
. .functions
check_packages

# Install missing packages automatically
check_packages -i
```

The package checker handles the differences between `apt-get` and `yum` for
you, making it easy to maintain the same environment across different Linux
flavors.

### SSL Certificate Monitoring

```bash
# Check a specific endpoint
./check_ssl www.google.com:443

# Check multiple endpoints from a config file
./check_ssl
# Outputs expiration dates for all configured endpoints
```

Perfect for keeping tabs on certificate expiration across your infrastructure.

### Streamlined PR Workflow with just

```bash
# Start a new feature
just branch fix-bug-123

# Create PR and watch checks automatically
just pr

# After approval, merge and clean up
just merge
```

The justfile automates the entire GitHub PR lifecycle with built-in safety
checks to prevent commits on main.

## Installation

This is primarily a personal home directory configuration, but you're welcome
to cherry-pick utilities and configurations that solve your problems:

```bash
# Clone and explore
git clone git@github.com:chicks-net/chicks-home.git
cd chicks-home

# Cherry-pick individual scripts to your ~/bin
cp bin/ruler ~/bin/
cp bin/check_ssl ~/bin/

# Or source the functions library in your .bashrc
echo '. /path/to/chicks-home/.functions' >> ~/.bashrc

# Try out the just-based workflow
just list
```

For full home directory integration, I typically clone the repo and symlink
configurations. Open to suggestions for better installation automation.

## What's Cooking

**In Progress:**

- `daily_mysql_backup` - Making remote SQL-level backups easy and efficient
- Enhanced tmux configuration (also check out my
  [libtmux](https://github.com/chicks-net/libtmux) project for tmux automation)
- Cleaner ANSI color implementations

**Deliberately Avoiding:**

- Ansible (personal preference after the IBM/Red Hat acquisition)

## Contributing

Found a bug? Have a cool utility to add? PRs welcome!

- File [issues](https://github.com/chicks-net/chicks-home/issues) on GitHub
- Send pull requests (run `markdownlint-cli2` before submitting)
- Check out the [justfile](justfile) for the PR workflow

## License & Maintenance

GPLv2 licensed. Actively maintained across multiple Linux distros (CentOS,
Debian, Ubuntu, Mint) and macOS.

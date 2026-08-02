# chicks-home

[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/chicks-net/chicks-home/badge)](https://scorecard.dev/viewer/?uri=github.com/chicks-net/chicks-home)
[![Open Source Love png2](https://badges.frapsoft.com/os/v2/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)
[![GPLv2 license](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://github.com/chicks-net/chicks-home/blob/master/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/chicks-net/chicks-home/graphs/commit-activity)

A battle-tested collection of shell configurations, automation scripts, and
command-line utilities for managing Unix/Linux development environments. Born
from years of maintaining home directories across dozens of servers running
different distros, this repository contains tools that solve real problems you've
probably encountered yourself.

## What's Inside

### Modern Development Workflow

- **[justfile](justfile)** - Streamlined PR workflow with `just branch`,
  `just pr`, `just merge` automation.  This workflow is also available
  through our [template-repo](https://github.com/fini-net/template-repo).
- **Custom Git aliases** - `git pushup`, `git stp`, `git hh` and more
  time-savers in [.gitconfig](.gitconfig)
- **GitHub Actions** - Automated markdownlint, security scanning, and
  [Claude Code PR reviews](.github/workflows/claude-code-review.yml)
- **GitHub command-line tools** - Scripts for applying rulesets and managing repos via
  API

### Command-Line Utilities You'll Actually Use

The [docs/bin/](docs/bin/) directory has a Markdown page for every script in
`bin/`. Highlights:

- [check_ssl](docs/bin/check_ssl.md) - SSL certificate expiration checker for
  monitoring multiple endpoints
- [comify](docs/bin/comify.md) / [ruler](docs/bin/ruler.md) / [closefh](docs/bin/closefh.md) - text utilities
- [watch_constate](docs/bin/watch_constate.md) - connection-state watcher, like
  `vmstat` for TCP/UDP
- [roll](docs/bin/roll.md) / [chooser](docs/bin/chooser.md) - dice and weighted
  random pickers (critical infrastructure)
- [renovate-summary](docs/bin/renovate-summary.md) - report available dependency
  updates across all your GitHub repos using Renovate in read-only mode
- [repos-summary](docs/bin/repos-summary.md) / [add-scorecards](docs/bin/add-scorecards.md) - audit local repos and add
  OpenSSF Scorecard scanning

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

`check_ssl` checks SSL certificate dates for one or more `host:port` pairs
and prints the `notBefore` / `notAfter` dates. See
[docs/bin/check_ssl.md](docs/bin/check_ssl.md) for the full reference.

```bash
./check_ssl www.google.com:443
```

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

### Renovate Update Summary

`renovate-summary` scans all non-archived, non-fork repos for an owner (or
owners) and reports available dependency updates using the Renovate CLI in
read-only `--dry-run=lookup` mode. No in-repo Renovate config is required and
no PRs or branches are created. Requires `gh` (authenticated), `renovate`,
and `jq`.

```bash
renovate-summary                  # scan fini-net + chicks-net
renovate-summary --org fini-net   # scan one owner
renovate-summary --keep-report    # keep the JSON report for digging
```

See [docs/bin/renovate-summary.md](docs/bin/renovate-summary.md) for the full
flag list, column-meanings table, and example output.

## Installation

### Homebrew Installation (Recommended)

The easiest way to install the command-line utilities is via our
[Homebrew tap](https://github.com/chicks-net/homebrew-chicks):

```bash
# Option 1: Add the tap first (shorter install commands)
brew tap chicks-net/chicks
brew install chicks-git-tools
brew install chicks-monitoring-tools
brew install chicks-text-tools

# Option 2: Install directly without tapping (longer formula names)
brew install chicks-net/chicks/chicks-git-tools
brew install chicks-net/chicks/chicks-monitoring-tools
brew install chicks-net/chicks/chicks-text-tools
```

**What's included:**

- `chicks-git-tools` - Git/GitHub automation (repos-summary, github_fix_https,
  apply-ruleset)
- `chicks-monitoring-tools` - System and networking monitoring utilities.
- `chicks-text-tools` - Text utilities (comify, ruler, roll, closefh)

This handles installation paths and updates automatically through `brew upgrade`.

### Manual Installation

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

For full home directory integration, I typically clone the repository and symlink
configurations. Open to suggestions for better installation automation.

## Verifying releases

Each tagged release (e.g. `v0.1`) ships an asset bundle
(`chicks-home-<tag>.tar.gz` containing the dotfiles, `bin/` utilities,
`.functions`, `justfile`, and `.just/` modules - the things you'd actually
cherry-pick), a `checksums.txt` file, a cosign keyless signature
(`.bundle`), an SBOM (`.sbom.json`), and an SLSA provenance attestation
(`multiple.intoto.jsonl`).

### Quick verify with just

```bash
# Defaults to the latest release; pass a tag to verify a specific one.
just verify-release
just verify-release v0.1
```

### Verify the asset signature with cosign

```bash
# Replace v0.1 with the tag you want to verify.
TAG="v0.1"
curl -L -O "https://github.com/chicks-net/chicks-home/releases/download/${TAG}/chicks-home-${TAG}.tar.gz"
curl -L -O "https://github.com/chicks-net/chicks-home/releases/download/${TAG}/chicks-home-${TAG}.tar.gz.bundle"

cosign verify-blob \
  --bundle chicks-home-${TAG}.tar.gz.bundle \
  --certificate-identity-regexp "https://github.com/chicks-net/chicks-home/.github/workflows/release.yml@refs/tags/${TAG}" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
  chicks-home-${TAG}.tar.gz
```

### Verify SLSA build provenance

```bash
TAG="v0.1"
curl -L -O "https://github.com/chicks-net/chicks-home/releases/download/${TAG}/chicks-home-${TAG}.tar.gz"
curl -L -O "https://github.com/chicks-net/chicks-home/releases/download/${TAG}/multiple.intoto.jsonl"

slsa-verifier verify-artifact \
  --provenance-path multiple.intoto.jsonl \
  --source-uri github.com/chicks-net/chicks-home \
  --source-tag "${TAG}" \
  chicks-home-${TAG}.tar.gz
```

The signature is produced via keyless signing using GitHub Actions OIDC
identities, so there are no long-lived signing keys to trust or rotate - you
only trust the Sigstore Fulcio certificate chain and the workflow identity
printed above.

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

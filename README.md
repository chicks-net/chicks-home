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

- `github_fix_https` - Convert HTTPS clones to SSH for password-free Git
  operations
- `apply-ruleset` - Apply repository rulesets via GitHub API
- `renovate-summary` - Report available dependency updates across all your
  GitHub repos (even unconfigured ones) using Renovate in read-only mode

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

### Renovate Update Summary

`renovate-summary` scans all non-archived, non-fork repos for an owner (or
owners) and reports available dependency updates using the Renovate CLI in
read-only `--dry-run=lookup` mode. No in-repo Renovate config is required —
`--require-config=optional` means it works on repos that have never opted
into Renovate. It pulls a GitHub token via `gh auth token`, enumerates repos
with `gh repo list`, runs one batched Renovate lookup, and prints a
per-repo table. No PRs or branches are created.

Requires `gh` (authenticated), `renovate`, and `jq`.

```bash
renovate-summary                          # scan fini-net + chicks-net
renovate-summary --org fini-net           # scan one owner
renovate-summary --org fini-net,chicks-net
renovate-summary --limit 50              # cap repos per owner
renovate-summary --keep-report           # keep the JSON report for digging
renovate-summary --include-forks         # also scan forked repos
renovate-summary --include-archived      # also scan archived repos
renovate-summary --verbose               # show renovate progress (debug logs)
```

#### Column meanings

| Column      | Meaning                                                                                      |
| ----------- | -------------------------------------------------------------------------------------------- |
| `REPO`      | `owner/repo` name                                                                            |
| `DEPS`      | Total dependencies detected across all package managers                                      |
| `UPDATABLE` | Dependencies with at least one available update                                              |
| `UPDATES`   | Total pending update entries (a dep can have more than one, e.g. minor + major)              |
| `LIBYEARS`  | Aggregate "libyears" behind newest versions; `0.0` means everything is current               |
| `PROBS`     | Count of Renovate "problems" for that repo; non-zero means inspect the report                |

The `UPDATES` column is color-coded when run interactively: red for repos
with pending updates, green for up-to-date repos.

#### Example output

```text
$ renovate-summary
Listing repos for fini-net ...
Listing repos for chicks-net ...
Found 84 repos to scan.
Running Renovate in dry-run=lookup mode ...
(this may take a while for many repos)

Renovate update summary
~~~~~~~~~~~~~~~~~~~~~~~

REPO                                         DEPS  UPDATABLE  UPDATES LIBYEARS    PROBS
---------------------------------------- -------- ---------- -------- -------- --------
chicks-net/data-curated                        95         41       52      7.1        0
chicks-net/chicks-home                         50         32       45      4.5        0
chicks-net/homebrew-chicks                     49         34       45        4        0
fini-net/fini-infra                           107         33       37      5.5        0
fini-net/macaw                                 51         27       31     13.4        0
fini-net/gh-amp                                43         26       29      4.8        0
chicks-net/www-chicks-net                      43         15       15      2.2      132
fini-net/fini-coredns-example                  60          4        4      0.8        0
chicks-net/my-user-manuals                     11          0        0        0        0
chicks-net/check-domain                         0          0        0        0        0
... (74 more rows)

TOTAL                                        1135        410      476

33 repos with pending updates, 51 up to date, 84 total.

Repos with no pending updates:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  CLEAN chicks-net/my-user-manuals
  CLEAN chicks-net/check-domain
  ... (49 more)

Repos Renovate had problems with:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  PROBLEM chicks-net/www-chicks-net (132)
  PROBLEM fini-net/www-fini-net (2)
See /tmp/renovate-summary-report.json for details, or rerun with --verbose.
```

A full scan of 84 repos takes about 7 minutes; most of that is GitHub API
calls and git clones Renovate performs for dependency extraction. Use
`--keep-report` to retain the JSON report for drilling into a specific
repo's updates or problems.

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

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Repository Overview

This is Christopher Hicks' home directory configuration repository for managing
Unix/Linux environments across multiple servers: shell dotfiles, ~50 utility
scripts in `bin/`, and the automation that keeps them linted and released.

**Personal Configuration Note**: Paths and settings are specific to Christopher
Hicks' environment. Many scripts assume the home directory is symlinked to repo
contents (e.g. `.bashrc` sources `/home/chicks/.functions` and
`/home/chicks/.aliases` by absolute path). The repository intentionally avoids
Ansible due to maintainer preferences.

`AGENTS.md` holds the per-language style rules (bash, Perl, Python, just,
GitHub Actions, Markdown) - read it before writing code in a language you
haven't touched here yet. Highlights: Perl follows `.perltidyrc`
(`-l=128 -i=8 -et=8 -ce -nola -t`) with `use strict` and POD docs; Python
follows `.pylintrc` (tabs, 100-char lines).

## Development Commands

This repository uses [just](https://github.com/casey/just) as the task runner.
`just --list` shows everything; the root `justfile` imports 11 modules from
`.just/`. Run `.just/lib/install-prerequisites.sh` to install the required tools
(just, gh, shellcheck, markdownlint-cli2, jq) on macOS or Linux.

**Standard PR Workflow** (use this pattern for all changes):

```bash
just branch <name>    # Creates timestamped branch: chicks/YYYY-MM-DD-<name>
# Make your changes and commit
just pr               # Creates PR, pushes branch, watches checks automatically
just again            # After more commits: push, refresh PR body, watch checks
just merge            # Squash-merges PR, deletes branch, returns to main
```

**PR title format**: the commit subject becomes the PR title and must match
`emoji [topic] details...` (enforced by `pr-title-format.yml`), e.g.
`🧐 [gha] keep super-linter green when configs change`. Renovate PRs are
exempt; human PRs are not.

**Linting / validation** (there is no formal test suite):

- `just shellcheck` - shellcheck on shell scripts, including bash embedded in
  just recipes (extracted via awk before linting)
- `markdownlint-cli2 "**/*.md"` - required to pass before merge
- `just compliance_check` - verify expected docs/config files exist
- `just cue-verify` - validate `.repo.toml` against `docs/repo-toml.cue`
- `just editorconfig_check`, `just launchd-validate`
- `bin/test_lib` - manual smoke test of `spinner()` from `bin/lib.sh`

**Other recipes worth knowing**:

- `just sync` - return to main and pull
- `just pr_update` / `just pr_verify` - rewrite the PR's Done section from
  commits / append stdin to its Verify section
- `just pr_checks`, `just claude_review`, `just copilot_pick`,
  `just copilot_refresh` - inspect checks and AI review comments
- `just release <version>`, `just release_age`, `just verify-release [tag]` -
  releases are signed by `release.yml` (cosign, SLSA provenance, GitHub
  attestations); `verify-release` checks all three plus `checksums.txt`
- `just claude_permissions_sort` / `just claude_permissions_check` - keep
  `.claude/settings.local.json` permissions in canonical order (Bash →
  WebFetch → WebSearch → Other)
- `just mergepdf <dest> <src...>` - macOS only

### `just pr` internals

`just pr` checks the branch has commits, runs `_pr-hook` (in
`.just/pr-hook.just`: `just shellcheck` then `just claude_permissions_sort` -
add new pre-PR gates there), pushes with `git pushup`, builds the PR body from
the last commit message, then watches `gh pr checks` and prints Copilot and
Claude review comments. `just merge` squash-merges (`-s -d`) and runs `sync`.

### Git aliases (`.gitconfig`)

`git stp` (porcelain status), `git pushup` (`push -u origin HEAD`), `git hh` /
`git hist` (graph history), and `git cim <msg>`, which refuses to commit on
main/master. Never commit directly to main.

## Architecture

### `.just/` is vendored from template-repo

The `.just/` modules and `.just/lib/*.sh` helpers are synced from
[`fini-net/template-repo`](https://github.com/fini-net/template-repo), with
per-file versions tracked in `.just/CHECKSUMS.json`. Local edits drift from
upstream and show up in `just checksums_verify`; fixes generally belong in
template-repo and come back via `just update_from_template`. The numbered
`github/gh-process-*` scripts are one-shot migrations that branch, run
`update_from_template`, and commit a specific template release. Repo-specific
recipes (`verify-release`, `mergepdf`) live in the root `justfile`, and
`launchd.just` is local to this repo.

### Shell environment

- `.bash_profile` sources `.bashrc`, which sources `.functions`, `.aliases`,
  and `.git-prompt.sh`
- `.functions` - distro-agnostic helpers: `check_os` sets `$CHICKOS`
  (`RPM_CENTOS`, `DEB_MINT`, or `broken_shit`); `check_packages [-i]` checks or
  installs `UNIVERSAL_PKGS` plus `RPM_PKGS`/`DEB_PKGS` with a 1-hour timestamp
  cache; `check_all_permissions` enforces `.ssh` modes (700/600/644)
- `bin/lib.sh` - shared shell functions such as `spinner <pid>`
- `.aliae.yaml` - cross-shell aliases, env, and PATH (OS-conditional)
- `.config/starship.toml` - starship prompt (Tokyo Night based; timeouts are
  deliberately raised above the defaults)
- `Brewfile` - macOS packages

### `bin/` and its docs

Every top-level script in `bin/` has a page in `docs/bin/<script>.md`, indexed
by category in `docs/bin/README.md`. When adding or renaming a script, add or
update both. The legacy subdirectories (`bin/openx/`, `bin/perfect_audience/`,
`bin/telmate/`, `bin/threads/`) are not documented there. Scripts are a mix of
bash, Perl, Python (`bin/Pipfile`), and Go.

`github/` (top level, not under `bin/`) holds GitHub API tooling:
`apply-ruleset` with `github/rulesets/*.json`, `github_fix_https`, and the
gh-process migration scripts. See `github/README.md`.

### Scheduled jobs

- `bin/do_home_cron` is a Perl dispatcher that runs every script in
  `cron.d/daily/` or `cron.d/hourly/`; `cron.d/hourly/home-git-pull` keeps this
  repo current on each host.
- macOS: `bin/daily_desktop_cleanup.go` is built by `just launchd-build` into
  `launchd/daily_desktop_cleanup` and run via
  `launchd/net.chicks.daily-desktop-cleanup.plist`. Use the `just launchd-*`
  recipes to install, reload, run, and inspect it.

### Other directories

- `google/AppScript/` - Google Apps Script for Docs/Sheets automation
- `docs/` - `github-actions.md` (workflow standards), `writing-style-economist.md`
  (prose style for chicks.net content), `repo-toml.cue` (schema)
- `.repo.toml` - repo metadata and feature flags (`claude`, `claude-review`,
  `copilot-review`, `standard-release`); regenerate with
  `just repo_toml_generate`

## GitHub Actions

Workflows in `.github/workflows/`: `actionlint`, `auto-assign`, `checkov`,
`claude`, `claude-code-review`, `gitleaks`, `linter` (super-linter v9),
`markdownlint`, `opencode`, `pr-title-format`, `release`, `renovate-validate`,
`scorecards`, and `zizmor` (GHA security analysis). New workflows must follow
`docs/github-actions.md` (notably a global `permissions: {}` before
`jobs:`).

**No-regression rule**: every check must pass before a PR merges, and workflow
or linter config changes must not leave any check red. Super-linter runs with
`VALIDATE_ALL_CODEBASE: false`, so it lints only the files a PR touches; lint
debt in an untouched file surfaces on the first PR that edits it, so read the
full check list before merging. Two known false-positive sources are
configured away: the NATURAL_LANGUAGE terminology rule fights the house writing
style, so the terms repo, bash, git, awk, curl, and README are allowlisted in
`.github/linters/.textlintrc`; and justfiles are excluded via
`FILTER_REGEX_EXCLUDE` in `linter.yml` because just syntax is not bash -
recipe bodies are shellchecked by `just shellcheck` instead.

Dependency updates come from Renovate. Never close, delete, or revert a
Renovate PR, even when it is failing - leave it open and report the problem
instead.

## Maintaining This File

`bin/claude-init` regenerates this file non-interactively
(`claude --permission-mode acceptEdits -p "/init"`) and stages the result. Run
it when the repo structure changes significantly.

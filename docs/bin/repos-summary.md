# repos-summary

Audit local `git` repos for common hygiene issues.

## Synopsis

```bash
repos-summary
```

## Description

`repos-summary` is a Bash script that walks the local `git` repos under
`~/Documents/git`, `~/LocalDocuments/git`, and a creative-writing directory
and reports, for each repository:

- Whether the Claude code review workflow is present.
- Whether the `.just/gh-process.just` version matches a template repository's
  checksum.
- The current branch (flagging `master` as deprecated).
- Untracked / modified file counts, with a private/public marker derived
  from `gh`.
- Whether `install-prerequisites.sh` is duplicated.
- Release age and commits-since-release.

It ends with color-coded summary sections for:

- Repos with no releases.
- Repos with stale releases (>60 days old).
- Repos with outdated or missing `.just` files.
- Repos with duplicate `install-prerequisites.sh`.
- Repos with modified files.

Uses `set -u` (not full strict mode). No flags - all paths are hardcoded.

## Examples

```bash
$ repos-summary
...
SUMMARY: stale releases
  - chicks-net/foo  (last release 120 days ago)
...
```

## See Also

- [renovate-summary.md](renovate-summary.md) - report dependency updates
  across remote GitHub repos
- [add-scorecards.md](add-scorecards.md) - add OpenSSF Scorecard workflow + badge
- [github_fix_https.md](github_fix_https.md) - switch a repository from HTTPS to SSH

# add-scorecards

Add the OpenSSF Scorecard supply-chain security workflow and a README badge
to a git repository.

## Synopsis

```bash
add-scorecards [-n|--dry-run] [-h|--help] <repo-path>
```

## Description

`add-scorecards` bootstraps supply-chain security scanning into a git
repository by writing `.github/workflows/scorecards.yml` (with pinned action
versions) and inserting the OpenSSF Scorecard badge line into `README.md`.

It uses the `gh` CLI to resolve the repo slug from the local checkout, then
writes the workflow file and patches the README. On completion it prints the
next-step `git` commands you'll want to run.

## Arguments

| Argument | Description |
| --- | --- |
| `repo-path` | Path to the local git repo to modify. Required. |
| `-n`, `--dry-run` | Preview the changes without writing anything. |
| `-h`, `--help` | Print usage and exit. |

## Examples

```bash
# Preview what would change
add-scorecards --dry-run ./my-repo

# Apply the workflow + badge
add-scorecards ./my-repo
```

## See Also

- [renovate-summary.md](renovate-summary.md) - report dependency updates
- [repos-summary.md](repos-summary.md) - audit local repos

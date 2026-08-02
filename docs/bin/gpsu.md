# gpsu

Push the current `git` branch to `origin` with `--set-upstream`.

## Synopsis

```bash
gpsu
```

## Description

`gpsu` is a tiny Bash wrapper for `git push --set-upstream origin <branch>`.
It determines the current branch via `git describe --contains --all HEAD` and
pushes it upstream so future `git push` and `git pull` calls don't need the
remote/branch arguments. It deliberately refuses to push `master`, exiting
with status 1, to prevent accidents on legacy default branches.

No arguments, no flags.

## Examples

```bash
# On a new feature branch
gpsu
```

## See Also

- [github_fix_https.md](github_fix_https.md) - switch a repository's remote from HTTPS to SSH
- [repos-summary.md](repos-summary.md) - audit local `git` repos

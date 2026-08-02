# github_fix_https

Convert the current repository's `origin` remote from HTTPS to SSH so Git stops
asking for a password.

## Synopsis

```bash
github_fix_https
```

## Description

`github_fix_https` rewrites the `origin` remote URL of the current `git`
repository from an `https://github.com/...` form to the
`git@github.com:...` SSH form. It parses the existing remote with `sed`,
extracts the user and repository slugs, and runs `git remote set-url` to switch
over. Once the remote points at SSH, pushes and pulls authenticate via
your SSH key instead of prompting for a username and password.

The script lives in [`github/`](../../github/) alongside the other
GitHub automation helpers - it is not part of `bin/`.

No flags, no arguments. Run it from inside the repository you want to fix. If
the remote is already on SSH (or can't be parsed as a GitHub HTTPS URL)
it prints an error and exits without changing anything.

## Examples

```bash
# From inside a repo whose origin is HTTPS
github_fix_https
```

## See Also

- [../../github/`README.md`](../../github/`README.md`) - overview of the
  `github/` scripts and rulesets.
- [repos-summary.md](repos-summary.md) - audit local repos for hygiene
  issues.
- [add-scorecards.md](add-scorecards.md) - add the OpenSSF Scorecard
  workflow to a repository.

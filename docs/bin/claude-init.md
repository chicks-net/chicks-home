# claude-init

Bootstrap a `CLAUDE.md` for a repository using the `claude` CLI's `/init`.

## Synopsis

```bash
claude-init
```

## Description

`claude-init` is a short bash wrapper that automates bootstrapping a
`CLAUDE.md` file for a repo:

1. Creates a feature branch via `just branch claude-init`.
2. Runs `claude --permission-mode acceptEdits -p "/init"` to let Claude
   generate the initial `CLAUDE.md`.
3. Stages the new file with `git add CLAUDE.md`.
4. Stashes the working tree with `git stp` (a custom alias) for review.

Strict mode (`set -euo pipefail`) is enabled. No arguments.

## Examples

```bash
cd ~/Documents/git/my-repo
claude-init
```

## See Also

- [compliance-check.md](compliance-check.md) - another `just`-driven wrapper

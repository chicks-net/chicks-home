# compliance-check

Run the `template-repo` compliance check against the current directory.

## Synopsis

```bash
compliance-check
```

## Description

`compliance-check` is a single-line shell wrapper that delegates to a `just`
recipe defined in an external template repository:

```bash
just -d . -f ~/Documents/git/template-repo/justfile compliance_check
```

It runs the compliance check from `template-repo` against the current working
directory, which verifies the repo has the expected documentation and
configuration files (AGENTS.md, CLAUDE.md, LICENSE, etc.). Because it
delegates entirely to the external justfile, it has no flags or arguments of
its own - pass any arguments by editing the upstream recipe.

## Examples

```bash
# From the repo you want to check
compliance-check
```

## See Also

- The repo's [AGENTS.md](../../AGENTS.md) - describes what the compliance
  check verifies
- [claude-init.md](claude-init.md) - another `just`-driven wrapper

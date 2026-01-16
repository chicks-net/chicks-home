# AGENTS.md

This file provides guidance for agentic coding agents working in this repository.

## Build/Lint/Test Commands

### Primary Commands

- `just compliance_check` - Verify repository has expected documentation
  and configuration files
- `just shellcheck` - Run shellcheck on all bash scripts in just recipes
- `markdownlint-cli2 "**/*.md"` - Lint all Markdown files (required for PR merges)

### Git Workflow Commands

- `just branch <name>` - Create timestamped feature branch
  (chicks/YYYY-MM-DD-name)
- `just pr` - Create pull request, push branch, watch checks automatically
- `just merge` - Squash-merge PR, delete branch, return to main
- `just sync` - Return to main branch and pull latest changes

### Testing

- No formal test suite currently exists
- Use `just shellcheck` to validate shell scripts
- Manual testing of bin/ utilities expected

## Code Style Guidelines

### Shell Scripts (Bash)

- **Shebang**: Use `#!/bin/bash` or `#!/usr/bin/env bash`
- **Strict Mode**: Use `set -euo pipefail` in scripts and just recipes
- **Indentation**: Tabs (preferred for consistency with .editorconfig)
- **Line Length**: No strict limit, but aim for readability
- **Functions**: Use `function name()` format from `.functions`
- **Variables**: UPPERCASE for exports, lowercase for local variables
- **Error Handling**: Check command exit codes, use conditional execution
- **Imports**: Source `.functions` for package management, `bin/lib.sh` for utilities

### Perl Scripts

- **Shebang**: Use `#!/usr/bin/perl -w`
- **Pragmas**: Always include `use strict;`
- **Documentation**: Use POD format (see `bin/comify` for example)
- **Formatting**: Follow `.perltidyrc` configuration
  (-l=128, -i=8, -et=8, -ce, -nola, -t)

### Python Scripts

- **Shebang**: Use `#!/usr/bin/env python`
- **Style**: Follow PEP 8 with customizations from `.pylintrc`
- **Constants**: `const-rgx=[a-z_][a-z0-9_]{2,30}$`
- **Indentation**: Tabs (`indent-string=\t`)
- **Line Length**: Maximum 100 characters

### Just Recipes

- **Structure**: Import modular recipes from `.just/` directory
- **Groups**: Use `[group('name')]` for organization
- **Scripts**: Use bash shebang and strict mode in recipe scripts
- **Colors**: Use color variables: `{{GREEN}}`, `{{RED}}`, `{{BLUE}}`,
  `{{MAGENTA}}`, `{{NORMAL}}`

### Markdown Files

- **Linting**: Must pass `markdownlint-cli2` validation
- **Line Length**: Aim for 80-100 characters
- **Headers**: Use ATX style (`#`, `##`, etc.)
- **Code Blocks**: Use fenced code blocks with language specification

## Naming Conventions

### Files

- **Shell scripts**: Lowercase with underscores (e.g., `check_ssl`)
- **Python scripts**: Lowercase with underscores (e.g., `roll.py`)
- **Perl scripts**: Lowercase with underscores (e.g., `comify`)
- **Configuration**: Dotfiles for hidden configs (e.g., `.bashrc`)

### Functions

- **Shell**: `function_name()` format, descriptive names
- **Variables**: `local_var` for locals, `EXPORT_VAR` for environment variables

### Directories

- **Binaries**: `bin/` for executable scripts
- **GitHub**: `.github/` for GitHub-specific files
- **Just modules**: `.just/` for modular justfile components

## Error Handling Patterns

### Shell Scripts

```bash
#!/usr/bin/env bash
set -euo pipefail  # strict mode

# Check for required commands
if ! command -v required_cmd &> /dev/null; then
    echo "{{RED}}Error: required_cmd not found{{NORMAL}}" >&2
    exit 1
fi

# Use conditional execution
command_that_might_fail || {
    echo "{{RED}}Error: command failed{{NORMAL}}" >&2
    exit 1
}
```

### Just Recipe Patterns

```bash
#!/usr/bin/env bash
set -euo pipefail

# Color-coded output
echo "{{BLUE}}Processing...{{NORMAL}}"
echo "{{GREEN}}Success!{{NORMAL}}"
echo "{{RED}}Error occurred{{NORMAL}}" >&2
```

## Repository Structure

### Core Directories

- `bin/` - Command-line utilities and scripts
- `.just/` - Modular justfile components
- `.github/workflows/` - GitHub Actions workflows
- `google/` - Google Workspace automation scripts

### Key Files

- `justfile` - Main task runner configuration
- `.functions` - Cross-platform package management library
- `bin/lib.sh` - Shared shell functions (spinner, etc.)
- `CLAUDE.md` - Repository-specific guidance for Claude Code

## Platform Compatibility

### OS Detection

- Use `check_os()` function from `.functions` to set `$CHICKOS`
- Supports: `RPM_CENTOS`, `DEB_MINT`, `broken_shit` (fallback)
- Package management handled automatically via `check_packages`

### Cross-Platform Considerations

- Test on both macOS and Linux when possible
- Use portable Unix tools and avoid platform-specific extensions
- Handle different package managers via the functions library

## Security Best Practices

- Never commit secrets or API keys
- Use proper file permissions (700 for .ssh/, 600 for private keys)
- Validate input in scripts, especially when processing external data
- Use `set -euo pipefail` to prevent common security issues

## Git Workflow

- **No direct commits to main** - Always use feature branches
- **PR process required** - Use `just pr` workflow
- **Squash merges** - Use `just merge` for clean history
- **Automated reviews** - Claude Code review runs on all PRs

## Testing Philosophy

- Manual testing of bin/ utilities expected
- Use `just shellcheck` for static analysis
- Validate Markdown with `markdownlint-cli2`
- Test just recipes with actual command execution
- Cross-platform testing encouraged but not required

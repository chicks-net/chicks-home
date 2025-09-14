# GitHub Scripts and Configuration

This directory contains scripts and configuration files for working with GitHub
repositories, focusing on automation and repository management.

## Contents

### Rulesets

- `rulesets/` - GitHub repository ruleset configurations
  - `default-linear.json` - Standard ruleset enforcing linear history,
    preventing deletions and non-fast-forward pushes

## GitHub Resources

### GitHub CLI (gh)

The GitHub CLI brings GitHub to your terminal, allowing you to manage
repositories, issues, pull requests, and more from the command line.

- [GitHub CLI Documentation](https://cli.github.com/)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [Installation Guide](https://github.com/cli/cli#installation)

### GitHub REST API

The GitHub REST API provides programmatic access to GitHub resources and
functionality.

- [GitHub REST API Documentation](https://docs.github.com/en/rest)
- [API Reference](https://docs.github.com/en/rest/reference)
- [Authentication Guide](https://docs.github.com/en/rest/guides/getting-started-with-the-rest-api)

### GitHub GraphQL API

The GitHub GraphQL API offers more flexible queries and can reduce the number
of requests needed.

- [GitHub GraphQL API Documentation](https://docs.github.com/en/graphql)
- [GraphQL Explorer](https://docs.github.com/en/graphql/overview/explorer)
- [Schema Reference](https://docs.github.com/en/graphql/reference)

### Repository Rulesets

Repository rulesets help enforce branch protection and workflow requirements.

- [About Rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets)
- [Creating Rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/creating-rulesets-for-a-repository)
- [Managing Rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets)

### GitHub Actions

For workflow automation and CI/CD integration.

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Marketplace](https://github.com/marketplace?type=actions)

## Getting Started

1. Install the GitHub CLI: `brew install gh` (macOS) or check the
   [installation guide](https://github.com/cli/cli#installation)
2. Authenticate: `gh auth login`
3. Explore available commands: `gh help`

## Common Commands

```bash
# Repository management
gh repo create
gh repo clone
gh repo view

# Issues and PRs
gh issue list
gh pr create
gh pr review

# GitHub Actions
gh workflow list
gh run list
```

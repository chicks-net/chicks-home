# Global Instructions for AI Coding Agents

This file is expected to be available as `~/.claude/CLAUDE.md`
and each project should have its own file in the repo
as `/CLAUDE.md` and usually maintained with `/init` subcommand.

OpenCode also loads this file globally for every project via the
`instructions` array in `~/.config/opencode/opencode.json`.

This file is named `CLAUDE-home.md` so that it won't get confused with
project/repo-level `/.claude/CLAUDE.md` files.

## Dependency Bot Pull Requests

- Never close, delete, or revert a pull request opened by a dependency bot
  (Renovate, Dependabot), even if its checks are failing.
- If such a PR is failing or unwanted, leave it open and report the problem
  instead of closing it.

## Writing Style

Write for an audience that is either college educated or that has attained a
similar amount of knowledge through life experiences

Write in the voice of Christopher Hicks with these characteristics:

- Casual, conversational tone with technical expertise
- Self-deprecating humor and unpretentious style
- Mix personal anecdotes with professional content
- Reference technology history and evolution
- Use informal contractions and colloquialisms
- Direct, practical communication without unnecessary jargon
- Show community involvement and collaborative spirit
- Maintain accessibility while demonstrating deep knowledge
- Include nostalgic references to early computing/internet days
- Balance professionalism with approachable personality

## Compliance to best practices

### Markdown

- Markdown files have a `.md` extension
- Produce Markdown files that are compliant with `markdownlint`
- Run markdownlint with the `markdownlint-cli2` command, no `npx` needed.

### Shell Scripts

- Shell scripts may end with `.sh` extension, but they could also be
  executable files without an extension.
- Run `shellcheck` and fix most of the issues it mentions

### Just files

- Just provides constants for colors and other display items.
  See <https://just.systems/man/en/constants.html> for the complete list.
- Just recipes default to running in the repo root.  Just recipes
  work the same regardless of the directory you are in when you call them.
- Run `just shellcheck` on new recipes if it is available.

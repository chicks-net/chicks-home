# rotate_claude_oauth_token

Update the `CLAUDE_CODE_OAUTH_TOKEN` repo secret across every `chicks-net`
repo that has it, using `gh secret set` on each one.

## Synopsis

```bash
rotate_claude_oauth_token [-l] [-n] [-f token-file] [-r repo]... [-h]
```

## Description

`rotate_claude_oauth_token` rotates a shared OAuth token without touching the
command line: it discovers every non-archived repo in the org that currently
holds the `CLAUDE_CODE_OAUTH_TOKEN` secret, then pushes the new value to each
of them.

The script:

1. Lists non-archived repos in the org with `gh repo list`.
2. Checks each repo's secrets with `gh secret list` to find the ones holding
    `CLAUDE_CODE_OAUTH_TOKEN`.
3. Shows the target repos and asks for a `y/N` confirmation (when run from a
    terminal).
4. Reads the new token from a file, a pipe, or a hidden prompt - never from
    `argv`, so it stays out of shell history and process listings.
5. Runs `gh secret set` on every target repo and reports the results.

The new value is read from the first line of the file or pipe with surrounding
whitespace stripped, so a trailing newline never ends up inside the secret.

## Requirements

- `gh` - authenticated with admin (secret management) access to the repos

## Options

| Option | Description |
| --- | --- |
| `-l` | List the repos that have the secret and exit - no token needed. |
| `-n` | Dry run - show what would be updated, but change nothing. |
| `-f token-file` | Read the new token from a file (first line only). |
| `-r repo` | Skip discovery and target specific repos; repeatable. A bare name is qualified to `chicks-net/`, an `owner/repo` is used as-is. Secret presence is not verified. Duplicate entries are collapsed. |
| `-h` | Print usage and exit. |

Without `-f`, `-r`, or a piped stdin, the script prompts for the token with
echo disabled and asks for it twice to confirm.

## Examples

```bash
rotate_claude_oauth_token -l                  # list repos with the secret
rotate_claude_oauth_token -n                  # dry run, no token needed
rotate_claude_oauth_token -f token.txt        # read new value from a file
cat token.txt | rotate_claude_oauth_token     # read new value from stdin
rotate_claude_oauth_token                     # hidden interactive prompt
rotate_claude_oauth_token -r repoA -r repoB   # skip discovery, name repos
```

## Notes

- A piped-token run (stdin not a terminal) proceeds without the `y/N`
  confirmation, so it can be scripted; an interactive run always confirms
  before writing anything.
- Repos whose secret check failed during discovery (rate limit, permissions,
  network) are listed separately and never updated - a "successful" run can't
  silently leave a stale token behind.
- A warning is printed if the value does not start with `sk-ant-oat`, the
  usual prefix of a Claude OAuth token.
- Archived repos are excluded from discovery; discovery warns if the org has
  hit the 1000-repo listing limit.
- The exit status is non-zero if any repo update failed, with the failures
  listed.

## See Also

- [add-scorecards.md](add-scorecards.md) - add OpenSSF Scorecard workflow + badge
- [renovate-summary.md](renovate-summary.md) - report dependency updates
- [repos-summary.md](repos-summary.md) - audit local `git` repos

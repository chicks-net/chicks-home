# renovate-summary

Report available dependency updates across all your GitHub repos using
Renovate in read-only mode.

## Synopsis

```bash
renovate-summary [--org OWNER[,OWNER...]] [--limit N] [--keep-report]
                  [--include-forks] [--include-archived] [--verbose]
                  [--report-path PATH] [-h]
```

## Description

`renovate-summary` scans all non-archived, non-fork repos for one or more
GitHub owners and reports available dependency updates using the Renovate CLI
in read-only `--dry-run=lookup` mode. No in-repository Renovate config is required -
`--require-config=optional` means it works on repos that have never opted into
Renovate.

The script:

1. Pulls a GitHub token via `gh auth token`.
2. Enumerates repos with `gh repo list`.
3. Runs one batched Renovate lookup.
4. Parses the JSON report with `jq`.
5. Prints a per-repository summary table (see [Column meanings](#column-meanings))
    plus totals and a list of repos Renovate had problems with.

No PRs or branches are created - it's purely a reporting tool.

## Requirements

- `gh` - authenticated
- `renovate` - the Renovate CLI
- `jq`

## Flags

| Flag | Description |
| --- | --- |
| `--org OWNER[,OWNER...]` | Comma-separated list of GitHub owners. Default: `fini-net,chicks-net`. |
| `--limit N` | Cap the number of repos enumerated per owner. |
| `--report-path PATH` | Custom path for the JSON report Renovate writes. |
| `--keep-report` | Don't delete the JSON report on exit - useful for digging into a repository. |
| `--include-forks` | Also scan forked repos (excluded by default). |
| `--include-archived` | Also scan archived repos (excluded by default). |
| `--verbose` | Show Renovate progress / debug logs. |
| `-h`, `--help` | Print usage and exit. |

## Column meanings

| Column | Meaning |
| --- | --- |
| `REPO` | `owner/repo` name. |
| `DEPS` | Total dependencies detected across all package managers. |
| `UPDATABLE` | Dependencies with at least one available update. |
| `UPDATES` | Total pending update entries (a dep can have more than one, e.g. minor + major). |
| `LIBYEARS` | Aggregate "libyears" behind newest versions; `0.0` means everything is current. |
| `PROBS` | Count of Renovate "problems" for that repository; non-zero means inspect the report. |

The `UPDATES` column is color-coded when run interactively: red for repos
with pending updates, green for up-to-date repos.

## Examples

```bash
renovate-summary                          # scan fini-net + chicks-net
renovate-summary --org fini-net           # scan one owner
renovate-summary --org fini-net,chicks-net
renovate-summary --limit 50              # cap repos per owner
renovate-summary --keep-report           # keep the JSON report for digging
renovate-summary --include-forks         # also scan forked repos
renovate-summary --include-archived      # also scan archived repos
renovate-summary --verbose               # show renovate progress (debug logs)
```

## Example execution

It takes a while for the command to run across my repos.
This animation is sped up 10x so it really is taking 2 entire
minutes for this script to process a single repo.  Most finish
faster than that, but the worst case is pretty bad.

![animation of running the renovate-summary command with no arguments](renovate-summary.gif)

## Example output

```text
$ renovate-summary
Listing repos for fini-net ...
Listing repos for chicks-net ...
Found 84 repos to scan.
Running Renovate in dry-run=lookup mode ...
(this may take a while for many repos)

Renovate update summary
~~~~~~~~~~~~~~~~~~~~~~~

REPO                                         DEPS  UPDATABLE  UPDATES LIBYEARS    PROBS
---------------------------------------- -------- ---------- -------- -------- --------
chicks-net/data-curated                        95         41       52      7.1        0
chicks-net/chicks-home                         50         32       45      4.5        0
chicks-net/homebrew-chicks                     49         34       45        4        0
fini-net/fini-infra                           107         33       37      5.5        0
fini-net/macaw                                 51         27       31     13.4        0
fini-net/gh-amp                                43         26       29      4.8        0
chicks-net/www-chicks-net                      43         15       15      2.2      132
fini-net/fini-coredns-example                  60          4        4      0.8        0
chicks-net/my-user-manuals                     11          0        0        0        0
chicks-net/check-domain                         0          0        0        0        0
... (74 more rows)

TOTAL                                        1135        410      476

33 repos with pending updates, 51 up to date, 84 total.

Repos Renovate had problems with:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  PROBLEM chicks-net/www-chicks-net (132)
  PROBLEM fini-net/www-fini-net (2)
See /tmp/renovate-summary-report.json for details, or rerun with --verbose.
```

## Notes

A full scan of 84 repos takes about 7 minutes; most of that is GitHub API
calls and Git clones Renovate performs for dependency extraction. Use
`--keep-report` to retain the JSON report for drilling into a specific repository's
updates or problems.

## See Also

- [repos-summary.md](repos-summary.md) - audit local `git` repos
- [add-scorecards.md](add-scorecards.md) - add OpenSSF Scorecard workflow + badge

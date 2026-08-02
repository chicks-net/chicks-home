# bin/ command reference

One Markdown page per script in [`bin/`](../../bin/). Subdirectories
(`openx/`, `perfect_audience/`, `telmate/`, `threads/`) are not covered here,
nor are the `Pipfile` / `Pipfile.lock` dependency manifests.

## GitHub workflow

| Script | Summary |
| --- | --- |
| [add-scorecards](add-scorecards.md) | Add the OpenSSF Scorecard workflow + README badge to a repo. |
| [claude-init](claude-init.md) | Bootstrap a `CLAUDE.md` via the `claude` CLI's `/init`. |
| [compliance-check](compliance-check.md) | Run the `template-repo` compliance check against the current dir. |
| [gpsu](gpsu.md) | Push the current branch to `origin` with `--set-upstream` (refuses `master`). |
| [renovate-summary](renovate-summary.md) | Report dependency updates across GitHub repos via Renovate (read-only). |
| [repos-summary](repos-summary.md) | Audit local git repos for hygiene issues (releases, branches, `.just` files). |

## Text utilities

| Script | Summary |
| --- | --- |
| [blnkln](blnkln.md) | Print a single blank line. |
| [closefh](closefh.md) | Close inherited file handles cleanly. |
| [comify](comify.md) | Convert newline-separated input into a comma-separated line. |
| [fifths](fifths.md) | Split a number into fifths. |
| [fixdecode](fixdecode.md) | Quick grep-and-rewrite filter for FIX-protocol-style log records. |
| [ruler](ruler.md) | Print a column ruler for checking output alignment. |

## Network & security

| Script | Summary |
| --- | --- |
| [check_ssl](check_ssl.md) | SSL certificate expiration checker for multiple endpoints. |
| [haproxy_stats](haproxy_stats.md) | Per-minute connection statistics from an HAProxy log file. |
| [host_scanner](host_scanner.md) | Resolve hosts and probe SSH (22) / NRPE (5666) reachability. |
| [ip2smokeping](ip2smokeping.md) | Turn a list of IPs into SmokePing config stanzas. |
| [watch_constate](watch_constate.md) | Watch TCP/UDP connection states like `vmstat`. |
| [watch_zk_conns](watch_zk_conns.md) | Watch ZooKeeper-related TCP connections in a loop. |

## IPMI & infrastructure

| Script | Summary |
| --- | --- |
| [ipmi-reboot](ipmi-reboot.md) | Set PXE boot and power-cycle a host via IPMI. |
| [ipmi-reimage](ipmi-reimage.md) | PXE-boot, power-cycle, and attach to SOL to watch a reimage. |

## Desktop & daily jobs

| Script | Summary |
| --- | --- |
| [daily_desktop_cleanup](daily_desktop_cleanup.md) | Archive macOS screenshots older than 30 days off the Desktop. |
| [daily_desktop_cleanup.go](daily_desktop_cleanup.go.md) | Go port of `daily_desktop_cleanup`. |
| [daily_mysql_backup](daily_mysql_backup.md) | Back up MySQL databases via `xtrabackup` / `innobackupex`. |
| [do_home_cron](do_home_cron.md) | Run every executable script inside a `~/cron.d/<name>` directory. |
| [mv_mini_metro_screencaps](mv_mini_metro_screencaps.md) | Organize Mini Metro game screenshots by population and type. |

## Session & process management

| Script | Summary |
| --- | --- |
| [start_synergy](start_synergy.md) | Supervisor loop that keeps `synergys` running. |
| [start_tmux](start_tmux.md) | Create and attach a host-specific tmux session layout. |
| [run_10s](run_10s.md) | Sleep for 10 seconds - a test fixture. |
| [run_forever](run_forever.md) | Loop forever printing a heartbeat - a long-running test fixture. |
| [lib.sh](lib.sh.md) | Shared bash library providing a `spinner` function. |
| [test_lib](test_lib.md) | Tiny test harness for `lib.sh`'s `spinner`. |

## Random & dice

| Script | Summary |
| --- | --- |
| [chooser](chooser.md) | Weighted-random picker reading `<weight> <desc>` lines from STDIN. |
| [roll](roll.md) | D&D-style dice roller using `NdM` notation (Perl). |
| [roll.py](roll.py.md) | Python implementation of the `NdM` dice roller. |

## Time & timing

| Script | Summary |
| --- | --- |
| [countdown](countdown.md) | Adaptive countdown timer that prints remaining time at varying intervals. |
| [tim](tim.md) | Python reimplementation of `time(1)` with console, syslog, and Slack logging. |
| [whenis](whenis.md) | Convert a Unix epoch timestamp into times across time zones. |

## Passwords & keyring

| Script | Summary |
| --- | --- |
| [genpass](genpass.md) | Generate passwords that avoid ambiguous look-alike characters. |
| [gkeyring](gkeyring.md) | Shell access to the GNOME keyring (query, create, delete, lock, unlock). |

## Media

| Script | Summary |
| --- | --- |
| [split_chunks](split_chunks.md) | Split a video into 28-second chunks starting every 10 seconds. |
| [youtube2mp3](youtube2mp3.md) | Download a YouTube video and transcode it to MP3. |

## SSH key provisioning

| Script | Summary |
| --- | --- |
| [infect](infect.md) | Provision SSH keys into a host via tmux keystrokes. |
| [plague](plague.md) | Run `infect` across a list of data centers. |
| [clone_merge_chicks](clone_merge_chicks.md) | Migrate a home directory to the `chicks-home` git-tracked layout. |

## Developer workflow helpers

| Script | Summary |
| --- | --- |
| [tf-gh-clip](tf-gh-clip.md) | Wrap a Terraform plan for pasting into a GitHub comment (collapsible `<details>`). |
| [tidyrt](tidyrt.md) | Convenience wrapper around `perltidy` for the `rt` script. |
| [labelgrep.sh](labelgrep.sh.md) | Search inside `.lbx` (label / zip) files for a pattern. |

## Novelty & smoke tests

| Script | Summary |
| --- | --- |
| [chm-tshirt](chm-tshirt.md) | Decode the binary numbers on a Computer History Museum t-shirt (Perl). |
| [chm-tshirt.go](chm-tshirt.go.md) | Go reimplementation of `chm-tshirt`. |
| [hello.go](hello.go.md) | Minimal Go "hello world" smoke test. |
| [bg-color](bg-color.md) | Query the terminal for its current foreground / background RGB colors. |

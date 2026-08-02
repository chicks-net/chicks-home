# gkeyring

Shell access to the GNOME keyring.

## Synopsis

```bash
gkeyring [options]
```

## Description

`gkeyring` is a Python (originally Python 2 / `optparse`) command-line tool
for querying, creating, deleting, locking, and unlocking items in the GNOME
keyring from a shell. Output is printed as tab-separated columns, which
makes it easy to pipe into `awk`, `cut`, or another script.

By default it queries items; with `-s/--set` it creates one, with `-d/--delete`
it removes one, and `--lock` / `--unlock` operate on the keyring itself.
Items can be filtered by `--id`, `--name`, or string (`-p`) / integer (`-i`)
parameters, and the output columns can be trimmed with `-o` or collapsed to
just the secret with `-1` (no trailing newline).

Authored by Kamil Páral, AGPL-3 licensed, version 0.3.99.

## Flags

| Flag | Description |
| --- | --- |
| `-t`, `--type` | Item type: `generic` (default), `network`, or `note`. |
| `-k`, `--keyring` | Keyring to operate on. Defaults to the default keyring. |
| `--id` | Filter by item id. |
| `-n`, `--name` | Filter by item name. |
| `-p` | Add a string parameter filter (repeatable). |
| `-i` | Add an integer parameter filter (repeatable). |
| `-o`, `--output` | Comma-separated list of columns to print. |
| `-1` | Print only the secret, no newline. |
| `-s`, `--set` | Create a new item. |
| `-d`, `--delete` | Delete the matched item(s). |
| `--lock` | Lock the keyring. |
| `--unlock` | Unlock the keyring (will prompt for the password). |
| `-w`, `--password` | Password to use with `--set` / `--unlock`. |
| `--all` | Match all items (don't require an `--id` / `--name` filter). |

## Examples

```bash
# Look up a GitHub token by name and print just the secret
gkeyring -n 'github.com' -1

# List every generic item in the login keyring
gkeyring --all -k login
```

## See Also

- [genpass.md](genpass.md) - generate look-alike-safe passwords

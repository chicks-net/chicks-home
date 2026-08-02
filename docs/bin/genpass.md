# genpass

Generate passwords that avoid ambiguous look-alike characters.

## Synopsis

```bash
genpass [apg-args]
```

## Description

`genpass` is a three-line bash wrapper around `apg` (Automated Password
Generator) that filters out characters that are easy to confuse visually -
`i`, `o`, `1`, `0` (case-insensitive) - so the generated passwords can be read
aloud or transcribed without the usual "is that an I or a 1?" problem.

Because it just pipes `apg` through a filter, any flags `apg` itself accepts
are passed through implicitly via the pipe.

## Requirements

- `apg` must be installed and on `PATH`.

## Examples

```bash
# Generate one look-alike-safe password
genpass

# Hand off any apg flags (length, count, etc.)
genpass -m 20 -x 20 -n 5
```

## See Also

- [gkeyring.md](gkeyring.md) - shell access to the GNOME keyring for storing secrets

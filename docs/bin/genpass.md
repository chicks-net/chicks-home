# genpass

Generate passwords that avoid ambiguous look-alike characters.

## Synopsis

```bash
genpass
```

## Description

`genpass` is a three-line Bash wrapper around `apg` (Automated Password
Generator) that filters out characters that are easy to confuse visually -
`i`, `o`, `1`, `0` (case-insensitive) - so the generated passwords can be read
aloud or transcribed without the usual "is that an I or a 1?" problem.

It takes no arguments. Because `apg` is invoked as the left side of a pipe,
flags cannot be forwarded to it - running `genpass -m 20 -x 20 -n 5` will
silently ignore every flag. If you need `apg`'s options, call `apg` directly
and pipe through `grep -vi '[io10]'` yourself.

## Requirements

- `apg` must be installed and on `PATH`.

## Examples

```bash
# Generate one look-alike-safe password
genpass

# Equivalent with explicit apg flags
apg -m 20 -x 20 -n 5 | grep -vi '[io10]'
```

## See Also

- [gkeyring.md](gkeyring.md) - shell access to the GNOME keyring for storing secrets

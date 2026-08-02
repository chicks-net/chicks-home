# labelgrep.sh

Search inside `.lbx` (label / zip) files for a pattern.

## Synopsis

```bash
labelgrep.sh <pattern>
```

## Description

`labelgrep.sh` is a bash script that searches inside `.lbx` files (which are
ZIP archives) in the current directory tree for a given pattern using
`zipgrep`, printing the filenames that match. It's the grep-and-find you'd
otherwise hand-roll every time you need to dig into a pile of label-format
files.

It exits with status 1 if no pattern is supplied.

## Arguments

| Argument | Description |
| --- | --- |
| `pattern` | Pattern to search for inside `.lbx` files. Required. |

## Examples

```bash
labelgrep.sh 'example.com'
labelgrep.sh 'tracking_number'
```

## See Also

- [comify.md](comify.md) - text-list helper

# roll.py

Python implementation of the `NdM` dice roller.

## Synopsis

```bash
roll.py <spec> [spec ...]
```

## Description

`roll.py` is a Python (originally Python 2) reimplementation of the Perl
[roll](roll.md) script. It parses the same `NdM` tabletop notation with a
regular expression, prints each individual die result, and prints a
`total/possible` line for multi-dice rolls. Unlike the Perl version it prints
a friendly error message for unparseable specs instead of dying, which makes
it slightly nicer as an interactive tool. It raises `ValueError` if invoked
with no arguments at all.

## Arguments

| Argument | Description |
| --- | --- |
| `spec` | Dice spec in `NdM` form, e.g. `3d6`, `d100`. Repeatable. |

## Examples

```bash
$ roll.py 3d6
4
2
6
total: 12 / 18

$ roll.py d20
11
```

## See Also

- [roll.md](roll.md) - the original Perl implementation

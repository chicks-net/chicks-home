# roll

D&D-style dice roller using standard `NdM` notation.

## Synopsis

```bash
roll <spec> [spec ...]
```

## Description

`roll` is a Perl dice roller that parses the classic tabletop notation `NdM`
("roll N M-sided dice") and prints each individual die result plus, for
multi-dice rolls, a `total/max` summary line. When the count is omitted
(`d20`) it defaults to a single die. It dies loudly on malformed specs, which
makes it safe to feed from scripts that need to know when the input was bad.

A companion Python implementation exists as [roll.py](roll.py.md); the two are
functionally equivalent.

## Arguments

| Argument | Description |
| --- | --- |
| `spec` | Dice spec in `NdM` form, e.g. `2d6`, `d20`, `4d8`. Repeatable - each spec gets its own block of output. |

## Examples

```bash
$ roll 2d6
1
5
total: 6 / 12

$ roll d20
14
```

## See Also

- [roll.py.md](roll.py.md) - Python port of the same roller
- [chooser.md](chooser.md) - weighted-random picker for non-dice decisions

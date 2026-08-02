# chooser

Weighted-random picker that reads `<weight> <description>` lines from STDIN.

## Synopsis

```bash
chooser < input
some-command | chooser
```

## Description

`chooser` is a Perl weighted-random selection tool. It reads lines from STDIN
in the form `<weight> <description>`, sums the weights, picks a random value
weighted by those sums, and prints the chosen item prefixed with
`picked >>>`. Useful for weighted random selection - raffles, traffic
splitting, A/B test bucket assignment, "which lunch spot today" - anywhere a
flat `RANDOM` isn't enough.

It dies on unparseable input, which keeps scripts that pipe into it honest.

No flags.

## Examples

```bash
$ printf '3 pizza\n2 sushi\n1 salad\n' | chooser
picked >>> pizza
```

## See Also

- [roll.md](roll.md) - dice-notation random roller
- [roll.py.md](roll.py.md) - Python port of `roll`

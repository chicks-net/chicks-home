# fifths

Split a number into fifths.

## Synopsis

```bash
fifths <number>
```

## Description

`fifths` is a small Perl utility that takes a single numeric argument and
prints `total*(n/5)=portion` for `n` from 1 to 5 - i.e. it splits a value
into five equal portions and shows each one plus the cumulative math. Handy
for quick mental checks when dividing a budget, an estimate, or any total
into fifths without reaching for a calculator.

It dies with `no argument` if none is provided. POD docs are included.

## Arguments

| Argument | Description |
| --- | --- |
| `number` | The total to split into fifths. Required. |

## Examples

```bash
$ fifths 100
total*(1/5)=20
total*(2/5)=40
total*(3/5)=60
total*(4/5)=80
total*(5/5)=100
```

## See Also

- [comify.md](comify.md) - another small text utility

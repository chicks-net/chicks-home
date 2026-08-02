# comify

Convert newline-separated input into a single comma-separated line.

## Synopsis

```bash
comify < input
some-command | comify
```

## Description

`comify` is a Perl filter that reads STDIN line by line and emits one
comma-separated line, preserving a trailing comma after the final entry. It's
the thing you reach for when you've got a column from `ls`, `git branch`, or
`cut` and you want to paste it straight into a SQL `IN (...)` clause or a CSV
header row without hand-editing.

Because the trailing comma is left in place, common follow-up is to strip it
with `sed 's/,$//'`.

## Examples

```bash
# Build a SQL IN list from a column of IDs
$ printf '1\n2\n3\n' | comify
1,2,3,

# Strip the trailing comma
$ git branch --format='%(refname:short)' | comify | sed 's/,$//'
main,feature/foo,feature/bar
```

## See Also

- [fifths.md](fifths.md) - another small text-math helper

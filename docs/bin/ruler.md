# ruler

Print a column ruler so you can stop counting characters by eye.

## Synopsis

```bash
ruler
```

## Description

`ruler` prints two lines to stdout: a tens-column header and a numbered scale
(`1234567890...`) spanning 120 columns. The header uses nine-space padding
between digits, so the `0`, `1`, and `2` markers land at columns 100, 110, and
120. Drop it into a terminal when you need to verify column alignment in
wrapped output, table borders, or log lines instead of counting characters by
hand.

It takes no arguments and has no flags - it's intentionally a four-liner.

## Examples

```ScreenOutput
$ ruler
         1         2         3         4         5         6         7         8         9         0         1         2
123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
```

## See Also

- [blnkln.md](blnkln.md) - another tiny output helper

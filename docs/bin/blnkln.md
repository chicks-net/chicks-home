# blnkln

Print a single blank line.

## Synopsis

```bash
blnkln
```

## Description

`blnkln` is a three-line bash script that runs `echo ''`. That's it. It exists
so you have a named, self-documenting way to add a blank line in a pipeline
or shell script instead of reaching for `echo` with an empty string every
time. Useful in `find ... -exec` chains, build logs, or anywhere a one-shot
spacing helper reads better than the equivalent `echo`.

No arguments, no flags.

## Examples

```bash
# Separate two sections of build output
make build && blnkln && make test
```

## See Also

- [ruler.md](ruler.md) - column ruler for verifying output alignment

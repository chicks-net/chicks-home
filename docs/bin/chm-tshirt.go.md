# chm-tshirt.go

Go reimplementation of [chm-tshirt](chm-tshirt.md).

## Synopsis

```bash
go run chm-tshirt.go
```

## Description

`chm-tshirt.go` is a standalone `package main` Go program that decodes the
same three hardcoded 8-bit binary strings as the Perl version
(`01000011`, `01001000`, `01001101`) using `strconv.ParseInt(bin, 2, 64)`,
then converts each to a string rune and prints a `binary decimal letter`
line for each. The three decoded letters spell `CHM` (Computer History Museum).

It's the Go-learning companion to the Perl [chm-tshirt](chm-tshirt.md) - same
problem, different language.

No arguments, no flags. The shebang line is commented out, so it's intended
to be run with `go run` (or compiled) rather than executed directly.

## Examples

```bash
$ go run chm-tshirt.go
01000011 67 C
01001000 72 H
01001101 77 M
```

## See Also

- [chm-tshirt.md](chm-tshirt.md) - the original Perl decoder
- [hello.go.md](hello.go.md) - a Go "hello world" smoke test

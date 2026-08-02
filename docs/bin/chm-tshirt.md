# chm-tshirt

Decode the binary numbers printed on a Computer History Museum t-shirt.

## Synopsis

```bash
chm-tshirt
```

## Description

`chm-tshirt` is a Perl one-liner-ish script that decodes three hardcoded 8-bit
binary values (`01000011 01001000 01001101`) into ASCII letters via
`pack`/`unpack` and `chr`, printing `CHM`. The binary-to-ASCII mechanics are
explained in the embedded POD documentation.

It's a novelty / educational script - the kind of thing you write once to
prove the binary on the shirt actually spells something, then keep around
because it makes you smile.

A Go port exists as [chm-tshirt.go](chm-tshirt.go.md).

No arguments, no flags.

## Examples

```bash
$ chm-tshirt
CHM
```

## See Also

- [chm-tshirt.go.md](chm-tshirt.go.md) - Go reimplementation of the same decoder

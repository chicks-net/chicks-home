# fixdecode

Quick grep-and-rewrite filter for FIX-protocol-style log records.

## Synopsis

```bash
fixdecode [grep-args] < input
some-command | fixdecode [grep-args]
```

## Description

`fixdecode` is a three-line Bash script that pipes `grep $*` output through a
`sed` filter which:

- Replaces a leading `A` with three spaces.
- Rewrites the FIX tag-35 marker (`35=`) to `type=`.
- Rewrites the FIX tag-44 marker (`44=`) to `price=`.

Field 35 is the FIX protocol's `MsgType` tag and 44 is `Price`, so this is a
quick decoder for financial trade-record logs that have been dumped in raw
FIX format. All arguments are forwarded straight to `grep`, so you can pass
patterns, `-i`, file paths, etc.

## Arguments

| Argument | Description |
| --- | --- |
| `grep-args` | Any arguments to forward to `grep` (patterns, flags, files). |

## Examples

```bash
# Decode every line in a trade log that mentions tag 35
fixdecode ' 35=' < trades.log

# Decode and filter for a specific message type
fixdecode ' 35=D' < trades.log
```

## See Also

- [comify.md](comify.md) - another small text-processing filter

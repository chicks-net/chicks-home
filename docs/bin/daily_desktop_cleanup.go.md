# daily_desktop_cleanup.go

Go port of [daily_desktop_cleanup](daily_desktop_cleanup.md).

## Synopsis

```bash
go run daily_desktop_cleanup.go
```

## Description

`daily_desktop_cleanup.go` is a Go reimplementation of the Bash
[daily_desktop_cleanup](daily_desktop_cleanup.md) script. It:

1. Creates `~/Pictures/ScreenShots` if it doesn't exist.
2. Globs the same screenshot patterns (`Screenshot*.png`, `Screen Shot*.png`,
    `Screenshot*.jpg`) on `~/Desktop`.
3. Moves files older than 30 days to the archive directory.

It improves on the original with timestamped logging, real error handling,
and a safe `moveFile` helper that refuses to overwrite existing destinations
and preserves file mode.

The file carries a `//go:build ignore` build tag, so it isn't compiled into
the bin directory's normal build - run it with `go run`.

## Examples

```bash
go run daily_desktop_cleanup.go
```

## See Also

- [daily_desktop_cleanup.md](daily_desktop_cleanup.md) - the original Bash script
- [hello.go.md](hello.go.md) - another Go file in `bin/`

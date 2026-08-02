# mv_mini_metro_screencaps

Organize Mini Metro game screenshots by population and type.

## Synopsis

```bash
mv_mini_metro_screencaps
```

## Description

`mv_mini_metro_screencaps` is a Perl script that tidies up Mini Metro game
screencaps. The game takes screenshots in pairs - a "Map" shot and a "Trace"
shot, one second apart in mtime - and dumps both onto `~/Desktop`. This
script:

1. Finds PNG pairs on `~/Desktop` that share a one-second-apart mtime.
2. Extracts the population count encoded in the filename.
3. Moves both files into `~/Pictures/MiniMetro/`.
4. Renames each with the population and type (Map / Trace), stripping spaces.

It dies on assertion failures when file pairing breaks down (e.g. an odd
number of matching files), which surfaces corruption early instead of
silently mis-filing screenshots.

No arguments, no flags.

## Examples

```bash
mv_mini_metro_screencaps
```

## See Also

- [daily_desktop_cleanup.md](daily_desktop_cleanup.md) - archive old
  screenshots off the Desktop

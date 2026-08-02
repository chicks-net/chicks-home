# bg-color

Query the terminal for its current foreground and background RGB colors.

## Synopsis

```bash
bg-color [variable-prefix]
```

## Description

`bg-color` is a tiny bash utility adapted from a Stack Overflow answer that
sends terminal escape sequences to query the current foreground and
background RGB colors and captures the responses into bash variables. It
defines a `getTermRGB` helper, calls it with the variable prefix, and then
`declare -p`s the resulting `cTcolorsFg_*` / `cTcolorsBg_*` variables so you
can see (and reuse) the colors the terminal reported.

It's useful when you're scripting colored output and want to pick a palette
that doesn't clash with the user's terminal theme.

## Arguments

| Argument | Description |
| --- | --- |
| `variable-prefix` | Optional. Name prefix for the captured color variables. Defaults to `cTcolors`. |

## Examples

```bash
bg-color
bg-color myTheme
```

## See Also

- [ruler.md](ruler.md) - another tiny terminal-output helper

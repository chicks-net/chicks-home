# tidyrt

Convenience wrapper around `perltidy` for the `rt` script.

## Synopsis

```bash
tidyrt
```

## Description

`tidyrt` is a five-line bash convenience wrapper around `perltidy` for the
`rt` script (a hardcoded filename, not an argument). It runs `perltidy` with
the options `-ce -t -nola -l=110`, then generates an HTML rendering via
`perltidy -html rt.tdy`, and moves the resulting `rt.tdy.html` into
`~/public_html` for easy viewing in a browser.

It's a personal workflow shortcut: edit `rt`, run `tidyrt`, refresh the
browser. Not general-purpose - the filename is hardcoded.

No arguments, no flags.

## Examples

```bash
$ tidyrt
# Now visit ~/public_html/rt.tdy.html in a browser
```

## See Also

- [tf-gh-clip.md](tf-gh-clip.md) - another developer-workflow wrapper
- The repo's `.perltidyrc` for the project-wide Perl formatting config

# closefh

Check whether a specific file is open by this process and emit a command to close it.

## Synopsis

```bash
closefh <file>
eval $(closefh <file>)
```

## Description

`closefh` is a small Perl utility for closing a single inherited file descriptor
from within a shell. When you spawn a shell subprocess, it inherits all open
file descriptors from the parent. Sometimes you need to close a specific file
in the child without affecting the parent.

The script uses `lsof` to check whether the given file is currently open by
the current process. If it is, it prints a shell command of the form
`exec N>&-` to stdout that you can `eval` to close that descriptor in the
current shell. If the file isn't open, it prints a warning to STDERR. It does
not close the descriptor itself - it hands you the command to do so, so the
closure happens in your shell rather than in a subprocess.

## Arguments

| Argument | Description |
| --- | --- |
| `file` | Path to the file you want to close, as shown by `lsof`. Required. |

## Examples

```bash
# Close an inherited file handle in the current shell
eval $(closefh /var/log/app.log)

# Just see what command would be issued (without running it)
closefh /tmp/lockfile
# Prints: exec 3>&-
# Or warns: /tmp/lockfile not opened by this process

# Use in a shell script to clean up before exec'ing a daemon
eval $(closefh /dev/pts/1)
exec some-daemon
```

## See Also

- [comify.md](comify.md) - another text utility shipped alongside `closefh`
  via the `chicks-text-tools` Homebrew formula

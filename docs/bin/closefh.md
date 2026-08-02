# closefh

Close inherited file handles cleanly.

## Synopsis

```bash
closefh
```

## Description

`closefh` is a small utility for tidying up file descriptors that a process
inherited from its parent but shouldn't keep open - the classic "daemon that
accidentally holds your shell's TTY open" problem. It walks the process's open
file handles and closes the ones that were inherited rather than opened by the
current program, so background processes can detach properly.

## Examples

```bash
# Inside a daemon start-up sequence, after the fork
closefh
exec my_long_running_service
```

## See Also

- [comify.md](comify.md) - another text utility shipped alongside `closefh`
  via the `chicks-text-tools` Homebrew formula

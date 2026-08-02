# test_lib

Tiny test harness for [lib.sh](lib.sh.md)'s `spinner`.

## Synopsis

```bash
test_lib
```

## Description

`test_lib` is a tiny bash test harness for the [lib.sh](lib.sh.md) shared
library. It sources the library, kicks off a background [run_10s](run_10s.md)
job, and uses the `spinner` function (passing the background PID `$!`) to
display a spinner while waiting. It prints `wait` during execution and
`done` when the background job has finished.

It's the canonical example of how to drive `spinner` from your own scripts.

No flags, no arguments.

## Examples

```bash
$ test_lib
wait / - \ | / - \ | done
```

## See Also

- [lib.sh.md](lib.sh.md) - the library under test
- [run_10s.md](run_10s.md) - the background job `test_lib` runs
- [run_forever.md](run_forever.md) - a longer-lived alternative test job

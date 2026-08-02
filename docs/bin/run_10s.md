# run_10s

Sleep for 10 seconds. A test fixture.

## Synopsis

```bash
run_10s
```

## Description

`run_10s` is a trivial Bash script that sleeps for 10 seconds and exits.
It exists to be a predictable short-running job for process / spinner /
wrapper test harnesses - notably [lib.sh](lib.sh.md)'s `spinner` function
and the [test_lib](test_lib.md) harness that exercises it.

No arguments, no flags.

## Examples

```bash
# Use it as a sample job for the spinner
source lib.sh
run_10s &
spinner $!
```

## See Also

- [run_forever.md](run_forever.md) - the infinite-loop counterpart
- [lib.sh.md](lib.sh.md) - the `spinner` library `run_10s` is meant to test
- [test_lib.md](test_lib.md) - the harness that uses `run_10s`

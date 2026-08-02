# check_ssl

Quick SSL certificate expiration checker for monitoring multiple endpoints.

## Synopsis

```bash
check_ssl [host:port ...]
```

## Description

`check_ssl` runs `openssl s_client` against each `host:port` argument and pipes
the certificate into `openssl x509` to print the `notBefore` and `notAfter`
dates. It's a one-liner wrapper that's handy for keeping tabs on certificate
expiration across many endpoints from a cron job or shell loop.

When called with no arguments it falls back to a small built-in default list
(`dev.sepi.fini.net:443 prod.ireserve.info:443`), so running it bare on a fresh
checkout still does something useful.

## Arguments

| Argument | Description |
| --- | --- |
| `host:port` | Endpoint to probe. Repeatable. If omitted, the hardcoded default list is used. |

## Examples

```bash
# Check a single endpoint
./check_ssl www.google.com:443

# Check several endpoints from a config file
./check_ssl $(cat endpoints.txt)

# Bare invocation uses the built-in defaults
./check_ssl
```

## See Also

- [watch_constate.md](watch_constate.md) - another network monitoring helper
- [haproxy_stats.md](haproxy_stats.md) - parse HAProxy logs for connection stats

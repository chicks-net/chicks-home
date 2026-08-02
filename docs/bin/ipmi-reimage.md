# ipmi-reimage

PXE-boot a host, power-cycle it, and attach to SOL to watch the reimage.

## Synopsis

```bash
ipmi-reimage <target-host>
```

## Description

`ipmi-reimage` is a Bash wrapper around `ipmitool` (lanplus, `ADMIN`/`ADMIN`
credentials) that's a more thorough sibling of [ipmi-reboot](ipmi-reboot.md).
It:

1. Reports the initial power status.
2. Sets the next boot device to PXE.
3. Performs a chassis power reset.
4. Checks the power status again.
5. Activates Serial-over-LAN (SOL) so you can watch the reimage stream
    through the BMC console.

Use this when you want to actually see the install happen; use
[ipmi-reboot](ipmi-reboot.md) when you just want the box to PXE and reboot.

Credentials are hardcoded for the lab environment this was written for; copy
the script and change them for your own.

## Arguments

| Argument | Description |
| --- | --- |
| `target-host` | BMC / IP address of the host to reimage. Required. |

## Examples

```bash
ipmi-reimage 10.0.0.42
```

## See Also

- [ipmi-reboot.md](ipmi-reboot.md) - the simpler "just reboot and PXE" variant

# ipmi-reboot

PXE-boot and power-cycle a host via IPMI.

## Synopsis

```bash
ipmi-reboot <target-host>
```

## Description

`ipmi-reboot` is a Bash wrapper around `ipmitool` (lanplus, `ADMIN`/`ADMIN`
credentials) that:

1. Sets the next boot device to PXE.
2. Performs a chassis power reset.
3. Reports the power status.

It's the quick "reboot this box and make it PXE" button. The credentials are
hardcoded for the lab environment this was written for; copy the script and
change them for your own.

## Arguments

| Argument | Description |
| --- | --- |
| `target-host` | BMC / IP address of the host to reboot. Required. |

## Examples

```bash
ipmi-reboot 10.0.0.42
```

## See Also

- [ipmi-reimage.md](ipmi-reimage.md) - reboot and attach to the SOL console to watch the reimage

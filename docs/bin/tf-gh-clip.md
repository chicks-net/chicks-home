# tf-gh-clip

Wrap a Terraform plan for pasting into a GitHub comment (collapsible
`<details>` block, copied to the clipboard).

## Synopsis

```bash
terraform show -no-color plan | tf-gh-clip [introduction-text]
```

## Description

`tf-gh-clip` is a bash script that wraps Terraform plan output so it can be
pasted into a GitHub comment / PR as a collapsible `<details>` block, then
copies the result to the macOS clipboard via `pbcopy`.

It reads terraform output from STDIN and requires macOS (it checks
`uname == Darwin`, since `pbcopy` is macOS-only). If the input contains a
`Plan:` line it trims the extraneous header/footer that terraform prints
around the actual plan summary; otherwise it wraps the full stdin verbatim.
The optional argument becomes the intro text printed above the `<details>`
block.

## Arguments

| Argument | Description |
| --- | --- |
| `introduction-text` | Optional. Text printed above the `<details>` block. |

## Examples

```bash
# Plan, then wrap for a GitHub PR comment
terraform plan -out=plan.tfplan
terraform show -no-color plan.tfplan | tf-gh-clip "Plan for #123"

# Now paste (Cmd-V) into the GitHub PR comment box.
```

## See Also

- [tidyrt.md](tidyrt.md) - another developer-workflow wrapper

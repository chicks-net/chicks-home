# github actions

- must pass actionlint, which runs as a github action
- should use the latest version of actions when possible,
  but don't update unrelated actions

## for checkov

Must include this before `jobs` section and after `on` section::

```yaml
# global permissions
permissions: {}
```

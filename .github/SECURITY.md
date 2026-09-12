# Project Security Policy

## Confidential Disclosure

Please email [chicks.net@gmail.com](mailto:chicks.net@gmail.com) with a subject
line like "$REPONAME SECURITY issue: $SUMMARY".  Details on when you experienced
the issue, logs, and other context are appreciated to assist with effective
triaging of your issue.

## Security Updates

End users should expect new releases to include any security updates and there
should be a notification in the release notes.
We may participate in other disclosure programs as circumstances may warrant.

## Known issues

There are no known security vulnerabilities in the software at the time
this was written.

## Security Risks

We are unaware of any security risks particular to this software that you
should be aware of.  Please let us know if we missed anything or forgot to
update this section in too long.

## Verifying releases

Each tagged release (e.g. `v0.1`) ships an asset bundle
(`chicks-home-<tag>.tar.gz` containing the dotfiles, `bin/` utilities,
`.functions`, `justfile`, and `.just/` modules - the things you'd actually
cherry-pick), a `checksums.txt` file, a cosign keyless signature
(`.bundle`), an SBOM (`.sbom.json`), and an SLSA provenance attestation
(`multiple.intoto.jsonl`).

### Quick verify with just

```bash
# Defaults to the latest release; pass a tag to verify a specific one.
just verify-release
just verify-release v0.1
```

### Verify the asset signature with cosign

```bash
# Replace v0.1 with the tag you want to verify.
TAG="v0.1"
curl -L -O "https://github.com/chicks-net/chicks-home/releases/download/${TAG}/chicks-home-${TAG}.tar.gz"
curl -L -O "https://github.com/chicks-net/chicks-home/releases/download/${TAG}/chicks-home-${TAG}.tar.gz.bundle"

cosign verify-blob \
  --bundle chicks-home-${TAG}.tar.gz.bundle \
  --certificate-identity-regexp "https://github.com/chicks-net/chicks-home/.github/workflows/release.yml@refs/tags/${TAG}" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
  chicks-home-${TAG}.tar.gz
```

### Verify SLSA build provenance

```bash
TAG="v0.1"
curl -L -O "https://github.com/chicks-net/chicks-home/releases/download/${TAG}/chicks-home-${TAG}.tar.gz"
curl -L -O "https://github.com/chicks-net/chicks-home/releases/download/${TAG}/multiple.intoto.jsonl"

slsa-verifier verify-artifact \
  --provenance-path multiple.intoto.jsonl \
  --source-uri github.com/chicks-net/chicks-home \
  --source-tag "${TAG}" \
  chicks-home-${TAG}.tar.gz
```

The signature is produced via keyless signing using GitHub Actions OIDC
identities, so there are no long-lived signing keys to trust or rotate - you
only trust the Sigstore Fulcio certificate chain and the workflow identity
printed above.

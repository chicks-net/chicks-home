# project justfile

import? '.just/template-sync.just'
import? '.just/repo-toml.just'
import? '.just/pr-hook.just'
import? '.just/cue-verify.just'
import? '.just/copilot.just'
import? '.just/claude.just'
import? '.just/compliance.just'
import? '.just/gh-process.just'
import? '.just/shellcheck.just'
import? '.just/test.just'
import? '.just/launchd.just'

# list recipes (default works without naming it)
[group('example')]
list:
    just --list
    @echo "{{GREEN}}Your justfile is waiting for more scripts and snippets{{NORMAL}}"

# thanks to https://apple.stackexchange.com/a/230447/210526
# merge PDFs
[no-cd, macos]
[group('Utility')]
mergepdf dest_file *src_files:
    "/System/Library/Automator/Combine PDF Pages.action/Contents/MacOS/join" -o {{dest_file}} {{src_files}}

# Verify a release's cosign signature and SLSA provenance (defaults to latest)
# Usage: just verify-release [v0.1]
[group('Release')]
verify-release TAG=`gh release view --json tagName -q .tagName`:
    #!/usr/bin/env bash
    set -euo pipefail

    TAG="{{TAG}}"
    REPO="chicks-net/chicks-home"
    BUNDLE="chicks-home-${TAG}.tar.gz"
    BASE="https://github.com/${REPO}/releases/download/${TAG}"

    echo "{{BLUE}}Verifying release ${TAG} for ${REPO}...{{NORMAL}}"

    # Check required tools
    for tool in cosign slsa-verifier curl gh; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            echo "{{RED}}Error: '$tool' not found. Install with: brew install $tool{{NORMAL}}"
            exit 1
        fi
    done

    WORKDIR="$(mktemp -d)"
    trap 'rm -rf "$WORKDIR"' EXIT
    cd "$WORKDIR"

    echo "{{GREEN}}Downloading assets for ${TAG}...{{NORMAL}}"
    # Use --fail so curl exits non-zero on 4xx/5xx (e.g. 404) instead of
    # silently saving the GitHub "Not Found" error page, which later makes
    # cosign choke with "invalid character 'N' looking for beginning of value".
    for ASSET in "${BUNDLE}" "${BUNDLE}.bundle" "multiple.intoto.jsonl" "checksums.txt"; do
        if ! curl --fail --location --output "${ASSET}" "${BASE}/${ASSET}"; then
            echo "{{RED}}Error: failed to download ${BASE}/${ASSET} (HTTP error)."
            echo "       Release ${TAG} may have no signed assets attached."
            echo "       Check: gh release view ${TAG} --json assets -q '.assets[].name'{{NORMAL}}"
            exit 1
        fi
    done

    echo "{{GREEN}}Verifying cosign keyless signature...{{NORMAL}}"
    cosign verify-blob \
        --bundle "${BUNDLE}.bundle" \
        --certificate-identity-regexp "https://github.com/${REPO}/.github/workflows/release.yml@refs/tags/${TAG}" \
        --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
        "${BUNDLE}"

    echo "{{GREEN}}Verifying SLSA build provenance...{{NORMAL}}"
    slsa-verifier verify-artifact \
        --provenance-path multiple.intoto.jsonl \
        --source-uri "github.com/${REPO}" \
        --source-tag "${TAG}" \
        "${BUNDLE}"

    echo "{{GREEN}}Verifying checksums.txt...{{NORMAL}}"
    # checksums.txt only covers the bundle; regenerate and compare.
    EXPECTED="$(grep -E " ${BUNDLE}\$" checksums.txt | awk '{print $1}')"
    # sha256sum is GNU coreutils (absent on macOS); fall back to shasum -a 256
    if command -v sha256sum >/dev/null 2>&1; then
        ACTUAL="$(sha256sum "${BUNDLE}" | awk '{print $1}')"
    else
        ACTUAL="$(shasum -a 256 "${BUNDLE}" | awk '{print $1}')"
    fi
    if [[ "$EXPECTED" != "$ACTUAL" ]]; then
        echo "{{RED}}Checksum mismatch: expected $EXPECTED, got $ACTUAL{{NORMAL}}"
        exit 1
    fi

    echo "{{GREEN}}All signature and provenance checks passed for ${TAG}!{{NORMAL}}"

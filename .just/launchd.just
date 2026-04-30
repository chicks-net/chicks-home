# launchd management recipes
#
# Note: Uses color variables (BLUE, GREEN, RED, etc.) defined in the main justfile.
# This module requires those constants to be available.
#
# macOS-only: All launchd recipes require macOS. They will error on other platforms.

PLIST_NAME := "net.chicks.daily-desktop-cleanup.plist"
PLIST_SOURCE := "launchd" / PLIST_NAME
PLIST_DEST := env_var("HOME") / "Library/LaunchAgents" / PLIST_NAME
SERVICE_NAME := "net.chicks.daily-desktop-cleanup"

LAUNCHD_BIN := "launchd" / "daily_desktop_cleanup"
LAUNCHD_GO_SOURCE := "bin" / "daily_desktop_cleanup.go"

# internal: check if running on macos
[group('launchd')]
_check-macos:
    #!/usr/bin/env bash
    set -euo pipefail

    if [[ "$(uname)" != "Darwin" ]]; then
        echo "{{RED}}Error: launchd recipes are macOS-only{{NORMAL}}" >&2
        exit 1
    fi

# internal: copy plist with path substitution
[group('launchd')]
_copy-plist:
    #!/usr/bin/env bash
    set -euo pipefail

    REPO_ROOT="$(pwd)"
    sed -e "s#/Users/chicks/Documents/git/chicks-home#${REPO_ROOT}#g" \
        "{{PLIST_SOURCE}}" > "{{PLIST_DEST}}"
    echo "{{BLUE}}Updated paths for: ${REPO_ROOT}{{NORMAL}}"

# install the launchd plist file
[group('launchd')]
launchd-install:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check-macos
    echo "{{BLUE}}Installing launchd plist...{{NORMAL}}"

    if [[ ! -f "{{PLIST_SOURCE}}" ]]; then
        echo "{{RED}}Error: {{PLIST_SOURCE}} not found{{NORMAL}}" >&2
        exit 1
    fi

    mkdir -p ~/Library/LaunchAgents
    just _copy-plist

    echo "{{GREEN}}Copied {{PLIST_SOURCE}} to {{PLIST_DEST}}{{NORMAL}}"

    if launchctl list | grep -q "{{SERVICE_NAME}}"; then
        echo "{{YELLOW}}Already loaded. Use just launchd-reload to update.{{NORMAL}}"
    else
        launchctl bootstrap gui/"$(id -u)" "{{PLIST_DEST}}"
        echo "{{GREEN}}Loaded {{SERVICE_NAME}}{{NORMAL}}"
    fi
    echo ""
    echo "{{MAGENTA}}Verify with: just launchd-status{{NORMAL}}"

# check launchd job status
[group('launchd')]
launchd-status:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check-macos
    echo "{{BLUE}}Checking launchd status for {{SERVICE_NAME}}...{{NORMAL}}"

    if launchctl list | grep -q "{{SERVICE_NAME}}"; then
        echo "{{GREEN}}Job is loaded{{NORMAL}}"
        echo ""
        launchctl list | grep "{{SERVICE_NAME}}" || true
        echo ""
        echo "{{MAGENTA}}Last 10 lines from log:{{NORMAL}}"
        LOG_FILE="$HOME/Library/Logs/daily-desktop-cleanup.log"
        if [[ -f "$LOG_FILE" ]]; then
            tail -10 "$LOG_FILE"
        else
            echo "{{YELLOW}}No log file found yet{{NORMAL}}"
        fi
    else
        echo "{{YELLOW}}Job is NOT loaded{{NORMAL}}"
        echo ""
        echo "{{MAGENTA}}Install with: just launchd-install{{NORMAL}}"
    fi

# unload the launchd job
[group('launchd')]
launchd-unload:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check-macos
    echo "{{BLUE}}Unloading {{SERVICE_NAME}}...{{NORMAL}}"

    if launchctl list | grep -q "{{SERVICE_NAME}}"; then
        launchctl bootout gui/"$(id -u)" "{{PLIST_DEST}}"
        echo "{{GREEN}}Unloaded {{SERVICE_NAME}}{{NORMAL}}"
    else
        echo "{{YELLOW}}Job was not loaded{{NORMAL}}"
    fi

# reload the launchd job (after plist changes)
[group('launchd')]
launchd-reload:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check-macos
    echo "{{BLUE}}Reloading {{SERVICE_NAME}}...{{NORMAL}}"

    if launchctl list | grep -q "{{SERVICE_NAME}}"; then
        launchctl bootout gui/"$(id -u)" "{{PLIST_DEST}}"
        echo "{{GREEN}}Unloaded old version{{NORMAL}}"
    fi

    just _copy-plist

    echo "{{GREEN}}Copied updated plist{{NORMAL}}"

    launchctl bootstrap gui/"$(id -u)" "{{PLIST_DEST}}"
    echo "{{GREEN}}Loaded new version{{NORMAL}}"

# build the launchd binary from Go source
[group('launchd')]
launchd-build:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check-macos
    echo "{{BLUE}}Building {{LAUNCHD_BIN}}...{{NORMAL}}"
    go build -o "{{LAUNCHD_BIN}}" "{{LAUNCHD_GO_SOURCE}}"
    echo "{{GREEN}}Built {{LAUNCHD_BIN}}{{NORMAL}}"

# run the cleanup script manually
[group('launchd')]
launchd-run: launchd-build
    {{LAUNCHD_BIN}}

# view the launchd logs
[group('launchd')]
launchd-logs:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check-macos
    echo "{{BLUE}}Recent log entries:{{NORMAL}}"
    echo ""

    LOG_FILE="$HOME/Library/Logs/daily-desktop-cleanup.log"
    ERR_FILE="$HOME/Library/Logs/daily-desktop-cleanup.err"

    if [[ -f "$LOG_FILE" ]]; then
        echo "{{MAGENTA}}=== Standard Output ==={{NORMAL}}"
        tail -20 "$LOG_FILE"
        echo ""
    fi

    if [[ -f "$ERR_FILE" ]]; then
        if [[ -s "$ERR_FILE" ]]; then
            echo "{{RED}}=== Errors ==={{NORMAL}}"
            tail -20 "$ERR_FILE"
            echo ""
        else
            echo "{{GREEN}}No errors logged{{NORMAL}}"
        fi
    fi

# validate the plist file syntax (validates template, not installed copy)
[group('launchd')]
launchd-validate:
    #!/usr/bin/env bash
    set -euo pipefail

    just _check-macos
    echo "{{BLUE}}Validating plist syntax...{{NORMAL}}"

    if plutil -lint "{{PLIST_SOURCE}}"; then
        echo "{{GREEN}}Plist syntax is valid{{NORMAL}}"
    else
        echo "{{RED}}Plist has syntax errors{{NORMAL}}" >&2
        exit 1
    fi

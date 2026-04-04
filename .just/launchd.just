# launchd management recipes
#
# Note: Uses color variables (BLUE, GREEN, RED, etc.) defined in the main justfile.
# This module requires those constants to be available.

PLIST_NAME := "net.chicks.daily-desktop-cleanup.plist"
PLIST_SOURCE := "launchd" / PLIST_NAME
PLIST_DEST := env_var_or_default("HOME", "") / "Library/LaunchAgents" / PLIST_NAME
SERVICE_NAME := "net.chicks.daily-desktop-cleanup"

# install the launchd plist file
[group('launchd')]
launchd-install:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "{{BLUE}}Installing launchd plist...{{NORMAL}}"

    if [[ ! -f "{{PLIST_SOURCE}}" ]]; then
        echo "{{RED}}Error: {{PLIST_SOURCE}} not found{{NORMAL}}" >&2
        exit 1
    fi

    # get repository root directory
    REPO_ROOT="$(pwd)"

    # create LaunchAgents directory if needed
    mkdir -p ~/Library/LaunchAgents

    # copy plist and substitute hardcoded paths
    sed -e "s|/Users/chicks/Documents/git/chicks-home|${REPO_ROOT}|g" \
        "{{PLIST_SOURCE}}" > "{{PLIST_DEST}}"

    echo "{{GREEN}}Copied {{PLIST_SOURCE}} to {{PLIST_DEST}}{{NORMAL}}"
    echo "{{BLUE}}Updated paths for: ${REPO_ROOT}{{NORMAL}}"

    # load the job
    launchctl load "{{PLIST_DEST}}"

    echo "{{GREEN}}Loaded {{SERVICE_NAME}}{{NORMAL}}"
    echo ""
    echo "{{MAGENTA}}Verify with: just launchd-status{{NORMAL}}"

# check launchd job status
[group('launchd')]
launchd-status:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "{{BLUE}}Checking launchd status for {{SERVICE_NAME}}...{{NORMAL}}"

    # check if loaded
    if launchctl list | grep -q "{{SERVICE_NAME}}"; then
        echo "{{GREEN}}Job is loaded{{NORMAL}}"
        echo ""
        launchctl list | grep "{{SERVICE_NAME}}" || true
        echo ""
        echo "{{MAGENTA}}Last 10 lines from log:{{NORMAL}}"
        if [[ -f launchd/daily-desktop-cleanup.log ]]; then
            tail -10 launchd/daily-desktop-cleanup.log
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

    echo "{{BLUE}}Unloading {{SERVICE_NAME}}...{{NORMAL}}"

    if launchctl list | grep -q "{{SERVICE_NAME}}"; then
        launchctl unload "{{PLIST_DEST}}"
        echo "{{GREEN}}Unloaded {{SERVICE_NAME}}{{NORMAL}}"
    else
        echo "{{YELLOW}}Job was not loaded{{NORMAL}}"
    fi

# reload the launchd job (after plist changes)
[group('launchd')]
launchd-reload:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "{{BLUE}}Reloading {{SERVICE_NAME}}...{{NORMAL}}"

    # get repository root directory
    REPO_ROOT="$(pwd)"

    # unload if loaded
    if launchctl list | grep -q "{{SERVICE_NAME}}"; then
        launchctl unload "{{PLIST_DEST}}"
        echo "{{GREEN}}Unloaded old version{{NORMAL}}"
    fi

    # copy updated plist and substitute hardcoded paths
    sed -e "s|/Users/chicks/Documents/git/chicks-home|${REPO_ROOT}|g" \
        "{{PLIST_SOURCE}}" > "{{PLIST_DEST}}"
    echo "{{GREEN}}Copied updated plist{{NORMAL}}"
    echo "{{BLUE}}Updated paths for: ${REPO_ROOT}{{NORMAL}}"

    # load
    launchctl load "{{PLIST_DEST}}"
    echo "{{GREEN}}Loaded new version{{NORMAL}}"

# run the cleanup script manually
[group('launchd')]
launchd-run:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "{{BLUE}}Running desktop cleanup manually...{{NORMAL}}"
    bin/daily_desktop_cleanup

# view the launchd logs
[group('launchd')]
launchd-logs:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "{{BLUE}}Recent log entries:{{NORMAL}}"
    echo ""

    if [[ -f launchd/daily-desktop-cleanup.log ]]; then
        echo "{{MAGENTA}}=== Standard Output ==={{NORMAL}}"
        tail -20 launchd/daily-desktop-cleanup.log
        echo ""
    fi

    if [[ -f launchd/daily-desktop-cleanup.err ]]; then
        if [[ -s launchd/daily-desktop-cleanup.err ]]; then
            echo "{{RED}}=== Errors ==={{NORMAL}}"
            tail -20 launchd/daily-desktop-cleanup.err
            echo ""
        else
            echo "{{GREEN}}No errors logged{{NORMAL}}"
        fi
    fi

# validate the plist file syntax
[group('launchd')]
launchd-validate:
    #!/usr/bin/env bash
    set -euo pipefail

    echo "{{BLUE}}Validating plist syntax...{{NORMAL}}"

    if plutil -lint "{{PLIST_SOURCE}}"; then
        echo "{{GREEN}}Plist syntax is valid{{NORMAL}}"
    else
        echo "{{RED}}Plist has syntax errors{{NORMAL}}" >&2
        exit 1
    fi

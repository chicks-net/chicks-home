# project justfile

# some useful variables
host := `uname -n`
release_branch := "master"

# thanks to https://stackoverflow.com/a/7293026/2002471 for the perfect git incantation
last_commit_message := `git log -1 --pretty=%B | grep '.'`

# list recipes (default works without naming it)
[group('example')]
list:
	just --list
	@echo "{{GREEN}}Your justfile is waiting for more scripts and snippets{{NORMAL}}"

# escape from branch, back to starting point
[group('Process')]
sync:
    git checkout {{ release_branch }}
    git pull
    git stp

# PR create 3.0
[group('Process')]
pr: _on_a_branch
    #!/usr/bin/env bash
    set -euxo pipefail # strict mode

    git stp
    git pushup

    set +x # leave tracing off...

    bodyfile=$(mktemp /tmp/justfile.XXXXXX)

    echo "## Done:" >> $bodyfile
    echo "" >> $bodyfile
    echo "- {{ last_commit_message }}" >> $bodyfile
    echo "" >> $bodyfile
    echo "" >> $bodyfile
    echo "(Automated in \`justfile\`.)" >> $bodyfile

    echo ''
    cat "$bodyfile"
    echo ''

    gh pr create --title "{{ last_commit_message }}" --body-file "$bodyfile"
    rm "$bodyfile"

    just watch_checks

# watch PR checks
[group('Process')]
watch_checks: _on_a_branch
    #!/usr/bin/env bash
    set -euo pipefail # strict mode

    if [[ ! -e ".github/workflows" ]]; then
        echo "{{BLUE}}there are no workflows in this repo so there are no PR checks to watch{{NORMAL}}"
        exit 0
    fi

    echo "{{BLUE}}sleeping for 10s because github is lazy with their API{{NORMAL}}"
    sleep 10
    gh pr checks --watch

# merge PR and return to starting point
[group('Process')]
merge: _on_a_branch
    gh pr merge -s -d
    just sync # mostly redundant, but just in case

# start a new branch
[group('Process')]
branch branchname: _main_branch
    #!/usr/bin/env bash
    NOW=`just utcdate`
    git co -b "chicks/$NOW-{{ branchname }}"

# view PR in web browser
[group('Process')]
prweb: _on_a_branch
    gh pr view --web

# error if not on a git branch
[group('sanity check')]
[no-cd]
_on_a_branch:
    #!/bin/bash

    # thanks to https://stackoverflow.com/a/12142066/2002471

    if [[ $(git rev-parse --abbrev-ref HEAD) == "{{ release_branch }}" ]]; then
      echo "{{RED}}You are on branch '{{ release_branch }}' (the release branch) so you are not ready to start a PR.{{NORMAL}}"
      exit 100
    fi

# error if not on the release branch
[group('sanity check')]
[no-cd]
_main_branch:
    #!/bin/bash

    # thanks to https://stackoverflow.com/a/12142066/2002471

    if [[ ! $(git rev-parse --abbrev-ref HEAD) == "{{ release_branch }}" ]]; then
      echo "You are on a branch that is not the release branch so you are not ready to start a new branch."
      exit 100
    fi

# print UTC date in ISO format
[group('Utility')]
[no-cd]
@utcdate:
    TZ=UTC date +"%Y-%m-%d"

# our own compliance check
[group('Compliance')]
compliance_check:
    #!/usr/bin/env bash
    set -euo pipefail # strict mode without tracing

    echo "{{BLUE}}Chicks' repo compliance check...{{NORMAL}}"

    if [[ -e README.md ]]; then
        echo "{{GREEN}}You have a README.md, thank you.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a README.md, hmmmm, why is this repo here?{{NORMAL}}"
    fi

    if [[ -e LICENSE ]]; then
        echo "{{GREEN}}[gh] You have a license, good for you.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a license, are you feeling ok?{{NORMAL}}"
    fi

    if [[ -e .github/CODE_OF_CONDUCT.md ]]; then
        echo "{{GREEN}}[gh] You have a Code of Conduct, respect.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a Code of Conduct.  So anything goes around here?{{NORMAL}}"
    fi

    if [[ -e .github/CONTRIBUTING.md ]]; then
        echo "{{GREEN}}[gh] You have a Contributing Guide, how giving.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a Contributing Guide.  Hopefully they'll figure it out on their own.{{NORMAL}}"
    fi

    if [[ -e .github/SECURITY.md ]]; then
        echo "{{GREEN}}[gh] You have a Security Guide, very comforting.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a Security Guide.  Don't call the cops.{{NORMAL}}"
    fi

    if [[ -e .github/pull_request_template.md ]]; then
        echo "{{GREEN}}[gh] You have a pull request template, not too pushy.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a pull request template.  Prepare for anything.{{NORMAL}}"
    fi

    if [[ -d .github/ISSUE_TEMPLATE ]]; then
        echo "{{GREEN}}[gh] You have Issue Templates, life is good.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have Issue Templates.  I must take issue with that.{{NORMAL}}"
    fi

    if [[ $(gh repo view --json description | jq -r '.description' | wc -c) -gt 16 ]]; then
        echo "{{GREEN}}[gh] You have a repo description, more evidence that you are undescribable.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a repo description, can you write a word or two please?{{NORMAL}}"
    fi

    # github also checks for something about the repo admins

    if [[ -e .github/CODEOWNERS ]]; then
        echo "{{GREEN}}You have a CODEOWNERS file, in DEED.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a CODEOWNERS file.  Does anyone want to make a claim?{{NORMAL}}"
    fi

    if [[ -e .gitignore ]]; then
        echo "{{GREEN}}You have a .gitignore file, so there will be less debris in your future.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a .gitignore file.  I expect you to keep ignoring my advice!{{NORMAL}}"
    fi

    if [[ -e .gitattributes ]]; then
        echo "{{GREEN}}You have a .gitattributes file, keeping metadata and line endings clean too.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a .gitattributes file.  Did you hear what happens when binaries and text files get together?{{NORMAL}}"
    fi

    if [[ -e justfile ]]; then
        echo "{{GREEN}}You have a {{BLUE}}justfile{{GREEN}}, spreading justice and automation a little further.{{NORMAL}}"
    else
        echo "{{RED}}You do NOT have a justfile.  Feeling the FOMO yet?{{NORMAL}}"
        echo "{{RED}}And this should not be possible.  Tell me how you got here.{{NORMAL}}"
    fi

# make a release
[group('Process')]
release rel_version:
   gh release create {{rel_version}} --generate-notes

# thanks to https://apple.stackexchange.com/a/230447/210526
# merge PDFs
[no-cd, macos]
[group('Utility')]
mergepdf dest_file *src_files:
	"/System/Library/Automator/Combine PDF Pages.action/Contents/MacOS/join" -o {{dest_file}} {{src_files}}


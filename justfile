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

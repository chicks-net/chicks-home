# project justfile

import? '.just/compliance.just'
import? '.just/gh-process.just'
import? '.just/shellcheck.just'

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

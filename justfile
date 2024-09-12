# list recipes
default:
	just --list

# thanks to https://apple.stackexchange.com/a/230447/210526
# merge PDFs
[no-cd, macos]
mergepdf dest_file *src_files:
	"/System/Library/Automator/Combine PDF Pages.action/Contents/MacOS/join" -o {{dest_file}} {{src_files}}

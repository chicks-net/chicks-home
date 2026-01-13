#!/usr/bin/env bash

if [ "$#" -eq 0 ]; then
	echo "Usage: $0 <pattern>" >&2
	exit 1
fi

find . -name "*.lbx" -print0 | while IFS= read -r -d '' file; do
	if zipgrep "$1" "$file" > /dev/null; then
		echo "=== $file contains $1 ==="
	fi
done

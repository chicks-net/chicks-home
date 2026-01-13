#!/usr/bin/env bash

find . -name "*.lbx" -print0 | while IFS= read -r -d '' file; do
	if zipgrep "$1" "$file" > /dev/null; then
		echo "=== $file contains $1 ==="
	fi
done

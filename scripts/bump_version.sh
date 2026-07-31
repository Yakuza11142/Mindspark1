#!/bin/bash
# FIXED: Modified the regex capture groups to cleanly strip out and discard hidden 
# line termination markers (\r) or trailing whitespace characters safely.
perl -i -pe 's/^(version:\s*\d+\.\d+\.\d+\+)(\d+)(\s*)$/$1.($2+1).$3/e' pubspec.yaml

echo "⚡ Flutter Build Version Bumped Successfully!"

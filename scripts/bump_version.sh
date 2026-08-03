#!/bin/bash
set -e # Terminate script immediately if a command returns a non-zero exit status

TARGET_FILE="pubspec.yaml"

# Verification Guard: Ensure the pubspec file actually exists in the local workspace directory
if [ ! -f "$TARGET_FILE" ]; then
    echo "❌ Error: Could not find target file: $TARGET_FILE" >&2
    exit 1
fi

# Verification Guard: Verify the target file contains a valid version block structure to update
if ! grep -q "^version:" "$TARGET_FILE"; then
    echo "❌ Error: No 'version:' tag found in $TARGET_FILE. Cannot increment build number." >&2
    exit 1
fi

# FIXED: Strip carriage returns and safely parse, match, and preserve inline comments
# Handles \r\n (Windows) and \n (Linux/macOS) lines identically without corrupting strings
perl -i -pe '
  s/\r//g; # Clean out carriage returns safely before evaluating matching tracking strings
  if (/^(version:\s*\d+\.\d+\.\d+\+)(\d+)(.*)$/) {
      $prefix = $1;
      $build_num = $2 + 1;
      $trailing = $3;
      $_ = "$prefix$build_num$trailing\n";
  }
' "$TARGET_FILE"

# FIXED: Read raw line layout, clear space characters, and safely strip trailing comments or \r strings
NEW_VERSION=$(grep "^version:" "$TARGET_FILE" | sed -e 's/\r//g' -e 's/#.*//' | xargs)

echo "⚡ Flutter Build Version Bumped Successfully!"
echo "📈 New Configuration Line -> $NEW_VERSION"

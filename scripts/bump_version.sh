#!/bin/bash
# Run this before building to update pubspec.yaml
perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' pubspec.yaml
echo "Version Bumped!"
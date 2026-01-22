#!/bin/bash

# Script to increment the build number in pubspec.yaml
# Version format: major.minor.patch+build (e.g., 1.0.5+9)

set -e  # Exit on error

PUBSPEC_FILE="pubspec.yaml"

# Check if pubspec.yaml exists
if [ ! -f "$PUBSPEC_FILE" ]; then
    echo "Error: $PUBSPEC_FILE not found!"
    exit 1
fi

# Extract current version line
VERSION_LINE=$(grep "^version:" "$PUBSPEC_FILE")
echo "Current version line: $VERSION_LINE"

# Extract version and build number
CURRENT_VERSION=$(echo "$VERSION_LINE" | sed 's/version: *//' | sed 's/ *$//')
echo "Current version: $CURRENT_VERSION"

# Split into version name and build number
VERSION_NAME=$(echo "$CURRENT_VERSION" | cut -d'+' -f1)
BUILD_NUMBER=$(echo "$CURRENT_VERSION" | cut -d'+' -f2)

echo "Version name: $VERSION_NAME"
echo "Current build number: $BUILD_NUMBER"

# Increment build number
NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))
NEW_VERSION="${VERSION_NAME}+${NEW_BUILD_NUMBER}"

echo "New version: $NEW_VERSION"

# Update pubspec.yaml
sed -i.bak "s/^version: .*/version: $NEW_VERSION/" "$PUBSPEC_FILE"
rm "${PUBSPEC_FILE}.bak"

echo "✅ Version updated successfully!"

# Output for GitHub Actions (only if GITHUB_OUTPUT is set)
if [ -n "$GITHUB_OUTPUT" ]; then
    echo "version=$NEW_VERSION" >> $GITHUB_OUTPUT
    echo "build_number=$NEW_BUILD_NUMBER" >> $GITHUB_OUTPUT
    echo "version_name=$VERSION_NAME" >> $GITHUB_OUTPUT
fi

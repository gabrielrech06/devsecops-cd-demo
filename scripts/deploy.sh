#!/usr/bin/env bash

set -euo pipefail

SHA="${1:-}"

if [[ ! "$SHA" =~ ^[0-9a-f]{40}$ ]]; then
    echo "ERROR: invalid commit SHA: $SHA"
    exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SITE_ROOT="/srv/cd-demo/site"
RELEASES_DIR="$SITE_ROOT/releases"
RELEASE_DIR="$RELEASES_DIR/$SHA"
TMP_RELEASE="$RELEASES_DIR/.${SHA}.tmp"
TMP_LINK="$SITE_ROOT/.current-$SHA"

echo "Deploying commit: $SHA"

mkdir -p "$RELEASES_DIR"

if [[ ! -d "$RELEASE_DIR" ]]; then
    rm -rf "$TMP_RELEASE"

    mkdir "$TMP_RELEASE"

    cp -a "$REPO_ROOT/site/." "$TMP_RELEASE/"

    printf '%s\n' "$SHA" > "$TMP_RELEASE/commit.txt"

    mv "$TMP_RELEASE" "$RELEASE_DIR"
else
    echo "Release already exists; reusing it."
fi

rm -f "$TMP_LINK"

ln -s "releases/$SHA" "$TMP_LINK"

mv -Tf "$TMP_LINK" "$SITE_ROOT/current"

echo "Deploy completed."
echo "Current release: $SHA"

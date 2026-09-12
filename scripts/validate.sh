#!/usr/bin/env bash

set -euo pipefail

echo "Validating application..."

required_files=(
    "site/index.html"
    "site/style.css"
    "site/version.txt"
)

for file in "${required_files[@]}"; do
    if [[ ! -f "$file" ]]; then
        echo "ERROR: required file missing: $file"
        exit 1
    fi
done

version="$(tr -d '\r\n' < site/version.txt)"

if [[ ! "$version" =~ ^v[0-9]+$ ]]; then
    echo "ERROR: invalid version format: $version"
    exit 1
fi

if ! grep -Fq "$version" site/index.html; then
    echo "ERROR: version.txt ($version) does not match index.html"
    exit 1
fi

if ! grep -Fq 'style.css' site/index.html; then
    echo "ERROR: stylesheet is not referenced by index.html"
    exit 1
fi

echo "Validation successful."
echo "Version: $version"

#!/usr/bin/env bash
# Usage: update_package_swift.sh <version> <cs_razorpay> <cs_core> <cs_standard> <cs_custom>
set -euo pipefail

VERSION="$1"
CS_RAZORPAY="$2"
CS_CORE="$3"
CS_STANDARD="$4"
CS_CUSTOM="$5"

# Update version variables (handles both 1-space and 2-space variants)
sed -i '' -E "s/^(let binaryVersion[[:space:]]*=[[:space:]]*)\".+\"/\1\"${VERSION}\"/" Package.swift
sed -i '' -E "s/^(let packageVersion[[:space:]]*=[[:space:]]*)\".+\"/\1\"${VERSION}\"/" Package.swift

# Update each binary target's checksum (multiline match, mirrors Python re.DOTALL behaviour).
# Variables are passed via the environment so the Perl script can be single-quoted,
# avoiding any ambiguity between shell and Perl special characters.
update_checksum() {
    local target="$1"
    local checksum="$2"
    TARGET="$target" CHECKSUM="$checksum" perl -i -0pe \
        's|(name:\s*"$ENV{TARGET}".*?checksum:\s*")[^"]*(")|$1$ENV{CHECKSUM}$2|s' \
        Package.swift
}

update_checksum "RazorpayBinary"   "$CS_RAZORPAY"
update_checksum "RazorpayCore"     "$CS_CORE"
update_checksum "RazorpayStandard" "$CS_STANDARD"
update_checksum "RazorpayCustom"   "$CS_CUSTOM"

echo "Package.swift updated successfully."

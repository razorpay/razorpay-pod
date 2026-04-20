#!/bin/bash

# ─────────────────────────────────────────────────────────────
# update_spm_checksums.sh
#
# Reads binaryVersion from Package.swift, downloads the four
# XCFramework zips from the razorpay-pod release,
# computes their SHA-256 checksums, and updates Package.swift.
#
# Usage:
#   ./.github/scripts/update_spm_checksums.sh
# ─────────────────────────────────────────────────────────────

set -euo pipefail

PACKAGE_SWIFT="Package.swift"
REPO="razorpay/razorpay-pod"

# ── Read binaryVersion from Package.swift ─────────────────────

VERSION=$(grep '^let binaryVersion' "$PACKAGE_SWIFT" | sed 's/.*"\(.*\)".*/\1/')

if [ -z "$VERSION" ]; then
    echo "❌ Could not extract binaryVersion from ${PACKAGE_SWIFT}"
    exit 1
fi

echo "🔖 binaryVersion: ${VERSION}"

BASE_URL="https://github.com/${REPO}/releases/download/${VERSION}"

# ── Framework name → SPM target name ─────────────────────────

FRAMEWORK_NAMES=("Razorpay"         "RazorpayCore" "RazorpayStandard" "RazorpayCustom")
FRAMEWORK_TARGETS=("RazorpayBinary" "RazorpayCore" "RazorpayStandard" "RazorpayCustom")

# ── Helpers ───────────────────────────────────────────────────

compute_checksum() {
    local file=$1
    if command -v swift &>/dev/null; then
        swift package compute-checksum "$file"
    elif command -v shasum &>/dev/null; then
        shasum -a 256 "$file" | awk '{print $1}'
    else
        sha256sum "$file" | awk '{print $1}'
    fi
}

update_checksum() {
    local target_name=$1
    local checksum=$2
    sed -i.bak -E \
        "/name: \"${target_name}\"/{
            n
            n
            s|checksum: \".*\"|checksum: \"${checksum}\"|
        }" "$PACKAGE_SWIFT"
    rm -f "${PACKAGE_SWIFT}.bak"
}

# ── Step 1: Download and checksum ────────────────────────────

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "⬇️  Downloading XCFramework zips for v${VERSION}..."

CHECKSUMS=()
for i in "${!FRAMEWORK_NAMES[@]}"; do
    name="${FRAMEWORK_NAMES[$i]}"
    zip_name="${name}.xcframework.zip"
    url="${BASE_URL}/${zip_name}"
    dest="${TMPDIR}/${zip_name}"

    echo "  → ${url}"
    if ! curl -fsSL "$url" -o "$dest"; then
        echo "❌ Failed to download: ${url}"
        exit 1
    fi

    CHECKSUMS[$i]=$(compute_checksum "$dest")
    echo "  ✅ ${name}: ${CHECKSUMS[$i]}"
done

# ── Step 2: Update checksums in Package.swift ─────────────────

echo ""
echo "📝 Updating Package.swift..."

for i in "${!FRAMEWORK_TARGETS[@]}"; do
    update_checksum "${FRAMEWORK_TARGETS[$i]}" "${CHECKSUMS[$i]}"
done

# ── Summary ───────────────────────────────────────────────────

echo ""
echo "✅ Package.swift updated for v${VERSION}"
echo ""
echo "── Summary ──────────────────────────────────────────────"
for i in "${!FRAMEWORK_NAMES[@]}"; do
    printf "  %-20s %s\n" "${FRAMEWORK_NAMES[$i]}:" "${CHECKSUMS[$i]}"
done
echo "─────────────────────────────────────────────────────────"

#!/bin/bash

# ─────────────────────────────────────────────────────────────
# update_spm_checksums.sh
#
# Reads binaryVersion from Package.swift, zips all four
# XCFrameworks from the local Pod/ directory, computes their
# SHA-256 checksums, and updates Package.swift.
#
# Usage:
#   ./.github/scripts/update_spm_checksums.sh
# ─────────────────────────────────────────────────────────────

set -euo pipefail

PACKAGE_SWIFT="Package.swift"

# ── Read binaryVersion from Package.swift ─────────────────────

VERSION=$(grep '^let binaryVersion' "$PACKAGE_SWIFT" | sed 's/.*"\(.*\)".*/\1/')

if [ -z "$VERSION" ]; then
    echo "❌ Could not extract binaryVersion from ${PACKAGE_SWIFT}"
    exit 1
fi

echo "🔖 binaryVersion: ${VERSION}"

# ── Framework name → local xcframework path ───────────────────
FRAMEWORK_NAMES=("Razorpay"         "RazorpayCore"                     "RazorpayStandard"               "RazorpayCustom")
FRAMEWORK_PATHS=("Pod/core/Razorpay.xcframework" "Pod/core/RazorpayCore.xcframework" "Pod/RazorpayStandard.xcframework" "Pod/RazorpayCustom.xcframework")
FRAMEWORK_TARGETS=("RazorpayBinary" "RazorpayCore"                     "RazorpayStandard"               "RazorpayCustom")

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

# ── Step 1: Zip and checksum ──────────────────────────────────

echo "📦 Zipping XCFrameworks..."

CHECKSUMS=()
for i in "${!FRAMEWORK_NAMES[@]}"; do
    name="${FRAMEWORK_NAMES[$i]}"
    xcf_path="${FRAMEWORK_PATHS[$i]}"
    zip_path="${xcf_path%.xcframework}.xcframework.zip"

    if [ ! -d "$xcf_path" ]; then
        echo "❌ Not found: ${xcf_path}"
        exit 1
    fi

    rm -f "$zip_path"

    if command -v ditto &>/dev/null; then
        ditto -c -k --sequesterRsrc --keepParent "$xcf_path" "$zip_path"
    else
        (cd "$(dirname "$xcf_path")" && zip -r -y "$(basename "$zip_path")" "$(basename "$xcf_path")")
    fi

    CHECKSUMS[$i]=$(compute_checksum "$zip_path")
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

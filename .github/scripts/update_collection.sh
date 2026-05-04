#!/usr/bin/env bash
# Usage: update_collection.sh <version>
#
# Prepends a new version entry to collection.json for the given version.
# Idempotent: skips if the version is already present.
set -euo pipefail

if [ $# -ne 1 ]; then
    echo "Usage: update_collection.sh <version>"
    exit 1
fi

VERSION="$1"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COLLECTION_PATH="$(cd "${SCRIPT_DIR}/../.." && pwd)/collection.json"

# Idempotency check — skip if version already exists
if jq -e --arg v "$VERSION" '.packages[0].versions[] | select(.version == $v)' "$COLLECTION_PATH" > /dev/null 2>&1; then
    echo "Version $VERSION already in collection.json — skipping."
    exit 0
fi

GENERATED_AT="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

NEW_ENTRY="$(jq -n --arg version "$VERSION" '{
  "defaultToolsVersion": "5.9",
  "manifests": {
    "5.9": {
      "minimumPlatformVersions": [{"name": "ios", "version": "13.0"}],
      "packageName": "Razorpay",
      "products": [
        {"name": "RazorpayCheckout", "targets": ["RazorpayCheckout"], "type": {"library": ["automatic"]}},
        {"name": "RazorpayCustomUI",  "targets": ["RazorpayCustomUI"],  "type": {"library": ["automatic"]}}
      ],
      "targets": [
        {"moduleName": "RazorpayCheckout", "name": "RazorpayCheckout"},
        {"moduleName": "RazorpayCustomUI",  "name": "RazorpayCustomUI"}
      ],
      "toolsVersion": "5.9"
    }
  },
  "version": $version
}')"

# Update collection.json: set generatedAt and prepend the new version entry.
# --sort-keys mirrors Python json.dump(sort_keys=True).
jq --sort-keys \
   --arg generatedAt "$GENERATED_AT" \
   --argjson newEntry "$NEW_ENTRY" \
   '.generatedAt = $generatedAt | .packages[0].versions = [$newEntry] + .packages[0].versions' \
   "$COLLECTION_PATH" > "${COLLECTION_PATH}.tmp" && mv "${COLLECTION_PATH}.tmp" "$COLLECTION_PATH"

echo "Added version $VERSION to collection.json."
echo "Versions now: $(jq -r '[.packages[0].versions[].version] | join(", ")' "$COLLECTION_PATH")"

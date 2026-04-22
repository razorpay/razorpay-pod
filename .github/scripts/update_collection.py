#!/usr/bin/env python3
"""
update_collection.py <version>

Prepends a new version entry to collection.json for the given version.
Idempotent: skips if the version is already present.
"""

import json
import sys
import os

def main():
    if len(sys.argv) != 2:
        print("Usage: update_collection.py <version>")
        sys.exit(1)

    version = sys.argv[1]
    collection_path = os.path.join(os.path.dirname(__file__), "../../collection.json")
    collection_path = os.path.normpath(collection_path)

    with open(collection_path) as f:
        col = json.load(f)

    versions = col["packages"][0]["versions"]

    # Idempotency check — skip if version already exists
    existing = [v["version"] for v in versions]
    if version in existing:
        print(f"Version {version} already in collection.json — skipping.")
        return

    new_entry = {
        "defaultToolsVersion": "5.9",
        "manifests": {
            "5.9": {
                "minimumPlatformVersions": [
                    {"name": "ios", "version": "13.0"}
                ],
                "packageName": "Razorpay",
                "products": [
                    {
                        "name": "RazorpayCheckout",
                        "targets": ["RazorpayCheckout"],
                        "type": {"library": ["automatic"]}
                    },
                    {
                        "name": "RazorpayCustomUI",
                        "targets": ["RazorpayCustomUI"],
                        "type": {"library": ["automatic"]}
                    }
                ],
                "targets": [
                    {"moduleName": "RazorpayCheckout", "name": "RazorpayCheckout"},
                    {"moduleName": "RazorpayCustomUI",  "name": "RazorpayCustomUI"}
                ],
                "toolsVersion": "5.9"
            }
        },
        "version": version
    }

    versions.insert(0, new_entry)

    with open(collection_path, "w") as f:
        json.dump(col, f, indent=2, sort_keys=True)
        f.write("\n")

    print(f"Added version {version} to collection.json.")
    print(f"Versions now: {[v['version'] for v in versions]}")

if __name__ == "__main__":
    main()

#!/usr/bin/env python3
import sys
import re


def main():
    version        = sys.argv[1]
    cs_razorpay    = sys.argv[2]
    cs_core        = sys.argv[3]
    cs_standard    = sys.argv[4]
    cs_custom      = sys.argv[5]

    checksums = {
        "RazorpayBinary":   cs_razorpay,
        "RazorpayCore":     cs_core,
        "RazorpayStandard": cs_standard,
        "RazorpayCustom":   cs_custom,
    }

    with open("Package.swift") as f:
        content = f.read()

    # Update version variables (handles both 1-space and 2-space variants)
    content = re.sub(
        r'^(let binaryVersion\s*=\s*)"[^"]*"',
        lambda m: m.group(1) + f'"{version}"',
        content,
        flags=re.MULTILINE,
    )
    content = re.sub(
        r'^(let packageVersion\s*=\s*)"[^"]*"',
        lambda m: m.group(1) + f'"{version}"',
        content,
        flags=re.MULTILINE,
    )

    # Update each binary target's checksum
    for target, checksum in checksums.items():
        pattern = r'(name:\s*"' + re.escape(target) + r'".*?checksum:\s*")[^"]*(")'
        replacement = r'\g<1>' + checksum + r'\2'
        content = re.sub(pattern, replacement, content, flags=re.DOTALL)

    with open("Package.swift", "w") as f:
        f.write(content)

    print("Package.swift updated successfully.")


if __name__ == "__main__":
    main()

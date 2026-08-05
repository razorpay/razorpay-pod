#!/usr/bin/env bash
# stamp-package-swift.sh

set -euo pipefail

VERSION="${1:?usage: $0 <version> <changed-checksums.json> [Package.swift]}"
CHANGED="${2:?missing changed-checksums.json}"
MANIFEST="${3:-Package.swift}"

[ -f "$MANIFEST" ] || { echo "❌ manifest not found: $MANIFEST"; exit 1; }
[ -f "$CHANGED" ]  || { echo "❌ changed checksums not found: $CHANGED"; exit 1; }
command -v jq >/dev/null || { echo "❌ jq required"; exit 1; }

NAMES=$(jq -r 'keys[]' "$CHANGED")
[ -n "$NAMES" ] || { echo "❌ changed-checksums.json is empty — nothing to stamp"; exit 1; }

for name in $NAMES; do
  case "$name" in
    Razorpay|RazorpayCore|RazorpayStandard|RazorpayCustom) : ;;
    *) echo "❌ unknown xcframework name: $name"; exit 1 ;;
  esac

  sha="$(jq -r --arg k "$name" '.[$k]' "$CHANGED")"
  case "$sha" in
    [0-9a-f]*) [ "${#sha}" -eq 64 ] || { echo "❌ $name sha256 not 64 hex chars: $sha"; exit 1; } ;;
    *) echo "❌ $name checksum not lowercase hex: $sha"; exit 1 ;;
  esac

  python3 - "$MANIFEST" "$name" "$VERSION" "$sha" <<'PY'
import io, re, sys
path, name, version, sha = sys.argv[1:5]
with io.open(path, encoding="utf-8") as f:
    s = f.read()
n = re.escape(name)
url = 'https://github.com/razorpay/razorpay-pod/releases/download/%s/%s.xcframework.zip' % (version, name)

# A binaryTarget for this name can be in one of two shapes. We normalise both to
# the stamped remote form:  name: "<name>", url: "<url>", checksum: "<sha>"
#
# (A) Already remote — real values or REL_*/CKSUM_* placeholders:
#       name: "<name>", url: ".../download/<TAG>/<name>.xcframework.zip", checksum: "<X>"
#     → rewrite the tag segment and the checksum.
#
# (B) Local path form:
#       name: "<name>", path: "Pod/.../<name>.xcframework"
#     → replace the `path: "..."` with `url: "<url>", checksum: "<sha>"`,
#       preserving the indentation of the original path line.
remote_pat = re.compile(
    r'(name:\s*"' + n + r'",\s*url:\s*"https://github\.com/razorpay/razorpay-pod/releases/download/)'
    r'[^/"]*'
    r'(/' + n + r'\.xcframework\.zip",\s*checksum:\s*)"[^"]*"'
)
local_pat = re.compile(
    r'(name:\s*"' + n + r'",)'
    r'(?P<pre>\s*?)(?P<indent>[ \t]*)path:\s*"[^"]*' + n + r'\.xcframework"'
)

new, count = remote_pat.subn(r'\g<1>%s\g<2>"%s"' % (version, sha), s)
if count == 1:
    mode = "remote (rewrote tag + checksum)"
else:
    def repl(m):
        # `pre` is the whitespace/newline separating name: from path:;
        # `indent` is the leading indent of the path: line, reused for checksum:.
        pre, indent = m.group('pre'), m.group('indent')
        return '%s%s%surl: "%s",\n%schecksum: "%s"' % (
            m.group(1), pre, indent, url, indent, sha)
    new, count = local_pat.subn(repl, s)
    mode = "local path → url + checksum"

if count != 1:
    sys.stderr.write(
        "❌ expected exactly one binaryTarget for \"%s\" (remote or path form), found %d\n"
        % (name, count))
    sys.exit(1)

with io.open(path, "w", encoding="utf-8") as f:
    f.write(new)
sys.stderr.write("   %s: %s\n" % (name, mode))
PY
  echo "✅ ${name}  release=${VERSION}  checksum=${sha}"
done

# No placeholder may survive anywhere — an unseeded binary can't ship.
LEFTOVER=$(grep -nE 'REL_(WRAPPER|CORE|STANDARD|CUSTOM)|CKSUM_(WRAPPER|CORE|STANDARD|CUSTOM)' "$MANIFEST" || true)
if [ -n "$LEFTOVER" ]; then
  echo "❌ unseeded placeholders remain (a binary was never released):"
  echo "$LEFTOVER"
  echo "   Seed Package.swift with a full (core) release first, or include the binary in the changed set."
  exit 1
fi

echo "── stamped binary URLs + checksums ──"
grep -nE 'releases/download/|checksum:' "$MANIFEST"

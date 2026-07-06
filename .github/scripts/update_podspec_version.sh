#!/usr/bin/env bash
set -euo pipefail

NEW_PODSPEC_VERSION="${1:?missing podspec version}"
PODSPEC_PATH="razorpay-pod.podspec"
RESOLVED_CORE_VERSION="${CORE_VERSION:-}"

if [ ! -f "${PODSPEC_PATH}" ]; then
  echo "❌ Podspec not found: ${PODSPEC_PATH}"
  exit 1
fi

CURRENT_VERSION=$(awk -F"'" '/^[[:space:]]*s\.version[[:space:]]*=/{print $2; exit}' "${PODSPEC_PATH}")
if [ -z "${CURRENT_VERSION}" ]; then
  echo "❌ Could not read current podspec version"
  exit 1
fi

TEMP_PODSPEC="$(mktemp)"
awk -v new_version="${NEW_PODSPEC_VERSION}" '
  /^[[:space:]]*s\.version[[:space:]]*=/ {
    sub(/\047[^'\''"]+\047/, "\047" new_version "\047")
  }
  { print }
' "${PODSPEC_PATH}" > "${TEMP_PODSPEC}"
mv "${TEMP_PODSPEC}" "${PODSPEC_PATH}"

echo "${CURRENT_VERSION}"

if [ -n "${RESOLVED_CORE_VERSION}" ]; then
  DEPENDENCY_LINE="  s.dependency 'razorpay-core-pod' , '${RESOLVED_CORE_VERSION}'"
  TEMP_PODSPEC="$(mktemp)"

  if grep -q "razorpay-core-pod" "${PODSPEC_PATH}"; then
    awk -v dependency_line="${DEPENDENCY_LINE}" '
      /^[[:space:]]*s\.dependency[[:space:]]+'\''razorpay-core-pod'\''/ {
        print dependency_line
        replaced = 1
        next
      }
      { print }
      END {
        if (!replaced) {
          exit 1
        }
      }
    ' "${PODSPEC_PATH}" > "${TEMP_PODSPEC}"
  else
    awk -v dependency_line="${DEPENDENCY_LINE}" '
      /^[[:space:]]*s\.vendored_frameworks[[:space:]]*=/ {
        print
        print dependency_line
        inserted = 1
        next
      }
      { print }
      END {
        if (!inserted) {
          exit 1
        }
      }
    ' "${PODSPEC_PATH}" > "${TEMP_PODSPEC}"
  fi

  mv "${TEMP_PODSPEC}" "${PODSPEC_PATH}"
  echo "✅ razorpay-pod configured to depend on razorpay-core-pod ${RESOLVED_CORE_VERSION}"
fi

#!/usr/bin/env bash
# Update Formula/jc-cli.rb to a jc-cli release.
#
#   scripts/update-formula.sh            # bump to the latest upstream release
#   scripts/update-formula.sh 1.27.0     # bump to a specific version
#
# Pulls the per-platform sha256 sums straight from the release's checksums.txt
# and rewrites the version + the four hashes in place. Refuses to touch the
# formula unless all four expected assets are present (guards against a
# half-published or yanked release).
set -euo pipefail

REPO="TheJumpCloud/jc-cli"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FORMULA="$ROOT/Formula/jc-cli.rb"

VERSION="${1:-$(gh api "repos/$REPO/releases/latest" --jq .tag_name)}"
CURRENT="$(awk -F'"' '/^  version /{print $2; exit}' "$FORMULA")"

if [[ "$VERSION" == "$CURRENT" ]]; then
  echo "Formula already at $VERSION; nothing to do."
  exit 0
fi

echo "Updating jc-cli: $CURRENT -> $VERSION"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
gh release download "$VERSION" -R "$REPO" -p checksums.txt -D "$TMP"

sha_for() { awk -v f="$1" '$2 == f {print $1}' "$TMP/checksums.txt"; }
darwin_arm="$(sha_for jc-darwin-arm64.tar.gz)"
darwin_amd="$(sha_for jc-darwin-amd64.tar.gz)"
linux_arm="$(sha_for jc-linux-arm64.tar.gz)"
linux_amd="$(sha_for jc-linux-amd64.tar.gz)"

for sum in "$darwin_arm" "$darwin_amd" "$linux_arm" "$linux_amd"; do
  if [[ ! "$sum" =~ ^[0-9a-f]{64}$ ]]; then
    echo "ERROR: release $VERSION is missing an expected asset checksum; aborting with no changes." >&2
    exit 1
  fi
done

awk -v ver="$VERSION" \
    -v da="$darwin_arm" -v di="$darwin_amd" \
    -v la="$linux_arm"  -v li="$linux_amd" '
  /^  version "/                       { sub(/"[^"]*"/, "\"" ver "\""); print; next }
  /jc-darwin-arm64\.tar\.gz/           { pend = da; print; next }
  /jc-darwin-amd64\.tar\.gz/           { pend = di; print; next }
  /jc-linux-arm64\.tar\.gz/            { pend = la; print; next }
  /jc-linux-amd64\.tar\.gz/            { pend = li; print; next }
  /^[[:space:]]*sha256 / && pend != "" { sub(/"[0-9a-f]*"/, "\"" pend "\""); pend = ""; print; next }
  { print }
' "$FORMULA" > "$FORMULA.tmp"

mv "$FORMULA.tmp" "$FORMULA"
echo "Done. Formula now at $VERSION."

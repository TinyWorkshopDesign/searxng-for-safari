#!/bin/sh
# Copies the extension source (extension/) into the Xcode project's
# extension Resources, which is what actually gets bundled into the app.
set -eu

cd "$(dirname "$0")"

SRC="extension/"
DST="SearXNG for Safari/Shared (Extension)/Resources/"

rsync -av --delete "$SRC" "$DST"

echo
echo "Synced. Rebuild the app to apply the changes:"
echo "  cd \"SearXNG for Safari\" && xcodebuild -scheme \"SearXNG for Safari (macOS)\" -configuration Release -derivedDataPath build DEVELOPMENT_TEAM=<YOUR_TEAM_ID> CODE_SIGN_STYLE=Automatic build"

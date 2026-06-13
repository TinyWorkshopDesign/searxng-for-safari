#!/bin/sh
# Copies the extension source (extension/) into the Xcode project's
# extension Resources, which is what actually gets bundled into the app.
#
# Also purges Syncthing *.sync-conflict-* files from the whole project tree:
# if any of them survive into the .app/.appex bundle they invalidate the
# code-signing seal and Safari will silently refuse to load the extension.
set -eu

cd "$(dirname "$0")"

# 1. Purge stray sync-conflict files (Syncthing artefacts).
#    Safe to delete: they are gitignored and never the canonical version.
purged=$(find . -name "*.sync-conflict-*" -print -delete | wc -l | tr -d ' ')
if [ "$purged" != "0" ]; then
  echo "Removed $purged Syncthing sync-conflict file(s)."
fi

# 2. Mirror extension/ into the Xcode resources.
SRC="extension/"
DST="SearXNG for Safari/Shared (Extension)/Resources/"
rsync -av --delete "$SRC" "$DST"

echo
echo "Synced. Rebuild the app to apply the changes:"
echo "  cd \"SearXNG for Safari\" && xcodebuild -scheme \"SearXNG for Safari (macOS)\" -configuration Release -derivedDataPath build DEVELOPMENT_TEAM=<YOUR_TEAM_ID> CODE_SIGN_STYLE=Automatic MACOSX_DEPLOYMENT_TARGET=12.0 build"

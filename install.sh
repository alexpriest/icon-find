#!/usr/bin/env bash
# Symlink `icon` into ~/.local/bin. Run once per machine — ~/.local/bin is not synced.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/icon"
BIN="$HOME/.local/bin"

mkdir -p "$BIN"
chmod +x "$SRC"
ln -sf "$SRC" "$BIN/icon"

echo "linked $BIN/icon -> $SRC"

for dep in rsvg-convert magick; do
  command -v "$dep" >/dev/null || echo "warning: $dep not found — 'icon sheet' will not work (brew install librsvg imagemagick)"
done

command -v icon >/dev/null && echo "ok: 'icon' is on PATH" || echo "warning: $BIN is not on PATH"

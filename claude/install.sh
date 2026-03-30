#!/bin/bash
# Claude Code config installer
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Installing Claude Code config..."

# Create directories
mkdir -p "$CLAUDE_DIR/commands"

# Backup existing files (skip if already symlinks)
for f in settings.json statusline.sh; do
  target="$CLAUDE_DIR/$f"
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    echo "  Backing up existing $f → $f.bak"
    mv "$target" "$target.bak"
  fi
done

# Symlink config files
ln -sf "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
ln -sf "$SCRIPT_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh"
chmod +x "$SCRIPT_DIR/statusline.sh"

# Symlink custom commands
for cmd in "$SCRIPT_DIR"/commands/*.md; do
  [ -f "$cmd" ] && ln -sf "$cmd" "$CLAUDE_DIR/commands/$(basename "$cmd")"
done

echo ""
echo "✅ Done! Installed:"
echo "   settings.json  → $CLAUDE_DIR/settings.json"
echo "   statusline.sh  → $CLAUDE_DIR/statusline.sh"
ls "$SCRIPT_DIR"/commands/*.md 2>/dev/null | while read cmd; do
  echo "   commands/$(basename "$cmd") → $CLAUDE_DIR/commands/$(basename "$cmd")"
done
echo ""
echo "Restart claude to apply changes."

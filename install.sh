#!/bin/bash
# Dotfiles installer - creates symlinks to the right locations
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Installing dotfiles from: $DOTFILES_DIR"

# --- Claude Code ---
CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR/commands"

ln -sf "$DOTFILES_DIR/claude/settings.json" "$CLAUDE_DIR/settings.json"
ln -sf "$DOTFILES_DIR/claude/statusline.sh" "$CLAUDE_DIR/statusline.sh"
chmod +x "$DOTFILES_DIR/claude/statusline.sh"

for cmd in "$DOTFILES_DIR"/claude/commands/*.md; do
  [ -f "$cmd" ] && ln -sf "$cmd" "$CLAUDE_DIR/commands/$(basename "$cmd")"
done
echo "✅ Claude Code"

# --- tmux ---
if [ -f "$DOTFILES_DIR/tmux/tmux.conf" ]; then
  ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
  echo "✅ tmux"
fi

# --- zsh ---
if [ -f "$DOTFILES_DIR/zsh/zshrc" ]; then
  ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
  echo "✅ zsh"
fi

# --- git ---
if [ -f "$DOTFILES_DIR/git/gitconfig" ]; then
  ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
  echo "✅ git"
fi

echo ""
echo "Done! Restart your shell to apply changes."

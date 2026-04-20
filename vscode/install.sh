#!/usr/bin/env bash
# Install VS Code settings and extensions.

VSCODE_USER="$HOME/Library/Application Support/Code/User"

# Symlink settings
mkdir -p "$VSCODE_USER"
ln -sf "$ZSH/vscode/settings.json" "$VSCODE_USER/settings.json"

# Install extensions
if command -v code &>/dev/null; then
  while IFS= read -r extension; do
    [[ -z "$extension" || "$extension" == \#* ]] && continue
    code --install-extension "$extension" --force
  done < "$ZSH/vscode/extensions"
else
  echo "VS Code CLI (code) not found — install extensions manually from vscode/extensions"
fi

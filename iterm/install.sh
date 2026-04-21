#!/usr/bin/env bash

DYNAMIC_PROFILES_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"

mkdir -p "$DYNAMIC_PROFILES_DIR"

ln -sf "$HOME/.dotfiles/iterm/profiles.json" "$DYNAMIC_PROFILES_DIR/profiles.json"

echo "iTerm2 dynamic profile linked."

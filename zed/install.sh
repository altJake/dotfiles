#!/usr/bin/env bash
# Install Zed settings.
# Extensions are managed via auto_install_extensions in settings.json.
# Formatter binaries (shfmt, cspell) must be installed via Brewfile first.

ZED_CONFIG="$HOME/.config/zed"

mkdir -p "$ZED_CONFIG"
ln -sf "$ZSH/zed/settings.json" "$ZED_CONFIG/settings.json"

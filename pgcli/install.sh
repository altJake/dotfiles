#!/usr/bin/env bash
# Symlink pgcli config into ~/.config/pgcli/config

mkdir -p "$HOME/.config/pgcli"
ln -sf "$ZSH/pgcli/config" "$HOME/.config/pgcli/config"

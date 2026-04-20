#!/usr/bin/env bash
# Set up GPG agent to use macOS pinentry (enables GUI passphrase prompts
# and Keychain integration for commit signing).

GNUPG_DIR="$HOME/.gnupg"
mkdir -p "$GNUPG_DIR"
chmod 700 "$GNUPG_DIR"

echo "pinentry-program $(brew --prefix)/bin/pinentry-mac" > "$GNUPG_DIR/gpg-agent.conf"

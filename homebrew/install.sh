#!/bin/sh
#
# Homebrew
#
# Installs Homebrew if not already present.

if test ! $(which brew); then
  echo "  Installing Homebrew for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

exit 0

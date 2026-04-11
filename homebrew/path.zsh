eval "$(/opt/homebrew/bin/brew shellenv)"

# Make brew completions available to zsh
FPATH="$(brew --prefix)/share/zsh/site-functions:$HOME/.zsh_completions:${FPATH}"

export PATH="./bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

# GNU tools take precedence over macOS built-ins
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$(brew --prefix findutils)/libexec/gnubin:$(brew --prefix grep)/libexec/gnubin:$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"

# dotfiles

Personal macOS dotfiles. Topic-based structure, forked from [holman/dotfiles](https://github.com/holman/dotfiles).

## structure

Everything is organized by topic area. Drop a new directory in and files are auto-loaded:

- **`bin/`** — scripts added to `$PATH`
- **`topic/*.zsh`** — loaded into your shell automatically
- **`topic/path.zsh`** — loaded first, for `$PATH` setup
- **`topic/completion.zsh`** — loaded last, for autocomplete
- **`topic/install.sh`** — run when you call `script/install`
- **`topic/*.symlink`** — symlinked into `$HOME` on `script/bootstrap`

## install

```sh
git clone https://github.com/altjake/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files into your home directory and install Homebrew dependencies via the `Brewfile`.

## docker

Docker is set up using [Colima](https://github.com/abiosoft/colima) as a lightweight alternative to Docker Desktop. After install, start the VM with:

```sh
colima start
```

## ssh

An SSH config template lives at `ssh/config.example`. Copy it to `~/.ssh/config` as a starting point — it is intentionally not auto-symlinked to preserve machine-specific host entries.

## updating

Run `dot` from anywhere to pull the latest and re-apply dependencies.

## credits

Originally forked from [Zach Holman's dotfiles](https://github.com/holman/dotfiles). The topic-based structure and bootstrap approach come directly from his work — [well worth reading about](https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

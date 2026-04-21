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

## new machine setup

### Xcode Command Line Tools

```sh
xcode-select --install
```

### SSH key

Generate a key and add it to GitHub before running bootstrap — the gitconfig rewrites all GitHub traffic to SSH.

```sh
ssh-keygen -t ed25519 -C "your@email.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

Add `~/.ssh/id_ed25519.pub` to [github.com/settings/keys](https://github.com/settings/keys), then verify:

```sh
ssh -T git@github.com
```

### Clone and bootstrap

```sh
git clone https://github.com/altJake/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

Bootstrap will:
- Symlink all `*.symlink` files into `$HOME`
- Prompt for your git author name and email
- Install Homebrew and all packages from the `Brewfile`
- Run all `install.sh` scripts
- Apply macOS defaults

### Open a new terminal

Required to pick up the new zsh config, starship prompt, and plugins.

### iTerm2 font

Preferences → Profiles → Text → set font to `JetBrainsMono Nerd Font`.

### GPG signing key

Add your signing key to `~/.gitconfig.local`:

```ini
[user]
  signingkey = YOUR_KEY_ID
```

### gcloud auth

```sh
gcloud auth login
gcloud auth application-default login
```

### kubectl contexts

Copy or recreate `~/.kube/config` for your clusters.

### Log into apps

Chrome, Slack, Telegram, TablePlus, etc.

## docker

Docker is set up using [Colima](https://github.com/abiosoft/colima) as a lightweight alternative to Docker Desktop. After install, start the VM with:

```sh
colima start
```

## ssh config

An SSH config template lives at `ssh/config.example`. Copy it to `~/.ssh/config` as a starting point — it is intentionally not auto-symlinked to preserve machine-specific host entries.

## updating

Run `dot` from anywhere to pull the latest and re-apply dependencies.

## credits

Originally forked from [Zach Holman's dotfiles](https://github.com/holman/dotfiles). The topic-based structure and bootstrap approach come directly from his work — [well worth reading about](https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

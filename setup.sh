#!/bin/zsh

set -euo pipefail

# install + set up brew
BREWPATH=""
ARCH=$(arch)
if [ "$ARCH" = "arm64" ]; then
  BREWPATH="/opt/homebrew/bin/brew"
else
  BREWPATH="/usr/local/bin/brew"
fi

if [ ! -f "$BREWPATH" ]; then
  echo "Installing brew because '$BREWPATH' does not exist"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

BREW_STATUS=0
which -s brew > /dev/null 2>&1 || BREW_STATUS=$?
if [[ $BREW_STATUS != 0 ]] ; then
  echo "Set up brew shellenv"
  eval "$($BREWPATH shellenv)"
fi

# install stuff
brew update --quiet && brew install diff-so-fancy git zsh sheldon fzf python3 pyenv jq openssl starship neovim nvm zig wasmtime wabt fd
brew install --cask temurin temurin@11 temurin@17 temurin@21

# install xcode-select
XCODE_SELECT_STATUS=0
xcode-select --install > /dev/null 2>&1 || XCODE_SELECT_STATUS=$?

# install volta
curl -fsS https://get.volta.sh | bash

# initialize sheldon
echo "Installing Sheldon"
rsync -u ./sheldon/plugins.toml "$HOME/.config/sheldon/plugins.toml"
sheldon lock

# install node and yarn
"$HOME/.volta/bin/volta" install node npm yarn

# profile files
echo "Set up zprofile"
rsync -u ./.zprofile "$HOME/.zprofile"

echo "Set up zshrc"
rsync -u ./.zshrc "$HOME/.zshrc"

echo "Set up editor helper"
mkdir -p "$HOME/.zsh_utils"
rsync -u ./editor.zsh "$HOME/.zsh_utils/editor.zsh"

# starship stuff
echo "Set up starship"
mkdir -p "$HOME/.starship/cache"
rsync -u ./starship.toml "$HOME/.starship/"

# iterm stuff - make sure to import into iterm
echo "Set up iterm config"
mkdir -p "$HOME/.iterm2"
rsync -u ./com.googlecode.iterm2.plist "$HOME/.iterm2/"

# hostname
HOSTNAME="IronBurg2"
HOSTNAME_CHANGED=0
echo "Set up hostname to be '$HOSTNAME'"
if [ "$(scutil --get HostName)" != "$HOSTNAME" ]; then
  sudo scutil --set HostName "$HOSTNAME"
  HOSTNAME_CHANGED=1
fi
if [ "$(scutil --get LocalHostName)" != "$HOSTNAME" ]; then
  sudo scutil --set LocalHostName "$HOSTNAME"
  HOSTNAME_CHANGED=1
fi
if [ "$(scutil --get ComputerName)" != "$HOSTNAME" ]; then
  sudo scutil --set ComputerName "$HOSTNAME"
  HOSTNAME_CHANGED=1
fi
if [[ $HOSTNAME_CHANGED != 0 ]] ; then
  dscacheutil -flushcache
fi

# git configuration
echo "Set up git config"
git config --global user.email 'matthew.burghoffer@ironcladhq.com'
git config --global user.name 'Matthew Burghoffer'

git config --global pull.default 'current'

git config --global push.default 'current'

git config --global checkout.defaultRemote 'origin'
git config --global --type=bool checkout.autoSetupRemote 'true'

git config --global core.editor 'nvim'

git config --global diff.tool 'vscode'

git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'

git config --global merge.tool 'vscode'

git config --global mergetool.vscode.cmd 'code --wait $MERGED'

git config --global pull.ff 'only'

git config --global alias.set-upstream '!git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`'

## git diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=2 -RF"
git config --global interactive.diffFilter "diff-so-fancy --patch"
git config --global --type=bool color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

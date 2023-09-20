#!/bin/zsh

# install + set up brew
BREWPATH=""
ARCH=$(arch)
if [ "$ARCH" = "arm64" ]; then
  BREWPATH="/opt/homebrew/bin/brew"
else
  BREWPATH="/usr/local/bin/brew"
fi

if [ ! -f "$BREWPATH" ]; then
    /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

which -s brew
if [[ $? != 0 ]] ; then
  eval "$($BREWPATH shellenv)"
fi

# install stuff
brew update && brew install git zsh antigen python3 jq openssl
xcode-select --install

# starship stuff
mkdir -p "$HOME/.starship/cache"
cp --update ./starship.toml "$HOME/.starship/"

# iterm stuff - make sure to import into iterm
mkdir -p "$HOME/.iterm2"
cp --update ./com.googlecode.iterm2.plist "$HOME/.iterm2/"

# keys file
touch "$HOME/.zkeys"

# git configuration
git config --global user.email matthew.burghoffer@ironcladhq.com
git config --global user.name Matthew Burghoffer

git config --global pull.default current

git config --global push.default current

git config --global checkout.defaultRemote origin
git config --global checkout.autoSetupRemote true

git config --global core.editor 'code --wait'

git config --global diff.tool vscode

git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'

git config --global merge.tool vscode

git config --global mergetool.vscode.cmd 'code --wait $MERGED'

git config --global pull.ff only

git config --global alias.set-upstream '!git branch --set-upstream-to=origin/`git symbolic-ref --short HEAD`'

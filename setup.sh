#!/bin/zsh

# install stuff
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update && brew install git zsh antigen python3 jq openssl
xcode-select --install

# make required dirs
mkdir -p ~/.starship/cache
mkdir -p ~/.iterm2

# copy files
cp --update ./com.googlecode.iterm2.plist ~/.iterm2/
cp --update ./tarship.toml ~/.starship/

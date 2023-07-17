#!/bin/zsh

# install stuff
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update && brew install git zsh antigen python3 jq openssl
xcode-select --install

# starship stuff
mkdir -p ~/.starship/cache
cp --update ./starship.toml ~/.starship/

# iterm stuff - make sure to import into iterm
mkdir -p ~/.iterm2
cp --update ./com.googlecode.iterm2.plist ~/.iterm2/

# keys file
cp --no-clobber ./zkeys ~/

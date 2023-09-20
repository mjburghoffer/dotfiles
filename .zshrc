#!/bin/zsh

# Load antigen
source "$(brew --prefix)/share/antigen/antigen.zsh"

# Set up antigen
antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting

# configure starship theme
export STARSHIP_CONFIG="$HOME/.starship/starship.toml"
export STARSHIP_CACHE="$HOME/.starship/cache"
eval "$(starship init zsh)"

# Finalize antigen
antigen apply

# enable pyenv
eval "$(pyenv init -)"

# dev connect via strongdm
alias devc="$IRONCLAD_HOME/dev/connect"

# commented out to make sure super setup doesn't add this line
# source $HOME/.zshrc_ironclad

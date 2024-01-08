#!/bin/zsh

# configure starship theme
export STARSHIP_CONFIG="$HOME/.starship/starship.toml"
export STARSHIP_CACHE="$HOME/.starship/cache"
eval "$(starship init zsh)"

# Configure plugins
## fuzzy-search-and-edit

## jq-complete
bindkey '^J' jq-complete

# Install plugins
eval "$(sheldon source)"

# have fzf use fd instead
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# CTRL-T - Paste the selected file path(s) into the command line
export FZF_CTRL_T_COMMAND='fd --strip-cwd-prefix --hidden --follow --exclude ".git"'

# commented out to make sure super setup doesn't add this line
# source $HOME/.zshrc_ironclad

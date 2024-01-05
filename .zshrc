#!/bin/zsh

# configure starship theme
export STARSHIP_CONFIG="$HOME/.starship/starship.toml"
export STARSHIP_CACHE="$HOME/.starship/cache"
eval "$(starship init zsh)"

# Configure plugins
## fuzzy-search-and-edit
bindkey '^P' fuzzy-search-and-edit
zstyle ':fuzzy-search-and-edit:editor' use-visual yes
zstyle ':fuzzy-search-and-edit:editor:invocation-format' editor "$HOME/.zsh_utils/editor.zsh \${VISUAL_EDITOR}"

## jq-complete
bindkey '^J' jq-complete

## enhancd
export ENHANCD_FILTER="fzf --height 40%"
export ENHANCD_ENABLE_DOUBLE_DOT=false

# Install plugins
eval "$(sheldon source)"

# commented out to make sure super setup doesn't add this line
# source $HOME/.zshrc_ironclad

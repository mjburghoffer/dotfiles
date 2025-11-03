#!/bin/zsh

ulimit -n 65536

if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# env vars
export VOLTA_HOME="$HOME/.volta"
export PROJECTS_HOME="/usr/local/repos"
export IRONCLAD_HOME="$PROJECTS_HOME/ironclad"
export ichome="$IRONCLAD_HOME"
export HARBOR_HOME="$IRONCLAD_HOME/harbor"
export SUPER_HOME="$IRONCLAD_HOME/super"
export SDM_EMAIL="matthew.burghoffer@ironcladhq.com"
export ES_JAVA_HOME=$(/usr/libexec/java_home -v 21)
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
export VISUAL_EDITOR="webstorm"
export ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

# commented out to make sure super setup doesn't add this line
# source $HOME/.zshrc_ironclad
if [ -f "$HOME/.zsh_secrets" ]; then
    source "$HOME/.zsh_secrets"
fi

# yoink only the env vars and functions out of $HOME/.zshrc_ironclad
if [ -f "$HOME/.zshrc_ironclad" ]; then
    eval $(grep -E '^export [A-Z][A-Z_0-9]*[A-Z]="?[^${}:]+"?$' "$HOME/.zshrc_ironclad" --color=never)

    # launch a new blank shell that sources zshrc_ironclad and then gets its function definitions
    FUNCS=$(env -i zsh -df --no-rcs -c "source $HOME/.zshrc_ironclad; declare -f $(sed -nr 's/^([a-zA-Z]+)\(\) *{$/\1/p' $HOME/.zshrc_ironclad | tr '\n' ' ')")
    eval $FUNCS
fi

# completions
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

if [ -f "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc" ]; then
    source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc" ]; then
    source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

# nvm setup
export NVM_DIR="$HOME/.nvm"
  [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# path
eval "$(pyenv init --path)"
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$VOLTA_HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$(brew --prefix)/bin/python3"
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

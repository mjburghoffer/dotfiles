#!/bin/zsh

# keys
source ~/.zkeys

ulimit -n 65536

BREWPATH=""
if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# env vars
export VOLTA_HOME="$HOME/.volta"
export PROJECTS_HOME="$HOME/projects"
export IRONCLAD_HOME="$PROJECTS_HOME/ironclad"
export HARBOR_HOME="$IRONCLAD_HOME/harbor"
export SUPER_HOME="$IRONCLAD_HOME/super"
export SDM_EMAIL="matthew.burghoffer@ironcladhq.com"
export ES_JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=$(/usr/libexec/java_home)

# commented out to make sure super setup doesn't add this line
# source $HOME/.zshrc_ironclad

# yoink only the env vars out of $HOME/.zshrc_ironclad
if [ -f "$HOME/.zshrc_ironclad" ]; then
    eval $(grep -E '^export [A-Z][A-Z_0-9]*[A-Z]="?[^${}:]+"?$' "$HOME/.zshrc_ironclad" --color=never)
fi

# completions
if [ -f "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc" ]; then
    source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc" ]; then
    source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
fi

# path
eval "$(pyenv init --path)"
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$VOLTA_HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"

super() {
  if [ "$1" = "env" ]; then
    . "${IRONCLAD_HOME}/super/dev.env"
  else
    eval "${IRONCLAD_HOME}/super/$@"
  fi
}

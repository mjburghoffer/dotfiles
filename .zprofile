#!/bin/zsh

# keys
source ~/.zkeys

ulimit -n 65536

# completions
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# env vars
export VOLTA_HOME="$HOME/.volta"
export PROJECTS_HOME="$HOME/projects"
export IRONCLAD_HOME="$PROJECTS_HOME/ironclad"
export HARBOR_HOME="$IRONCLAD_HOME/harbor"
export SUPER_HOME="$IRONCLAD_HOME/super"
export SDM_EMAIL="matthew.burghoffer@ironcladhq.com"
export ES_JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# unset ironclad's bad google-cloud-sdk source
# case `grep -q -e '^source .*google-cloud-sdk/.*$' "$HOME/.zshrc_ironclad"; echo $?` in
#   0)
#     perl -i -pe's/^(source .+google-cloud-sdk.+)$/# \1/' "$HOME/.zshrc_ironclad"
#     ;;
#   1)
#     # nada
#     ;;
#   *)
#     echo 'Error while trying to fix google-cloud-sdk source'
#     ;;
# esac

# commented out to make sure super setup doesn't add this line
# source $HOME/.zshrc_ironclad

# yoink only the env vars out of $HOME/.zshrc_ironclad
eval $(grep -E '^export [A-Z][A-Z_0-9]*[A-Z]="?[^${}:]+"?$' "$HOME/.zshrc_ironclad" --color=never)

# path
eval "$(pyenv init --path)"
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$VOLTA_HOME/bin"
export PATH="$PATH:$HOME/.local/bin"

super() {
  if [ "$1" = "env" ]; then
    . "${IRONCLAD_HOME}/super/dev.env"
  else
    eval "${IRONCLAD_HOME}/super/$@"
  fi
}

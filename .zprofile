#!/bin/zsh

# keys
source ~/.zkeys

# unset ironclad's bad google-cloud-sdk source
case `grep -q -e '^source .*google-cloud-sdk/.*$' "$HOME/.zshrc_ironclad"; echo $?` in
  0)
    perl -i -pe's/^(source .+google-cloud-sdk.+)$/# \1/' "$HOME/.zshrc_ironclad"
    ;;
  1)
    # nada
    ;;
  *)
    echo 'Error while trying to fix google-cloud-sdk source'
    ;;
esac

# ironclad generated env
source $HOME/.zshrc_ironclad

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

# path
eval "$(pyenv init --path)"
export PATH=/usr/local/bin:$PATH
export PATH="$VOLTA_HOME/bin:$PATH"

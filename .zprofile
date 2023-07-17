#!/bin/zsh

# keys
source ~/.zkeys

# ironclad generated env
source $HOME/.zshrc_ironclad

# ironclad env
export VOLTA_HOME="$HOME/.volta"
export PROJECTS_HOME="$HOME/projects"
export IRONCLAD_HOME="$PROJECTS_HOME/ironclad"
export HARBOR_HOME="$IRONCLAD_HOME/harbor"
export SUPER_HOME="$IRONCLAD_HOME/super"
export SDM_EMAIL="matthew.burghoffer@ironcladhq.com"
export ES_JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# env
export PATH=/usr/local/bin:$PATH
export PATH="$VOLTA_HOME/bin:$PATH"

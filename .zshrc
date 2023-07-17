# ~/.zshrc

# ironclad env
source $HOME/.zshrc_ironclad
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export HELLOSIGN_API_KEY=''
export PROJECTS_HOME="$HOME/projects"
export IRONCLAD_HOME="$PROJECTS_HOME/ironclad"
export HARBOR_HOME="$IRONCLAD_HOME/harbor"
export SUPER_HOME="$IRONCLAD_HOME/super"
export SDM_EMAIL="matthew.burghoffer@ironcladhq.com"
export ES_JAVA_HOME=$(/usr/libexec/java_home)

# env
export PATH=/usr/local/bin:$PATH
export JAVA_HOME=$(/usr/libexec/java_home -v 11)

# Load antigen
source /usr/local/share/antigen/antigen.zsh

# Set up antigen
antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting

# configure starship theme
export STARSHIP_CONFIG=~/.starship/starship.toml
export STARSHIP_CACHE=~/.starship/cache
eval "$(starship init zsh)"

# Finalize antigen
antigen apply

# enable pyenv
eval "$(pyenv init -)"

# dev connect via strongdm
alias devc="$IRONCLAD_HOME/dev/connect"

# super alias
super() {
  (
    if [ "$1" = "env" ]; then
      . "$SUPER_HOME/dev.env"
    else
      "$SUPER_HOME/$@"
    fi
  )
}

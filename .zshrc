# this needs to be set for brew to work
export PATH=/usr/local/bin:$PATH
export NVM_DIR="$HOME/.nvm"

if ! [ -e "$HOME/.zshbootstrapped" ]; then
  # notify
  echo "Bootstrapping shell for the first time!"

  # Install homebrew if not present
  hash brew 2> /dev/null || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  # Install utilities if not present
  for util in git zsh antigen "bash-completion" python3 jq openssl; do
    if ! brew list --versions "$util" > /dev/null; then
      brew install "$util"
    fi
  done

  # Intall nvm if not present
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
  fi

  touch ~/.zshbootstrapped
fi

# Load antigen
source /usr/local/share/antigen/antigen.zsh

# Set up antigen.
antigen use oh-my-zsh
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme denysdovhan/spaceship-zsh-theme spaceship
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_TIME_SHOW=false

# Tell antigen that you're done.
antigen apply

# exports...
export JAVA_HOME=$(/usr/libexec/java_home)

# enable nvm
source "$NVM_DIR/nvm.sh" > /dev/null
nvm use > /dev/null

# Path to oh-my-zsh installation.

export ZSH=/home/arnaudoff/.oh-my-zsh

# Set name of the theme to load.

ZSH_THEME="bureau"

# Use hyphen-insensitive completion.

HYPHEN_INSENSITIVE="true"

# Disable marking untracked files under VCS as dirty. This makes repository
# status check for large repositories much, much faster.

# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Load plugins

plugins=(git)

# User configuration

#export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Load oh my zsh

source $ZSH/oh-my-zsh.sh

# Load z <3

source /home/arnaudoff/.scripts/z/z.sh

# Aliases

alias zshconf="vim ~/.zshrc"
alias urxvtconf="vim ~/.Xdefaults"
alias vimconf="vim ~/.vimrc"
alias gs="git status"

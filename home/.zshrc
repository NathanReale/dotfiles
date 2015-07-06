# Load antigen
source $HOME/.homesick/repos/dotfiles/antigen/antigen.zsh
ZSH_BASE=$HOME/.zsh

# oh-my-zsh options
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

antigen use oh-my-zsh

antigen bundle vi-mode
antigen bundle rupa/z

antigen theme $ZSH_BASE/themes nreale
antigen apply

export PATH=$HOME/bin:/usr/local/bin:$PATH

# Cache completions
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Allow editing command line
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

# Make up and down search by default
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Lower the timeout when pressing esc on the command line
export KEYTIMEOUT=1

# Source .zsh_aliases
if [[ -f $HOME/.zsh_aliases ]]; then
	. $HOME/.zsh_aliases
fi

# Source .dircolors
if [[ -f $HOME/.dircolors ]]; then
  eval `dircolors $HOME/.dircolors`
fi

# Load platform-specific configurations
PLATFORM=`uname`
if [[ $PLATFORM == "Darwin" ]] ; then
	PLATFORM=osx
elif [[ $PLATFORM == "Linux" ]] ; then
	PLATFORM=linux
fi

if [[ -f ~/.zsh/$PLATFORM.zsh ]]; then
	source ~/.zsh/$PLATFORM.zsh
fi

# Load local configuration file
if [[ -f ~/.zshrc.local ]]; then
	source ~/.zshrc.local
fi

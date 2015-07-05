# Load antigen
source $HOME/.homesick/repos/dotfiles/antigen/antigen.zsh

# oh-my-zsh options
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

antigen use oh-my-zsh

antigen bundle vi-mode
antigen bundle rupa/z

antigen theme ys
# theme nreale
# custom $HOME/.zsh
antigen apply

# From old .zshrc
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Source .zsh_aliases
if [[ -f $HOME/.zsh_aliases ]]; then
	. $HOME/.zsh_aliases
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
if [[ -f ~/.local.zsh ]]; then
	source ~/.local.zsh
fi

# Lower the timeout when pressing esc on the command line
export KEYTIMEOUT=1

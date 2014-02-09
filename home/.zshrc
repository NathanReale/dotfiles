# Skip this for non-interactive shelld
[[ -z "$PS1" ]] && return

# Set the SVN Editor
export SVN_EDITOR=vim


[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"

# Enable command completion
autoload -U compinit
compinit

# Allow approximate matches
zstyle ':completion:*' completer _complete _match _approximate

# Allow case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'

# Complete kill command
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Set Environment Variables
PAGER='less'
EDITOR='vim'

# Set History Options
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# Set vi mode
set -o vi

# Bind keys to search back in history using up and down keys
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Prompt Colors
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	eval PR_BRIGHT_$color='${fg_bold[${(L)color}]%}'
	(( count = $count + 1 ))
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"

# Define Prompt
PS1="[$PR_RED%* $PR_BLUE%n$PR_NO_COLOR@$PR_BLUE%m$PR_NO_COLOR:$PR_GREEN%~$PR_NO_COLOR]%(!.#.$) "

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git bzr svn
zstyle ':vcs_info:(git*|hg*):*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr "$PR_RED*"
zstyle ':vcs_info:*' stagedstr "$PR_YELLOW+"
zstyle ':vcs_info:*' actionformats "" "[$PR_RED%a $PR_GREEN%b%u%c$PR_NO_COLOR]"
zstyle ':vcs_info:*' formats "" "[$PR_GREEN%b%u%c$PR_NO_COLOR]"
zstyle ':vcs_info:*' branchformat '%b-%r'
zstyle ':vcs_info:*' nvcsformats "no" "no"

setopt prompt_subst

function precmd() {
	vcs_info
    if [[ $vcs_info_msg_0_ != "no" ]];
	then
		RPROMPT='${vcs_info_msg_1_}'
	else
		RPROMPT=""
	fi
}


# Source .zsh_aliases
if [[ -f $HOME/.zsh_aliases ]]; then
	. $HOME/.zsh_aliases
fi


PLATFORM=`uname`

if [[ $PLATFORM == "Darwin" ]] ; then
  PLATFORM=osx
elif [[ $PLATFORM == "Linux" ]] ; then
  PLATFORM=linux
fi

# Load platform-specific configurations
[[ -s "~/.zsh/$PLATFORM.zsh" ]] && source "~/.zsh/$PLATFORM.zsh"

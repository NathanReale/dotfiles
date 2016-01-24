# Based on the ys theme, modified by Nathan Reale

# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname
}

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

if $ENABLE_WORK_SETTINGS; then
  # Directory info.
  function current_dir() {
    local work_path='$(citc_rel_path)'
    if [[ "$work_path" != "" ]] ; then
      echo $work_path
    else
      echo $PWD/#HOME/~
    fi
  }
else
  function current_dir() {
    echo $PWD/#$HOME/~
  }
fi

# Git info.
function git_prompt_info() {
  if ! [[ $(pwd) =~ '^/google/src/' ]]
  then
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}
local git_info='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"


if $ENABLE_WORK_SETTINGS; then
  function work_info() {
    local work_client=`citc_client_name`
    if [[ "$work_client" != "" ]] ; then
      echo "${YS_VCS_PROMPT_PREFIX1}citc${YS_VCS_PROMPT_PREFIX2}$work_client%{$reset_color%}"
    fi
  }
  local work_prompt='$(work_info)'
else
  local work_prompt=''
fi


PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$fg[cyan]%}%n \
%{$fg[white]%}at \
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$fg[yellow]%}$(current_dir)%{$reset_color%}\
${git_info}\
${work_prompt} \
%{$fg[white]%}[%*]
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"

if [[ "$(whoami)" == "root" ]]; then
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%} \
%{$fg[white]%}at \
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}$(current_dir)%{$reset_color%}\
${git_info}\
${work_prompt} \
%{$fg[white]%}[%*]
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
fi

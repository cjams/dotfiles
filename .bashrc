#
# /home/cjd/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias pacman="sudo pacman"
alias systemctl="sudo systemctl"
alias poweroff="systemctl poweroff"
alias shutdown="systemctl shutdown"
alias suspend="systemctl suspend"
alias reboot="systemctl reboot"
alias rm="rm -i"
alias ls="ls -a --color=auto"
alias qb="qutebrowser &> /dev/null & disown"

# default other prompt values
export PS2='> '
export PS3='> '
export PS4='+ '

#lfs build root
export LFS="/mnt/lfs"

#update mirrors and ABS tree
~/scripts/updt_mirrors

# color definitions
# start coloring with "\[\e[<color>\]" and end coloring with "\[\e[m\]" where
# <color> -> 0;30-37m   -- 0 gives "regular" colors
#         -> 1;30-37m   -- 1 gives bold colors

# normal colors
white='\[\e[0;37m\]'
red='\[\e[0;31m\]'
green='\[\e[0;32m\]'
cyan='\[\e[0;36m\]'
purple='\[\e[0;35m\]'

# bold colors
bwhite='\[\e[1;37m\]'
bred='\[\e[1;31m\]'
bgreen='\[\e[1;32m\]'
bcyan='\[\e[1;36m\]'
bpurple='\[\e[1;35m\]'

# reset color to default
end_color='\[\e[m\]'

# cursor manipulation
#   \[\033[s\]                saves current cursor position
#   \[\033[u\]                restore cursor to last saved position
#   \[\033[<row>;<column>f\]  set cursor at point <row>, <column>
save_cursor='\[\033[s\]'
restore_cursor='\[\033[u\]'

# git-prompt settings
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOW_STASHSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

# function for setting the command prompt
set_prompt () {

  # set date to be printed in 2nd row, 5th column over from the far right
  place_cursor="\[\033[2;$((COLUMNS-5))f\]"
  print_hud_info="$bwhite$(date +%H:%M)$end_color"
  PRE_PS1="$save_cursor$place_cursor$print_hud_info$restore_cursor"


  # start prompt by the command line
  PRE_PS1+='['
  POST_PS1=''

  # if user is root, then display host in bold red
  # else display bold cyan user @ host
  if [[ $EUID == 0 ]]; then
    PRE_PS1+="$bred\\h"
    POST_PS1+="$bred# $end_color"
  else
    PRE_PS1+="$bcyan\\u"
    POST_PS1+="$bcyan$ $end_color"
  fi

  PRE_PS1+=" $bwhite\\w$end_color]"

  source $HOME/scripts/git-completion.bash
  source $HOME/scripts/git-prompt.sh

  # set to git prompt
  __git_ps1 "${PRE_PS1}" "${POST_PS1}"
}

# set prompt
PROMPT_COMMAND='set_prompt'

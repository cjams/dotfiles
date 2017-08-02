#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto -n'

# git prompt
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
source .git-prompt.sh
source .git-completion.bash

PROMPT_COMMAND='__git_ps1 "\w" " \\\$ "'

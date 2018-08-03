#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto -n'
alias pmi='sudo pacman -S '
alias pmr='sudo pacman -R '
alias pmy='sudo pacman -Syy '
alias pmu='sudo pacman -Syu '

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUPSTREAM=1

source /etc/profile.d/cnf.sh
source /usr/share/git/completion/git-prompt.sh
source /usr/share/bash-completion/bash_completion

PROMPT_COMMAND='__git_ps1 "\w" " \$ "'
EDITOR=/usr/bin/vim

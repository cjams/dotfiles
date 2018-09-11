#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias ls='ls --color=auto'
alias grep='grep --color=auto -n'
alias pmi='sudo pacman -S '
alias pmr='sudo pacman -R '
alias pmy='sudo pacman -Syy '
alias pmu='sudo pacman -Syu '
alias ch='cd $HOME/bareflank/hypervisor'
alias ce='cd $HOME/bareflank/eapis'
alias ca='cd $HOME/bareflank/havoc'
alias cbh='cd $HOME/bareflank/build-hypervisor'
alias cbe='cd $HOME/bareflank/build-eapis'
alias cba='cd $HOME/bareflank/build-havoc'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias ns='ninja stop'
alias nq='ninja quick'
alias ndq='ninja driver_quick'

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUPSTREAM=1

source /usr/share/git/completion/git-prompt.sh
source /usr/share/bash-completion/bash_completion

PROMPT_COMMAND='__git_ps1 "\w" " \$ "'
EDITOR=/usr/bin/vim

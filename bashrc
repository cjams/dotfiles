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
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias glo='git log --oneline'

EDITOR=/usr/bin/vim

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

ulimit -s unlimited
export EDITOR='nvim'
alias config='/usr/bin/git --git-dir=$HOME/Documents/dotfiles --work-tree=$HOME'
PATH=$PATH:$HOME/Documents/mycode/scripts


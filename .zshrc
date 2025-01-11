# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
bindkey -e
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char



# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ethan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Created by newuser for 5.9


# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# source ~/.bashrc
# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# source /usr/share/autojump/autojump.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



ulimit -s unlimited
alias ls='lsd --hyperlink=auto'
alias icat="kitten icat"
alias s="kitten ssh"
alias d="kitten diff"
alias config='/usr/bin/git --git-dir=$HOME/Documents/dotfiles --work-tree=$HOME'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

alias zc='z -c'      # 严格匹配当前路径的子路径
alias zz='z -i'      # 使用交互式选择模式
alias zf='z -I'      # 使用 fzf 对多个结果进行选择
alias zb='z -b'      # 快速回到父目录
alias zh='z -I -t .' # 使用 fzf 选择最近去过的目录


# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH
export GTK_USE_PORTAL=1
export PATH=$PATH:/opt/cross-tools.gcc_glibc/bin:/opt/gdb/bin:/opt/qemu/bin


export COPT_HOME=/opt/copt72
export COPT_LICENSE_DIR=$HOME/
# export COPT_LICENSE_DIR=/opt/copt72
export PATH=$COPT_HOME/bin:$PATH
export LD_LIBRARY_PATH=$COPT_HOME/lib:$LD_LIBRARY_PATH



eval "$(starship init zsh)"
eval "$(lua /usr/share/z.lua/z.lua --init zsh enhanced once echo)"

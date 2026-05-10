export MOZ_DBUS_REMOTE=1
export GPG_TTY=$(tty)

if [ "$TERM" = linux ] && command -v ttyscheme >/dev/null; then
  ttyscheme gruvbox_dark
fi

## SHELLS VARS
export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

## HISTORY VARS
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

## ZSH VARS
ENABLE_CORRECTION="true"
HIST_STAMPS="dd.mm.yyyy"

###############
##  ALIASES  ##
###############
alias q="exit"
alias vi="vim"
alias vim="nvim"
alias nv="nvim"
alias nvrc="nv ~/.config/nvim/init.lua"
alias vimrc="nvim ~/.vimrc"
alias vimconf="vimrc"
alias zshrc="nvim ~/.zshrc"
alias zshconf="zshrc"
alias ls="lsd" 
alias sl="ls"
alias ll="ls -lh"
alias la="ls -lah"
alias ..="cd .."
alias ...="cd ../.."
alias nf="neofetch --bold off --block_range 0 7 --colors 4 6 8 3 5 7"
alias gitadog="git log --all --decorate --oneline --graph"
alias fzf='SHELL=bash fzf'
alias cat='bat -p'

if [ "$(uname -s)" = "Darwin" ]; then
  alias pip="pip3"
  export XDG_CONFIG_HOME="$HOME/.config"
  if type brew &>/dev/null 
    then
    export PATH="/opt/homebrew/bin:$PATH"
    source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  fi
else
  source ${ZDOTDIR:-~}/.antidote/antidote.zsh
  export LESSOPEN="|$(which lesspipe.sh) %s"
  export LESSCOLORIZER='bat'
fi

autoload -Uz compinit && compinit
antidote load ~/.zsh_plugins

eval "$(mcfly init zsh)"

export PATH="$PATH:$HOME/.local/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi

eval "$(starship init zsh)"

source ~/.zsh/*

fpath=(/Users/vittorio/.docker/completions $fpath)

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/vittorio.fones/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

export MOZ_DBUS_REMOTE=1
export GPG_TTY=$(tty)

if [ "$TERM" = linux ] && command -v ttyscheme >/dev/null; then
  ttyscheme gruvbox_dark
fi

## SHELLS VARS
export TERM="xterm-256color"
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less --mouse"

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
alias vimrc="vi ~/.vimrc"
alias vimconf="vi ~/.vimrc"
alias zshrc="vi ~/.zshrc"
alias zshconf="vi ~/.zshrc"
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
  if type brew &>/dev/null
    then
    source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
    autoload -Uz compinit
    compinit
  fi
else
  source ${ZDOTDIR:-~}/.antidote/antidote.zsh
  export LESSOPEN="|$(which lesspipe.sh) %s"
  export LESSCOLORIZER='bat'
fi

antidote load ~/.zsh_plugins
zstyle ':antidote:compatibility-mode' 'antibody'
autoload -Uz promptinit && promptinit
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
_comp_options+=(globdots)
zstyle ':completion:*' special-dirs false
setopt complete_aliases
unsetopt correct_all  
setopt correct

export PATH="$PATH:$HOME/.local/bin"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx
fi

eval "$(starship init zsh)"

fpath=(/Users/vittorio/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

#!/bin/zsh
# This is load after .zshenv

# base setting
HISTSIZE=2048
HISTFILE=~/.zsh/.zshistry
SAVEHIST=5000
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history 
setopt share_history #zshプロセス間でヒストリ共有


# Lang
export LANG=ja_JP.UTF-8
export LC_CTYPE="ja_JP.UTF-8"
# export LANG=ja_JP.eucJP "for Latex

# Alias -- modified commands
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias ls='ls --color'
alias vi='vim'
alias ..='cd ..'
alias c='clear'
alias rm='rm --interactive'
alias cp='cp --interactive'
alias ping='ping -c 5'
alias diff='colordiff'
alias grep='grep --color=auto'
alias ,doc='cd ~/dict/dropbox/code/Dropbox/docs'
alias ,fuginn='cd ~/dict/dropbox/code/Dropbox/docs && ls -a'
alias xterm='xterm -en utf8'

alias myhome='sudo netcfg myhome'
alias awetest="Xephyr -ac -br -noreset -screen 800x600 :1 & sleep 1 && DISPLAY=:0.0 awesome -c ~/.config/awesome/rc.lua"
alias dropboxw='sh $HOME/dict/dropbox/automate_dropbox.sh'
alias mbplack='cd /home/gylfe/git/markdown-binder && plackup'
alias getip='wget -q -O - ipcheck.mycurse.net'
alias volp='amixer sset Master 5%+'
alias volm='amixer sset Master 5%-'
alias memfree='sudo sync && sudo sysctl -w vm.drop_caches=3'
alias mpd='sudo mpd && mpdscribble'

# Key Binding
bindkey -v

# Completement
autoload -U compinit
compinit
setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt no_beep
setopt noautoremoveslash
setopt complete_in_word
setopt glob_complete
setopt hist_expand
setopt numeric_glob_sort

# Prompt
autoload -Uz promptinit
promptinit
setopt prompt_subst
autoload -U colors
colors

function precmd {
    # change the title of the terminal :
    case $TERM in
      xterm*)
        print -Pn "\e]0;%n sur %m\a"
        ;;
    esac
    
    # prompt color (red if root) :
    c='blue'
    [[ `id -u` -eq 0 ]] && c='red'

    PROMPT="${fg[$c]}%}%n%% "
    RPROMPT="%{${fg[white]}%}%~%{${reset_color}%}"
    SPROMPT="correct: %R -> %r ? "
}

#export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
# ***Mac***
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=cxfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

    #export LSCOLORS=gxfxcxdxbxegedabagacad
    #export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    #zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac


# Autoload
#autoload predict-on
#predict-on
autoload zed  #light editor

# History Search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end

# other setting files
load_plugins() {
    if [ -d ~/.zsh ]; then
        source ~/.zsh/*
    fi
}
main() {
    load_plugins
}

[ -f ~/.zsh/.zshrc.mine ] && source ~/.zsh/.zshrc.mine

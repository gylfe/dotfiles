#!/bin/zsh
# This is load after .zshenv

# base setting --------------------
HISTSIZE=4096
HISTFILE=~/.log/.zshistry
SAVEHIST=16384
setopt extended_history # zshの起動と終了時刻をhistoryに書き込む
setopt hist_ignore_all_dups  # 既にhistoryにあるCLは古い方を削除
setopt hist_ignore_dups  # 直前と同じCLはhistoryぶ追加しない
setopt hist_ignore_space
setopt inc_append_history 
setopt share_history #zshプロセス間でヒストリ共有

REPORTTIME=5  # 5秒以上かかった処理の詳細表示

# Lang ----------------------------
export LANG=ja_JP.UTF-8
export LC_CTYPE="ja_JP.UTF-8"

# export LANG=ja_JP.eucJP "for Latex

# Alias -- modified commands -------
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias ls='ls --color'
alias ll='ls -al --color'
alias la='ls -a --color'
alias vi='vim'
alias c='clear'
alias rm='trash-put -i'
alias cp='cp --interactive'
alias ping='ping -c 5'
alias diff='colordiff'
alias grep='grep --color=auto'
alias xterm='xterm -en utf8'
alias less='less -R'

alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias getip='wget -q -O - ipcheck.mycurse.net'
alias memfree='sudo sync && sudo sysctl -w vm.drop_caches=3'
alias volp='amixer sset Master 5%+'
alias volm='amixer sset Master 5%-'
alias mpd='sudo mpd && mpdscribble'
alias awetest="Xephyr -ac -br -noreset -screen 800x600 :1 & sleep 1 && DISPLAY=:0.0 awesome -c ~/.config/awesome/rc.lua"


case "${OSTYPE}" in
# linux ----------------------------
linux*)
alias myhome='sudo netcfg myhome'
alias dropboxw='sh $HOME/dict/dropbox/automate_dropbox.sh'
alias mbplack='cd /home/gylfe/git/markdown-binder && plackup'
alias gentoo!='su - && mount /dev/sda? /mnt/gentoo && mount -t proc none /mnt/gentoo/proc &&  mount --rbind /dev /mnt/gentoo/dev && chroot /mnt/gentoo /bin/zsh'

alias ,doc='cd ~/dict/dropbox/code/Dropbox/docs && ls -a'
alias ,code='cd ~/dict/dropbox/code/Dropbox'
alias ,pri='cd ~/dict/dropbox/private/Dropbox'
alias ,script='cd ~/dict/script && ls -a --color'

;;
# cygwin ----------------------------
cygwin*)

;;
esac


# Key Binding ------------------------
bindkey -v

# Completement -----------------------
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
setopt pushd_ignore_dups # 同じディレクトリをpushdしない
setopt auto_menu # TABで補完候補切り替え
setopt auto_param_keys # ()等の自動補完
setopt magic_equal_subst # --prefix=/usr等の=以降も補完
setopt mark_dirs #directoey末尾に/を付加
setopt print_eight_bit # 日本語ファイル名等, 8bitを通す
setopt nonomatch # よう分からんが no matches foundと怒られるんで
setopt no_tify # バックグラウンドジョブが終了したらすぐに知らせる。
setopt hist_verify # historyを確定前に編集
setopt hist_reduce_blanks

# zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' verbose yes # 補完の表示を過剰にする 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 補完時に文字の大小を区別しない

# Prompt ----------------------------
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


# Autoload ------------------------
#autoload predict-on
#predict-on
autoload zed  #light editor

# History Search ------------------
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

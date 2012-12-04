#!/bin/zsh
## This is load after .zshenv
## Load when interactive
# base setting --------------------
HISTSIZE=4096
SAVEHIST=16384
setopt   auto_resume
setopt   extended_glob         # glob機能拡張
setopt   long_list_jobs
setopt   numeric_glob_sort
setopt   ignore_eof
unsetopt caseglob              # ファイルグロブで大小非区別
unsetopt promptcr
autoload -Uz add-zsh-hook
REPORTTIME=100  # 100秒以上かかった処理の詳細表示
watch="all"
# log

# Lang ----------------------------
export LANG=ja_JP.UTF-8
export LC_CTYPE="ja_JP.UTF-8"
export LC_TIME="en_US.UTF-8"

# Alias -- modified commands -------
setopt complete_aliases  # aliased ls needs if file/dir completions work

alias c='clear'
alias cp='cp --interactive'
alias diff='colordiff'
alias grep='grep --color=auto'
alias less='less -R'
alias ping='ping -c 5'
alias rgrep='find . -name "*.git" -prune -o -type f -print0 | xargs -0 grep'
alias vi='vim'
alias xterm='xterm -en utf8'

alias ipget='wget -q -O - ipcheck.mycurse.net'
alias memfree='sudo sync && sudo sysctl -w vm.drop_caches=3'
alias volp='amixer sset Master 5%+'
alias volm='amixer sset Master 5%-'
alias mpd='sudo mpd && mpdscribble'


function rationalise-dot(){
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}

zle -N rationalise-dot
bindkey . rationalise-dot


extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1    ;;
            *.tar.gz)  tar xvzf $1    ;;
            *.tar.xz)  tar xvJf $1    ;;
            *.bz2)     bunzip2 $1     ;;
            *.rar)     unrar x $1     ;;
            *.gz)      gunzip $1      ;;
            *.tar)     tar xvf $1     ;;
            *.tbz2)    tar xvjf $1    ;;
            *.tgz)     tar xvzf $1    ;;
            *.zip)     unzip $1       ;;
            *.Z)       uncompress $1  ;;
            *.7z)      7z x $1        ;;
            *.lzma)    lzma -dv $1    ;;
            *.xz)      xz -dv $1      ;;
            *) echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

case "${OSTYPE}" in
# linux ----------------------------
linux*)
    HISTFILE=~/.log/.zshistry
    alias l='ls --color -F'
    alias la='ls --color -a'
    alias ll='ls --color -al'
    alias ls='ls --color'
    alias td='todo.sh'
    alias rm='trash-put -i'
    alias myhome='sudo netcfg myhome'
    alias dropboxw='sh $HOME/dict/dropbox/auto_dropbox.sh'
    alias mbplack='cd /home/gylfe/git/tools/markdown-binder && plackup'
    alias gentoo!='su - && mount /dev/sda? /mnt/gentoo
                 \ mount -t proc none /mnt/gentoo/proc
                 \ mount --rbind /dev /mnt/gentoo/dev
                 \ chroot /mnt/gentoo /bin/zsh'
    alias ,doc='cd ~/dict/dropbox/code/Dropbox/docs && ls -a'
    alias ,code='cd ~/dict/dropbox/code/Dropbox && ls -a'
    alias ,pri='cd ~/dict/dropbox/private/Dropbox && ls -a'
    alias bmouse='sudo hidd --connect 00:07:61:F4:E7:68'
    alias iron='iron --disk-cache-dir=/tmp/cache'

    # For coding
    alias study='vim ~/dict/script/ruby/sample/tmp.rb'
    alias ,script='cd ~/dict/script/ruby/sample'
    ;;
# cygwin ----------------------------
cygwin*)
    ;;
darwin*)
    HISTFILE=~/var/log/zshistory
    alias l='ls -GF'
    alias la='ls -GF -a'
    alias ll='ls -GF -al'
    alias ls='ls -GF'
    ;;
esac

# Key Binding ------------------------
bindkey -v

# Completement -----------------------
autoload -U compinit; compinit  # 補完有効化
setopt auto_cd
setopt auto_list
setopt auto_menu                # TABで補完候補切り替え
setopt auto_param_keys          # ()等の自動補完
setopt auto_param_slash
setopt auto_pushd
setopt pushd_ignore_dups        # 同じディレクトリをpushdしない
setopt pushd_minus
setopt complete_in_word
setopt correct
setopt glob_complete
setopt hist_expand
setopt list_packed
setopt list_types
setopt magic_equal_subst        # --prefix=/usr等の=以降も補完
setopt mark_dirs                # add / last of directoey
setopt no_beep
setopt noautoremoveslash
setopt nolistbeep
setopt nonomatch                # よう分からんが no matches foundと怒られるんで
setopt notify                   # notify end states of background job
setopt numeric_glob_sort
setopt print_eight_bit          # 日本語ファイル名等, 8bitを通す

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # 補完候補に色付け
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 補完時に文字の大小を区別しない
## 補完方法の設定:指定した順に実行
### _oldlist:前回の補完候補を利用 _complete:補完する _match:glob展開なし
### _ignored:除外対象も補完候補に _approximate:似ているものも補完候補に
### _prefix:カーソル以降を無視してカーソル位置まで補完
zstyle ':completion:*' completer _oldlist _complete _match _ignored _approximate _prefix
zstyle ':completion:*' use-cache yes  # 補完候補をキャッシュする
zstyle ':completion:*' verbose yes  # 補完の詳細な表示


# History Search ------------------
setopt extended_history      # zshの起動と終了時刻をhistoryに書き込む
setopt hist_ignore_all_dups  # 既にhistoryにあるCLは古い方を削除
setopt hist_ignore_dups      # 直前と同じCLはhistoryぶ追加しない
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify           # historyを確定前に編集
setopt inc_append_history
setopt share_history         # zshプロセス間でヒストリ共有
setopt bang_hist             # !を使ったヒストリ展開

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end


# Prompt ----------------------------
autoload -Uz promptinit: promptinit
setopt   prompt_subst
autoload -U colors; colors

function _judgement_precmd {
    
    # prompt color (red if root) :
    case ${UID} in
        0    ) color=$fg_bold[red] ;;
        1000 ) color=$fg_bold[blue] ;;
        *    ) color=$fg_bold[yellow] ;;
    esac

    PROMPT="%{$color%}%n%# "
    RPROMPT="%{${fg[white]}%}%~%{${reset_color}%}"
    SPROMPT="correct: %R -> %r ? "

[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
    PROMPT="%{${fg[magenta]}%}${HOST%%.*} ${PROMPT}"
;

}

add-zsh-hook precmd _judgement_precmd

# terminal configuration

unset  LSCOLORS
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export CLICOLOR=true

# Autoload ------------------------
#autoload predict-on
#predict-on
autoload zed   # light editor

# function chpwd(){
#     ls -a --color
# }

# google 検索期間を指定(y,w,h,m)
function google-time() {
    w3m "http://www.google.co.jp/search?num=50&hl=ja&lr=lang_ja&q=$2&tbs=qdr:${1}"
}

# command stack for <C-q>
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack
setopt no_flow_control
bindkey '^Q' show_buffer_stack

# for directory stack
function dir() {
    if [ -z "$1" ]; then
        dirs -pv
    else
        dirs -pv | fgrep "$1"
    fi
}


# Git wrapper `gem install hub`
if [ -x "`which hub 2> /dev/null`" ]; then
    alias git=hub
else
    alias git=git
fi

[ -f ~/.zsh/.zshrc.alt ] && source ~/.zsh/.zshrc.alt
[ -f ~/.zsh/.zshrc.pass ] && source ~/.zsh/.zshrc.pass


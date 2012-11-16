#!/bin/zsh
# This is load after .zshenv

# base setting --------------------
HISTSIZE=4096
HISTFILE=~/.log/.zshistry
SAVEHIST=16384
setopt   extended_glob         # glob機能拡張
unsetopt caseglob              # ファイルグロブで大小非区別

# REPORTTIME=5  # 5秒以上かかった処理の詳細表示

# Lang ----------------------------
export LANG=ja_JP.UTF-8
export LC_CTYPE="ja_JP.UTF-8"
export LC_TIME="en_US.UTF-8"


# Alias -- modified commands -------
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias c='clear'
alias cp='cp --interactive'
alias diff='colordiff'
alias grep='grep --color=auto'
alias la='ls -a --color'
alias less='less -R'
alias ll='ls -al --color'
alias ls='ls --color'
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

    # For coding
    alias study='vim ~/dict/script/ruby/sample/tmp.rb'
    alias ,script='cd ~/dict/script/ruby/sample && ls -a --color'
    ;;
# cygwin ----------------------------
cygwin*)
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
setopt auto_pushd
setopt complete_in_word
setopt correct
setopt glob_complete
setopt hist_expand
setopt list_packed
setopt list_types
setopt magic_equal_subst        # --prefix=/usr等の=以降も補完
setopt mark_dirs                # add / last of directoey
setopt no_beep
setopt nolistbeep
setopt notify                   # notify end states of background job
setopt noautoremoveslash
setopt nonomatch                # よう分からんが no matches foundと怒られるんで
setopt numeric_glob_sort
setopt print_eight_bit          # 日本語ファイル名等, 8bitを通す
setopt pushd_ignore_dups        # 同じディレクトリをpushdしない

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # 補完候補に色付け
zstyle ':completion:*' verbose yes                   # 補完の表示を過剰にする 
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 補完時に文字の大小を区別しない


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

function precmd {
    
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

# terminal configuration

unset  LSCOLORS
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export CLICOLOR=true

# Autoload ------------------------
#autoload predict-on
#predict-on
autoload zed   # light editor


[ -f ~/.zsh/.zshrc.alt ] && source ~/.zsh/.zshrc.alt


# Git wrapper `gem install hub`
if [ -x "`which hub 2> /dev/null`" ]; then
    alias git=hub
else
    alias git=git
fi

# # git stash count
# function git_prompt_stash_count {
#   local COUNT=$(git stash list 2>/dev/null | wc -l | tr -d ' ')
#   if [ "$COUNT" -gt 0 ]; then
#     echo " ($COUNT)"
#   fi
# }
# 
# autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
# 
# function rprompt-git-current-branch {
#     local name st color action
# 
#     if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
#       return
#     fi
# 
#     name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
#     if [[ -z $name ]]; then
#       return
#     fi
# 
#     st=`git status 2> /dev/null`
#     if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#       color=${fg[blue]}
#     elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
#       color=${fg[yellow]}
#     elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
#       color=${fg_bold[red]}
#     else
#       color=${fg[red]}
#     fi
# 
#     gitdir=`git rev-parse --git-dir 2> /dev/null`
#     action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
# 
#     # %{...%} surrounds escape string
#     echo "%{$color%}$name$action`git_prompt_stash_count`$color%{$reset_color%}"
# }
# 
# # how to use
# PROMPT = "`rprompt-git-current-branch`"

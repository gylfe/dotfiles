#!/usr/bin/env zsh
#
## This is load after .zshenv
## Load when interactive
#
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
# watch="all"
# log

# Lang ----------------------------
export LANG=ja_JP.UTF-8
export LC_CTYPE="ja_JP.UTF-8"
export LC_TIME="en_US.UTF-8"

# Key Binding ------------------------
bindkey -v

# bindkey "^A" end-of-line
# bindkey "^I" beginning-of-line
# bindkey "^H" backward-char
# bindkey "^L" forward-char
# bindkey "^T" transpose-chars

# color configuration ----------
local DEFAULT=$'%{^[[m%]]}'$
local RED=$'%{^[[1;31m%]]}'$
local GREEN=$'%{^[[1;32m%]]}'$
local YELLOW=$'%{^[[1;33m%]]}'$
local BLUE=$'%{^[[1;34m%]]}'$
local PURPPLE=$'%{^[[1;35m%]]}'$
local LIGHT_BLUE=$'%{^[[1;36m%]]}'$
local WHITE=$'%{^[[1;37m%]]}'$

unset  LS_COLORS
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export CLICOLOR=true

# Completement -----------------------
autoload -U compinit; compinit  # 補完有効化
setopt auto_cd
setopt auto_list
setopt auto_menu                # TABで補完候補切り替え
setopt auto_param_keys          # ()等の自動補完
setopt auto_param_slash
setopt auto_pushd
setopt brace_ccl                # mkdir {1-3} -> make folder 1,2,3
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
setopt pushd_ignore_dups        # 同じディレクトリをpushdしない
setopt pushd_minus

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # 補完候補に色付け
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # 補完時に文字の大小を区別しない
## 補完方法の設定:指定した順に実行
### _oldlist:前回の補完候補を利用 _complete:補完する _match:glob展開なし
### _ignored:除外対象も補完候補に _approximate:似ているものも補完候補に
### _prefix:カーソル以降を無視してカーソル位置まで補完
zstyle ':completion:*' completer _oldlist _complete _match _history _ignored _approximate _prefix _list
zstyle ':completion:*' use-cache true  # 補完候補をキャッシュする
zstyle ':completion:*' verbose yes  # 補完の詳細な表示
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:cd:*' tag-order local-directories path-directories  # current directoryに候補がない場合のみcdpath上のdirectoryを候補にする
zstyle ':completion:sudo' environ PATH="$SUDO_PATH:$PATH"

zstyle ':completion:manuals' separete-sections true  # manの補完をセクション番号別に表示
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters  # 変数の添字を補完
zstyle ':completion:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:options' description 'yes'
zstyle ':completion:descriptions' format '%F{YELLOW}completing %B%d%b%f'$DEFAULT

zstyle ':completion:*' group-name ''


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


# Prompt ------------------------
autoload -Uz promptinit: promptinit
setopt   prompt_subst
setopt   prompt_percent
setopt   transient_rprompt
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
  SPROMPT="correct: %R -> %r ? (y/n/e/a)"

  # PROMPT2=""
  # PROMPT3=
  # PROMPT4=
  
[ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && PROMPT="%{$color%}%n${fg[yellow]}@${HOST%%.*}%# "
;

}

add-zsh-hook precmd _judgement_precmd


# Autoload ------------------------
#autoload predict-on
#predict-on
autoload zed   # light editor
autoload -Uz zmv

 
# chpwd() {
#     ls_abbrev
# }
# ls_abbrev() {
#     # -a : Do not ignore entries starting with ..
#     # -C : Force multi-column output.
#     # -F : Append indicator (one of */=>@|) to entries.
#     local cmd_ls='ls'
#     local -a opt_ls
#     opt_ls=('-aCF' '--color=always')
#     case "${OSTYPE}" in
#         freebsd*|darwin*)
#             if type gls > /dev/null 2>&1; then
#                 cmd_ls='gls'
#             else
#                 # -G : Enable colorized output.
#                 opt_ls=('-aCFG')
#             fi
#             ;;
#     esac
# 
#     local ls_result
#     ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')
# 
#     local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')
# 
#     if [ $ls_lines -gt 10 ]; then
#         echo "$ls_result" | head -n 5
#         echo '...'
#         echo "$ls_result" | tail -n 5
#         echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
#     else
#         echo "$ls_result"
#     fi
# }


rationalise-dot() {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
  else
    LBUFFER+=.
  fi
}

zle -N rationalise-dot
bindkey . rationalise-dot


extract() {
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


# cd for gir root directory
ccd() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cd `git rev-parse --show-toplevel`
  fi
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

chpath=(~)
chpwd_functions=($chpwd_functions dirs)

# Load configures ------------
[ -f ~/.zsh/conf/.zshrc.alias ] && source ~/.zsh/conf/.zshrc.alias
[ -f ~/.zsh/conf/.zshrc.alt ] && source ~/.zsh/conf/.zshrc.alt
[ -f ~/.zshrc.local ] && source ~/.zshrc.local


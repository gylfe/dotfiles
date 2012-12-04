#!/bin/zsh
##
## 端末ウィンドウタイトルと右プロンプトに這いよる混沌 (zsh)
## Written by SATOH Fumiyasu
##   https://github.com/fumiyas
##
## Inspired by:
##   http://www.kaoriya.net/blog/2012/04/18
##   http://www.manabii.info/2012/05/bash-wn.html

chaos=0
chaos() {
  let chaos="$chaos % 7"
  case "$chaos" in
  1|3|5)
    echo -n '(」・ω・)」うー！'
    ;;
  2|4|6)
    echo -n '(／・ω・)／にゃー！'
    ;;
  0)
    echo -n "Let's＼(・ω・)／にゃー！"
    ;;
  esac
}

# chaos_r=0
# chaos_r() {
#   let chaos_r="$chaos_r % 7"
#   case "$chaos_r" in
#   1|3|5)
#     echo -n 'うー！⎿(・ω・⎿)'
#     #echo -n 'うー！∠(・ω・∠)'
#     #echo -n 'うー！└(・ω・└)'
#     ;;
#   2|4|6)
#     echo -n 'にゃー！＼(・ω・＼)'
#     ;;
#   0)
#     echo -n "Let's＼(・ω・)／にゃー！"
#     ;;
#   esac
# }

function _unya_precmd() {
  let chaos++
  # let chaos_r++
  echo -n "\e]0;"; chaos; echo -n "\a";
  # RPROMPT=$(chaos_r)
}

if [ -n "$DISPLAY" ]; then
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _unya_precmd
fi


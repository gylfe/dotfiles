colorscheme molokai
set columns=128
set lines=35

set encoding=utf8

gui
set transparency=216


if has('multi_byte_ime') || has('xim')
    " 日本語入力ON時のカーソルの色を設定
    highlight CursorIM guibg=Purple guifg=NONE
endif

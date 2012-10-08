colorscheme molokai
set columns=128
set lines=35

if has('multi_byte_ime') || has('xim')
    " 日本語入力ON時のカーソルの色を設定
    highlight CursorIM guibg=Purple guifg=NONE
endif


gui
if has('win32')
    set transparency=210
elseif has('darwin')
else
    set guifont='Ricty for Powerline':h12:
    set guifontwide=Ricty for Powerline:h12
end"

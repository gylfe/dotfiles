colorscheme molokai

if has('multi_byte_ime') || has('xim')
  " 日本語入力ON時のカーソルの色を設定
  highlight CursorIM guibg=Purple guifg=NONE
endif


if has('win32')
  set columns=128
  set lines=35
  set transparency=210
elseif has('macunix')
  set antialias
  set guifont=Ricty_for_Powerline:h14
  set guifontwide=Ricty_for_Powerline:h14
  set guioptions-=T
  set imdisable
  set lines=28 columns=100
  set transparency=10
  set visualbell t_vt=
else
  set guifont=Ricty_for_Powerline:h14:cSHIFTJIS
  set guifontwide=Ricty_for_Powerline:h14:cSHIFTJIS
end

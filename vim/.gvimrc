colorscheme molokai

if has('multi_byte_ime') || has('xim')
  " 日本語入力ON時のカーソルの色を設定
  highlight CursorIM guibg=Purple guifg=NONE
endif


if has('win32')
  set columns=128
  set lines=35
  set cmdheight=1
  set transparency=210
elseif has('gui_macvim')
  set antialias
  set guifont=Ricty_for_Powerline:h18
  set guifontwide=Ricty_for_Powerline:h18
  set cmdheight=1
  set imdisable
  " set noimdisableactivate
  set lines=28 columns=100
  set transparency=10
  set visualbell t_vt=

  set guioptions-=T
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L
else
  set guifont=Ricty_for_Powerline:h14:cSHIFTJIS
  set guifontwide=Ricty_for_Powerline:h14:cSHIFTJIS
end

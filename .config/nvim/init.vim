" begin /home/cjd/.config/nvim/init.vim

set nocompatible
syntax on
set number
set tabstop=8
set nohls
set columns=80
set textwidth=80
set ruler
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
if (&term == "iterm") || (&term == "putty")
  set background=dark
endif

" end /home/cjd/.config/nvim/init.vim

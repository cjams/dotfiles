
set nocompatible
syntax on

set ruler
set nohls
set relativenumber
set number
set autoindent
set confirm

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

colorscheme lettuce

fun! <SID>strip_trailing_whitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>strip_trailing_whitespace()

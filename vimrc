
set nocompatible
syntax on
filetype plugin indent on

set ruler
set nohls
set relativenumber
set number
set autoindent
set confirm
set title
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

colorscheme lettuce

fun! <SID>strip_trailing_whitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>strip_trailing_whitespace()

inoremap nn <ESC>
let mapleader=","

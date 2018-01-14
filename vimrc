
set shell=/bin/bash
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Yggdroot/LeaderF'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'

call vundle#end()
filetype plugin indent on
syntax on

set updatetime=250
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

set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" set grep program
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

if $TERM != "linux"
    colorscheme lettuce
else
    colorscheme slate
endif

fun! <SID>strip_trailing_whitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>strip_trailing_whitespace()

let g:lsp_async_completion=1
if (executable('clangd'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'h']
        \ })
endif

inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"

let mapleader=","

inoremap <leader>f <esc>
vnoremap <leader>f <esc>

" default search tool for LeaderF
let g:Lf_DefaultExternalTool = 'ag'

" default search mode for LeaderF
let g:Lf_DefaultMode = 'FullPath'

" set LeaderF colorscheme
let g:Lf_StlColorscheme = 'powerline'

" set LeaderF shortcut for searching files
let g:Lf_ShortcutF = '<leader>c'

" set LeaderF shortcut for searching buffer
let g:Lf_ShortcutB = '<leader>b'

let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.hg','build/*'],
    \ 'file': ['*.bak','*.o','*.so','*.py[co]']
\ }

" remap window navigation
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" remap split-orientation toggle
nnoremap <leader>wv <c-w>H
nnoremap <leader>wf <c-w>K

" remap tab creation
nnoremap <leader>t :tabedit<cr>

" remap quit
nnoremap <leader>d :q<cr>

" remap write
nnoremap <leader>s :w<cr>

" remap write then close
nnoremap <leader>sd :wq<cr>

" remap fugitive
nnoremap <leader>gw :Gwrite
nnoremap <leader>gr :Gread
nnoremap <leader>gm :Gmove
nnoremap <leader>gc :Gcommit
nnoremap <leader>gs :Gstatus
nnoremap <leader>gd :Gdiff

 " remap ack
 nnoremap <leader>a :Ack<space>

 " goto file under cursor
 nnoremap gf :vertical wincmd f<cr>

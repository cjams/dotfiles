
" vundle block ------------------------------------------------------------{{{
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
Plugin 'majutsushi/tagbar'

call vundle#end()

filetype plugin indent on
syntax on

" }}}

" config variables -----------------------------------------------------------{{{
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
set makeprg=ninja

" set grep program
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
" }}}

" colorscheme -----------------------------------------------------------{{{

if $TERM != "linux"
    colorscheme lettuce
else
    colorscheme slate
endif

" }}}

" functions ---------------------------------------------------------------{{{
fun! <SID>strip_trailing_whitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    %s///e
    %s///e
    %s///e
    call cursor(l, c)
endfun
" }}}

" augroups ----------------------------------------------------------------{{{
augroup format
    autocmd!
    autocmd BufWritePre * :call <SID>strip_trailing_whitespace()
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_cpp
    autocmd!
    autocmd FileType cpp setlocal foldmethod=diff
augroup END
" }}}

" plugin variables --------------------------------------------------------{{{
let g:lsp_async_completion=1
if (executable('clangd'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'whitelist': ['c', 'cpp', 'h']
        \ })
endif

let g:syntastic_shell = "/bin/bash"

let g:ale_fixers = {
        \ 'c': ['clang-format'],
        \ 'cpp': ['clang-format']
\ }

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

" nerdcommenter configs
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDTrimTrailingWhitespace = 1
" }}}

" key mappings ------------------------------------------------------------{{{
let mapleader=","

""" edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

""" append semicolon
nnoremap <leader>as mqA;<esc>`q

""" make aw uppercase
inoremap <leader><c-u> <esc>vawUi
nnoremap <leader><c-u> vawU<esc>

nnoremap <F8> :TagbarToggle<CR>
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"

inoremap <leader>j <esc>
vnoremap <leader>j <esc>

" remap quit
nnoremap <leader>d :q<cr>

" remap write
nnoremap <leader>s :w<cr>

" remap write and close
nnoremap <leader>jsd <esc>:wq<cr>

" nops
inoremap <esc> <nop>
inoremap :w<cr>    <nop>
inoremap :q<cr>    <nop>
nnoremap :w<cr>    <nop>
nnoremap :q<cr>    <nop>

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

" remap make
nnoremap <leader>m :make<cr>

" remap fugitive
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>

" }}}

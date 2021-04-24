
" vundle block ------------------------------------------------------------{{{
set shell=/bin/bash
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'wolf-dog/sceaduhelm.vim'
Plugin 'pprovost/vim-ps1'
Plugin 'kergoth/vim-bitbake'

call vundle#end()

filetype plugin indent on
syntax on

" }}}

" config variables -----------------------------------------------------------{{{
set exrc
set secure
set updatetime=250
set ruler
set nohls
set relativenumber
set number
set cindent
set confirm
set title
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab
set completeopt+=preview
set switchbuf=usetab
set wildmenu
set wildmode=full
set wildchar=<Tab>

" set grep program
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
" }}}

" colorscheme -----------------------------------------------------------{{{

if $TERM != "linux"
    colorscheme sceaduhelm
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

augroup filetype_go
    autocmd!
    autocmd FileType go setlocal noexpandtab tabstop=8 shiftwidth=8 autoindent
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

au BufNewFile,BufRead /tmp/*mutt* setlocal tw=72 noautoindent filetype=mail

" }}}

" plugin variables --------------------------------------------------------{{{

" }}}

" key mappings ------------------------------------------------------------{{{
let mapleader=","

""" edit and source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>sb :sb

""" append semicolon
nnoremap <leader>as mqA;<esc>`q

""" make aw uppercase
inoremap <leader><c-u> <esc>vawUi
nnoremap <leader><c-u> vawU<esc>

""" buffer list
nnoremap <F5> :buffers<cr>:buffer<space>

set wildcharm=<c-z>
nnoremap <F6> :b <c-z>

" remap esc
inoremap <leader>e <esc>
vnoremap <leader>e <esc>

" remap quit/write
nnoremap <leader>d :q<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>sd :wq<cr>

" nops
inoremap <esc> <nop>
inoremap <esc>:w<cr> <nop>
inoremap <esc>:q<cr> <nop>
nnoremap :w<cr> <nop>
nnoremap :q<cr> <nop>

" remap window navigation
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" remap split-orientation toggle
nnoremap <leader>wv <c-w>H
nnoremap <leader>wf <c-w>K

" remap tab creation
" nnoremap <leader>t :tabedit<cr>

" remap make
nnoremap <leader>m :make<cr>

" remap vim-fugitive
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>

" }}}

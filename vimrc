
" vundle block ------------------------------------------------------------{{{
set shell=/bin/bash
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Plugin 'Yggdroot/LeaderF'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'mileszs/ack.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'pdavydov108/vim-lsp-cquery'
Plugin 'majutsushi/tagbar'
Plugin 'w0rp/ale'
Plugin 'rhysd/vim-clang-format'

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
set completeopt+=preview

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
"    autocmd FileType c,cpp,h map <buffer><Leader>x <Plug>(operator-clang-format)
    autocmd FileType c,cpp,h nnoremap <leader>cf :<c-u>ClangFormat<cr>
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_cpp
    autocmd!
    autocmd FileType cpp,c,h setlocal foldmethod=diff
augroup END
" }}}

" plugin variables --------------------------------------------------------{{{

let g:lsp_async_completion = 1

if (executable('cquery'))
    au User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': { 'cacheDirectory': '/home/cjd/cquery/cache' },
        \ 'whitelist': ['c', 'cpp', 'h'],
        \ })
endif

" ack setttings
let g:ackprg = "ag --vimgrep"

" ale setttings
let g:ale_completion_enabled = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0

let g:ale_fixers = {
    \ 'c': ['clang-format'],
    \ 'cpp': ['clang-format']
\ }

let g:ale_linters = {
    \ 'c': ['clang-tidy'],
    \ 'cpp': ['clang-tidy']
\ }

let g:ale_asm_gcc_options = 'nasm -f elf64'

" default search tool for LeaderF
" let g:Lf_DefaultExternalTool = 'ag'
"
" " default search mode for LeaderF
" let g:Lf_DefaultMode = 'FullPath'
"
" " set LeaderF colorscheme
" let g:Lf_StlColorscheme = 'powerline'
"
" " set LeaderF shortcut for searching files
" let g:Lf_ShortcutF = '<leader>l'

" set LeaderF shortcut for searching buffer
" let g:Lf_ShortcutB = '<leader>b'

" let g:Lf_WildIgnore = {
"     \ 'dir': ['.svn','.git','.hg','build/*'],
"     \ 'file': ['*.bak','*.o','*.so','*.py[co]']
" \ }

" nerdcommenter configs
" let g:NERDSpaceDelims = 1
" let g:NERDRemoveExtraSpaces = 1
" let g:NERDTrimTrailingWhitespace = 1

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

""" ale maps
nnoremap <leader>af :ALEFix<cr>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

""" tagbar key
nnoremap <F8> :TagbarToggle<CR>

""" asyncomplete
inoremap <expr> <tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<cr>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

""" vim-lsp
nnoremap <leader>ln :LspRename<cr>
nnoremap <leader>ld :LspDefinition<cr>
nnoremap <leader>lr :LspReferences<cr>

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

" remap vim-dispatch
nnoremap <leader>fh :Dispatch cmake --build ~/bareflank/build-hypervisor<cr>
nnoremap <leader>fhb :Dispatch! cmake --build ~/bareflank/build-hypervisor<cr>
nnoremap <leader>fht :Dispatch ninja -f ~/bareflank/build-hypervisor/build.ninja test<cr>

nnoremap <leader>fe :Dispatch cmake --build ~/bareflank/build-eapis<cr>
nnoremap <leader>feb :Dispatch! cmake --build ~/bareflank/build-eapis<cr>
nnoremap <leader>fet :Dispatch ninja -f ~/bareflank/build-eapis/build.ninja test<cr>

" }}}

" local sourcings ------------------------------------------------------------{{{
if filereadable(expand('~/bareflank/vimrc'))
    source ~/bareflank/vimrc
endif
" }}}

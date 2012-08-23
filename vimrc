" This must be first, because it changes other options as side effect
set nocompatible

let g:snippets_dir="~/.vim/snippets.rsrchboy,~/.vim/snippets,~/.vim/bundle/snipmate.vim/snippets"
runtime vim-pathogen/autoload/pathogen.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pathogen bits

"filetype off
"syntax off
call pathogen#infect()
syntax on
filetype plugin indent on
Helptags

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" additional filetypes

au BufNewFile,BufRead *.psgi  set filetype=perl
au BufNewFile,BufRead *.tt    set filetype=tt2html
au BufNewFile,BufRead *.tt2   set filetype=tt2html
au BufNewFile,BufRead Changes set filetype=changelog

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc mappings

" for tagbar
nnoremap <leader>l :TagbarToggle<CR>
nnoremap <leader>o :TagbarOpenAutoClose<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" settings

set modeline
set modelines=2
set number
set sm
set scs
set title
set incsearch
set hidden
set laststatus=2
set autoread                   " reload when changed -- e.g. 'git co ...'
set encoding=utf-8             " Necessary to show Unicode glyphs
set t_Co=256                   " Explicitly tell Vim we can handle 256 colors
set autoindent                 " Preserve current indent on new lines
set textwidth=78               " Wrap at this column
set backspace=indent,eol,start " Make backspaces delete sensibly
set tabstop=4                  " Indentation levels every four columns
set expandtab                  " Convert all tabs typed to spaces
set shiftwidth=4               " Indent/outdent by four columns
set shiftround                 " Indent/outdent to nearest tabstop
set matchpairs+=<:>            " Allow % to bounce between angles too
set smartcase
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set background=dark
"colorscheme zellner
"set nonu

" ignore carton's 'local/'
"set wildignore+=local/**
"set wildignore+=extlib/**

" make trailing whitespace look really annoying
match Todo /\s\+$/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" woo, themes!

colorscheme oh-la-la

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc bundle settings
"let g:gist_detect_filetype = 1
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_post_private = 1
let g:Powerline_symbols = 'fancy'
"let g:Powerline_theme   = 'skwp'
let g:git_no_map_default = 1 " don't install default mappings from git-vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git (fugitive) mappings and config

" this is a cross between the old git-vim commands I'm used to, but invoking
" fugitive instead.

nnoremap <Leader>gs :Gstatus<Enter>
nnoremap <Leader>gd :Git diff --word-diff %<Enter>
nnoremap <Leader>ga :Gwrite<Enter>
nnoremap <Leader>gc :Gcommit<Enter>
nnoremap <Leader>gf :Git fixup<Enter>

nnoremap <Leader>gD :Git! diff --word-diff %<Enter>

"nnoremap <Leader>gD :GitDiff --cached<Enter>
"nnoremap <Leader>gl :GitLog<Enter>
"nnoremap <Leader>gA :GitAdd <cfile><Enter>
"nnoremap <Leader>gp :GitPullRebase<Enter>
"nnoremap <Leader>gb :GitBlame<Enter>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl testing

" need to figure out how to map the 'base' perl directory
map ,t :!perl -I lib/ %<CR>
map ,T :!prove -I lib/ -r <CR>
map ,p :!perldoc %<CR>

nnoremap <leader>T :n t/%<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" magic!

" When vimrc is edited, reload it
autocmd! bufwritepost ~/.vimrc source ~/.vimrc
autocmd! bufwritepost ~/.vim/vimrc source ~/.vim/vimrc


" any machine-specific settings
source ~/.vimrc.local


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ATTIC

" -- moved to attic when we adopted powerline
" statusline with pretty git bits
"set statusline=%-10([%n%H%M%R%W]%)\ %y%*%*%#StatusLineNC#\ %#ErrorMsg#\ %{GitBranchInfoTokens()[0]}\ %#StatusLine#\ %f%=%P\ %10((%l-%c/%L)%)


"if !exists('g:git_no_map_default') || !g:git_no_map_default
    "nnoremap <Leader>gd :GitDiff<Enter>
    "nnoremap <Leader>gD :GitDiff --cached<Enter>
    "nnoremap <Leader>gs :GitStatus<Enter>
    "nnoremap <Leader>gl :GitLog<Enter>
    "nnoremap <Leader>ga :GitAdd<Enter>
    "nnoremap <Leader>gA :GitAdd <cfile><Enter>
    "nnoremap <Leader>gc :GitCommit<Enter>
    "nnoremap <Leader>gp :GitPullRebase<Enter>
    "nnoremap <Leader>gb :GitBlame<Enter>
"endif

" This must be first, because it changes other options as side effect
set nocompatible

let g:snippets_dir="~/.vim/snippets.rsrchboy,~/.vim/snippets,~/.vim/bundle/snipmate.vim/snippets"
runtime vim-pathogen/autoload/pathogen.vim

"filetype off
"syntax off
call pathogen#infect()
syntax on
filetype plugin indent on
Helptags

au BufNewFile,BufRead *.psgi  set filetype=perl
au BufNewFile,BufRead *.tt    set filetype=tt2html
au BufNewFile,BufRead *.tt2   set filetype=tt2html
au BufNewFile,BufRead Changes set filetype=changelog

" for tagbar
nnoremap <leader>l :TagbarToggle<CR>
nnoremap <leader>o :TagbarOpenAutoClose<CR>

set modeline
set modelines=2

set number
set sm
set scs
set title
set incsearch

set nohidden
set hidden

" ignore carton's 'local/'
set wildignore+=local/**
set wildignore+=extlib/**

" make trailing whitespace look really annoying
match Todo /\s\+$/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl testing

" need to figure out how to map the 'base' perl directory
map ,t :!perl -I lib/ %<CR>
map ,T :!prove -I lib/ -r <CR>
map ,p :!perldoc %<CR>

" statusline with pretty git bits
set laststatus=2
set statusline=%-10([%n%H%M%R%W]%)\ %y%*%*%#StatusLineNC#\ %#ErrorMsg#\ %{GitBranchInfoTokens()[0]}\ %#StatusLine#\ %f%=%P\ %10((%l-%c/%L)%)
let g:Powerline_symbols = 'fancy'

" Set to auto read when a file is changed from the outside
set autoread

set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors

" When vimrc is edited, reload it
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

"colorscheme zellner
set background=dark
"set nonu

set autoindent                    "Preserve current indent on new lines
set textwidth=78                  "Wrap at this column
set backspace=indent,eol,start    "Make backspaces delete sensibly

set tabstop=4                     "Indentation levels every four columns
set expandtab                     "Convert all tabs typed to spaces
set shiftwidth=4                  "Indent/outdent by four columns
set shiftround                    "Indent/outdent to nearest tabstop

set matchpairs+=<:>               "Allow % to bounce between angles too

" any machine-specific settings
source ~/.vimrc.local

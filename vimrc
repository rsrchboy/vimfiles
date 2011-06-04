" Needed on some linux distros.
" " see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
" filetype off
" call pathogen#helptags()
" call pathogen#runtime_append_all_bundles()
" properly load all our other plugins under ~/.vim/bundle
call pathogen#infect()

set number
set sm
set scs
set title
set incsearch

set nohidden
set hidden

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

" Set to auto read when a file is changed from the outside
set autoread

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
set textwidth=100                 "Wrap at this column
set backspace=indent,eol,start    "Make backspaces delete sensibly

set tabstop=4                     "Indentation levels every four columns
set expandtab                     "Convert all tabs typed to spaces
set shiftwidth=4                  "Indent/outdent by four columns
set shiftround                    "Indent/outdent to nearest tabstop

set matchpairs+=<:>               "Allow % to bounce between angles too

" any machine-specific settings
source ~/.vimrc.local

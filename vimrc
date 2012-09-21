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
" this usually works, but sometimes vim thinks it's not perl
au BufNewFile,BufRead *.t     set filetype=perl

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc mappings

" for tagbar
nnoremap <leader>l :TagbarToggle<CR>
nnoremap <leader>o :TagbarOpenAutoClose<CR>
" open easybuffer
nnoremap ,b :EasyBuffer<CR>
" strip line, file of trailing whitespace
nnoremap ,w :s/ *$//<CR>
"nnoremap ,w !perl -pi -e "'s/\s*\n/\n/'" %<CR>
nnoremap ,W :%s/ *$//<CR>

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
set nobackup                   " we're stashing everything in git, anyways
set noswapfile
set lazyredraw
"set nonu

" PF key remappings
set pastetoggle=<F2>
nnoremap <F3> :set nonumber!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" woo, themes!

colorscheme oh-la-la
"colorscheme solarized
"colorscheme zellner

" make trailing whitespace look really annoying
match Todo /\s\+$/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" powerline segments

"call Pl#Theme#RemoveSegment('lineinfo')
"call Pl#Theme#RemoveSegment('fileformat')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc bundle settings
"let g:Powerline_theme            = 'skwp'
let g:gist_detect_filetype        = 1
let g:gist_clip_command           = 'xclip -selection clipboard'
let g:gist_post_private           = 1
let g:gist_show_privates          = 1
let g:gist_get_multiplefile       = 1
let g:Powerline_symbols           = 'fancy'
let g:git_no_map_default          = 1
let g:GPGPreferArmor              = 1
let g:GPGDefaultRecipients        = ["cweyl@alumni.drew.edu"]
let g:bufExplorerShowRelativePath = 1
let g:Gitv_TruncateCommitSubjects = 1


let g:tagbar_type_perl = {
    \ 'sort' : 1,
    \ 'deffile' : '$HOME/.vim/ctags.perl',
    \ 'kinds' : [
        \ 'p:packages:1:0',
        \ 'u:uses:1:0',
        \ 'c:constants:0:0',
        \ 'f:formats:0:0',
        \ 'e:extends',
        \ 'r:roles:1:0',
        \ 'a:attributes',
        \ 's:subroutines',
        \ 'l:labels',
    \ ],
\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git (fugitive) mappings and config

" this is a cross between the old git-vim commands I'm used to, but invoking
" fugitive instead.

nnoremap <Leader>gs :Gstatus<Enter>
nnoremap <Leader>gd :call Gitv_OpenGitCommand("diff --no-color --cached", 'new')<CR>
nnoremap <Leader>gD :call Gitv_OpenGitCommand("diff --no-color %", 'new')<CR>
nnoremap <Leader>ga :Gwrite<Enter>
nnoremap <Leader>gc :Gcommit<Enter>
nnoremap <Leader>gf :Git fixup<Enter>

nnoremap <Leader>gA :Git add -pi %<Enter>
nnoremap <Leader>gl :Git lol<Enter>
nnoremap <Leader>gD :Git! diff --word-diff %<Enter>
nnoremap <Leader>gp :Git push<Enter>

nnoremap <leader>gv :Gitv --all<cr>
nnoremap <leader>gV :Gitv! --all<cr>
vnoremap <leader>gV :Gitv! --all<cr>

" not yet replaced
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
" vim-pipe filetype configuration

autocmd FileType perl let b:vimpipe_command  = "perl -I lib/ -"
autocmd FileType perl let b:vimpipe_filetype = "perl.tap"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" magic!

" When vimrc is edited, reload it
autocmd! bufwritepost ~/.vimrc source ~/.vimrc
autocmd! bufwritepost ~/.vim/vimrc source ~/.vim/vimrc


" any machine-specific settings
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ATTIC

" ignore carton's 'local/'
"set wildignore+=local/**
"set wildignore+=extlib/**

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

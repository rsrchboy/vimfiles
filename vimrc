" This must be first, because it changes other options as side effect
set nocompatible

runtime bundle/vim-pathogen/autoload/pathogen.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pathogen bits

execute pathogen#infect()
filetype plugin indent on
Helptags


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colors, syntax, etc

let g:solarized_termtrans = 1
"let g:Powerline_theme      = 'skwp'
"let g:solarized_termcolors = 256 " needed on terms w/o solarized palette
colorscheme solarized
syntax on

" vim-signify
highlight clear SignColumn


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" additional filetypes

au BufNewFile,BufRead *.psgi      set filetype=perl
au BufNewFile,BufRead cpanfile    set filetype=perl
au BufNewFile,BufRead *.tt        set filetype=tt2html
au BufNewFile,BufRead *.tt2       set filetype=tt2html
au BufNewFile,BufRead Changes     set filetype=changelog
au BufNewFile,BufRead *.zsh-theme set filetype=zsh

" this usually works, but sometimes vim thinks it's not perl
au BufNewFile,BufRead *.t         set filetype=perl

" hub pull requests follow the same general pattern as a git commit message
"au BufNewFile,BufRead .git/PULLREQ_EDITMSG set filetype=gitcommit

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
set nostartofline              " try to preserve column on motion commands
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
set splitright                 " open new vsplit to the right
set smartcase
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set background=dark
set nobackup                   " we're stashing everything in git, anyways
set noswapfile
"set lazyredraw
set ttyfast

" XXX spell checking! probably need to turn this off for specific filetypes
"setlocal spell spelllang=en_us

" PF key remappings
set pastetoggle=<F2>

" normal mode remappings
nnoremap <F3> :setlocal nonumber!<CR>
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>
nnoremap <F7> :tabp<CR>
nnoremap <F8> :tabn<CR>

" visual/insert mode remappings
vnoremap <F3> :setlocal nonumber!<CR>
vnoremap <F5> :setlocal spell! spelllang=en_us<CR>
vnoremap <F7> :tabp<CR>
vnoremap <F8> :tabn<CR>

" Save with sudo if you're editing a readonly file in #vim
" https://twitter.com/octodots/status/196996096910827520
cmap w!! w !sudo tee % >/dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" powerline segments

"call Pl#Theme#RemoveSegment('lineinfo')
"call Pl#Theme#RemoveSegment('fileformat')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc bundle settings

let g:snippets_dir='~/.vim/snippets,~/.vim/bundle/snipmate.vim/snippets' " ,~/.vim/bundle/*/snippets

let g:gist_detect_filetype        = 1
let g:gist_clip_command           = 'xclip -selection clipboard'
let g:gist_post_private           = 1
let g:gist_show_privates          = 1
let g:gist_get_multiplefile       = 1
let g:Powerline_symbols           = 'fancy'
let g:git_no_map_default          = 1
let g:bufExplorerShowRelativePath = 1
let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_CommitStep             = 150
" TODO need to highlight TBD appropriately, too
let g:tlTokenList                 = ['FIXME', 'XXX', 'TODO', 'TBD' ]

" github-style ``` markups -- for vim-markup bundle
let g:markdown_github_languages = ['perl', 'ruby', 'erb=eruby']

" TODO need to handle "normal" sign column
let g:signify_sign_color_inherit_from_linenr = 1
let g:signify_skip_filetype = { 'gitcommit': 1 }

" CtrlP plugin config
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags configuration

let g:tagbar_type_perl = {
    \ 'sort' : 1,
    \ 'deffile' : '$HOME/.vim/ctags/perl',
    \ 'kinds' : [
        \ 'p:packages:1:0',
        \ 'u:uses:1:0',
        \ 'c:constants:0:0',
        \ 'R:readonly:0:0',
        \ 'f:formats:0:0',
        \ 'e:extends',
        \ 'r:roles:1:0',
        \ 'a:attributes',
        \ 's:subroutines',
        \ 'l:labels',
    \ ],
\ }

let g:tagbar_type_puppet = {
    \ 'sort' : 1,
    \ 'ctagstype': 'puppet',
    \ 'deffile' : '$HOME/.vim/ctags/puppet',
    \ 'kinds' : [
        \ 'c:class:0:0',
        \ 's:site:0:0',
        \ 'n:node:0:0',
        \ 'd:definition:0:0',
    \ ],
\ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: vim-gnupg options, etc

let g:GPGPreferArmor       = 1
let g:GPGDefaultRecipients = ["cweyl@alumni.drew.edu"]

"   g:GPGFilePattern
"
"     If set, overrides the default set of file patterns that determine
"     whether this plugin will be activated.  Defaults to
"     '*.\(gpg\|asc\|pgp\)'.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: fugitive (git) mappings and config

" this is a cross between the old git-vim commands I'm used to, but invoking
" fugitive instead.

nnoremap <Leader>gs :Gstatus<Enter>
nnoremap <Leader>gd :call Gitv_OpenGitCommand("diff --no-color", 'new')<CR>
nnoremap <Leader>gD :call Gitv_OpenGitCommand("diff --no-color --cached %", 'new')<CR>
nnoremap <Leader>ga :Gwrite<Enter>
nnoremap <Leader>gc :Gcommit<Enter>
" XXX trial run here
"nnoremap <Leader>gf :Git fixup<Enter>
nnoremap <Leader>gf :call RunGitFixup()<CR>


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

"map <leader>gs :Gstatus<cr>
"map <leader>gc :Gcommit<cr>
"map <leader>ga :Git add --all<cr>:Gcommit<cr>
"map <leader>gb :Gblame<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This section very happily stolen from:
" https://github.com/aaronjensen/vimfiles/blob/master/vimrc

" Use j/k in status
function! BufReadIndex()
  setlocal cursorline
  setlocal nohlsearch

  nnoremap <buffer> <silent> j :call search('^#\t.*','W')<Bar>.<CR>
  nnoremap <buffer> <silent> k :call search('^#\t.*','Wbe')<Bar>.<CR>
endfunction

autocmd BufReadCmd *.git/index exe BufReadIndex()
autocmd BufEnter *.git/index silent normal gg0j

" Start in insert mode for commit
function! BufEnterCommit()
  setlocal nonumber
  setlocal spell spelllang=en_us
  normal gg0
  if getline('.') == ''
    start
  end
endfunction
"autocmd BufEnter *.git/*_EDITMSG exe BufEnterCommit()
autocmd BufEnter *.git/COMMIT_EDITMSG exe BufEnterCommit()
autocmd BufEnter .git/PULLREQ_EDITMSG set filetype=gitcommit

" Automatically remove fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vitra - Trac UI for ViM (bundle config)

" most of our trac server configuration will be done in ~/.vimrc.local
" so as to prevent userids and passwords from floating about :)

let g:tracServerList   = {}
let g:tracTicketClause = 'owner=cweyl&status!=closed' " default: 'status!=closed'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Perl testing


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Inline block manipulation (e.g. prettification)

" prettify a section of json
command -range -nargs=* Tidy <line1>,<line2>! json_xs -f json -t json-pretty

command -range -nargs=* MXRCize <line1>,<line2>perldo perldo return unless /$NS/; s/$NS([A-Za-z0-9:]+)/\$self->\l$1_class/; s/::(.)/__\l$1/g; s/([A-Z])/_\l$1/g

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" misc mappings

" for tagbar
nnoremap <leader>l :TagbarToggle<CR>
nnoremap <leader>o :TagbarOpenAutoClose<CR>

" for TaskList
map <leader>v <Plug>TaskList

nnoremap ,= :Tabularize /=><CR>
vnoremap ,= :Tabularize /=><CR>

" make C-PgUp and C-PgDn work, even under screen
" see https://bugs.launchpad.net/ubuntu/+source/screen/+bug/82708/comments/1
:nmap <ESC>[5;5~ <C-PageUp>
:nmap <ESC>[6;5~ <C-PageDown>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-pipe filetype configuration

" tapVerboseOutput appears to be significantly better than perl.tap
autocmd FileType perl let b:vimpipe_filetype = "tapVerboseOutput"
autocmd FileType perl let b:vimpipe_command  = "perl -I lib/ -"

autocmd FileType puppet let b:vimpipe_command="T=`mktemp`; cat - > $T && puppet-lint $T; rm $T"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" magic!

" any machine-specific settings
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ATTIC

" need to figure out how to map the 'base' perl directory
"map ,t :!perl -I lib/ %<CR>
"map ,T :!prove -I lib/ -r <CR>
"map ,p :!perldoc %<CR>

"nnoremap <leader>T :n t/%<CR>
" When vimrc is edited, reload it
"autocmd! bufwritepost ~/.vimrc source ~/.vimrc
"autocmd! bufwritepost ~/.vim/vimrc source ~/.vim/vimrc

" pod syntax highlighting.  hmm.
"let g:perl_include_pod=1
"
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

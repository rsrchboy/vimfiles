" Name:             ~/.vimrc
" Summary:          My ~/.vimrc and configuration
" Maintainer:       Chris Weyl <cweyl@alumni.drew.edu>
" Canonical Source: https://github.com/RsrchBoy/vimfiles
" License:          CC BY-NC-SA 3.0 (aka Attribution-NonCommercial-ShareAlike)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This must be first, because it changes other options as side effect
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle: NeoBundle for bundle/plugin management {{{1

" see also: https://github.com/Shougo/neobundle.vim

" Setup: setup NB proper; bootstrap from embedded if needs be {{{2

" I've subtree-embedded a copy of neobundle here for bootstrap purpose

if has('vim_starting')

    if isdirectory(expand("~/.vim/bundle/neobundle.vim"))
        " normal; we've been run before
        set runtimepath+=~/.vim/bundle/neobundle.vim/
    else
        " ...otherwise use our embedded copy for bootstrapping
        set runtimepath+=~/.vim/bootstrap/bundles/neobundle.vim/
    endif
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Bundles: define our bundles, etc {{{2

" and include a non-embedded version
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin'  : 'make -f make_cygwin.mak',
    \ 'mac'     : 'make -f make_mac.mak',
    \ 'unix'    : 'make -f make_unix.mak',
    \ },
\ }

" loosely ordered.  we'll probably need to revisit this

" general
NeoBundle 'DataWraith/auto_mkdir'
"NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'godlygeek/tabular'
NeoBundle 'jamessan/vim-gnupg'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'krisajenkins/vim-pipe'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'vim-scripts/bufexplorer.zip'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'thinca/vim-localrc'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tsaleh/vim-align'
NeoBundle 'vim-scripts/AsyncCommand'
NeoBundle 'thinca/vim-ref'
NeoBundle 'nathanaelkane/vim-indent-guides'

" git
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'bartman/git-wip'
NeoBundle 'mhinz/vim-signify'

" mini-apps or interfaces
NeoBundle 'nsmgr8/vitra'   " trac
NeoBundle 'lukaszkorecki/vim-GitHubDashBoard'
NeoBundle 'vim-scripts/VimRepress'
NeoBundle 'vim-scripts/vimwiki'
NeoBundle 'kakkyz81/evervim'

" perl
NeoBundle 'c9s/cpan.vim'
NeoBundle 'LStinson/perlhelp-vim'
NeoBundle 'vim-scripts/update_perl_line_directives'     " could use some work
NeoBundle 'vim-scripts/syntax_check_embedded_perl.vim'  " could use some work

" largely syntax / ft
NeoBundle 'hsitz/VimOrganizer'
NeoBundle 'nono/jquery.vim'
NeoBundle 'othree/html5-syntax.vim'
NeoBundle 'puppetlabs/puppet-syntax-vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'argent-smith/JSON.vim'
NeoBundle 'tmatilai/gitolite.vim'
NeoBundle 'evanmiller/nginx-vim-syntax'
NeoBundle 'fmoralesc/vim-pinpoint'
NeoBundle 'vim-scripts/tracwiki'
NeoBundle 'vim-scripts/iptables'
NeoBundle 'vim-scripts/rainbow_csv.vim'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'vim-scripts/deb.vim'
NeoBundle 'vim-scripts/log4perl.vim'
NeoBundle 'zaiste/tmux.vim'

" Trial Bundles: maybe, maybe not!
NeoBundle 'mhinz/vim-startify'
NeoBundle 'kablamo/vim-git-log'
NeoBundle 'mhinz/vim-tmuxify'
NeoBundle 'dhruvasagar/vim-table-mode'

" Finalize: Actually check/install {{{2

filetype plugin indent on " Required!

" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck

if !has('vim_starting')
    " Call on_source hook when reloading .vimrc.
    call neobundle#call_hook('on_source')
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" APPEARANCE: colors, themes, etc {{{1

let g:solarized_termtrans = 1
"let g:solarized_termcolors = 256 " needed on terms w/o solarized palette
colorscheme solarized
syntax on

" vim-signify ...FIXME needed?
highlight clear SignColumn

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" POWERLINE: segments and settings {{{2

" if you're using the rho-pi/dev ubuntu PPA, then you can install snapshots of
" the 'almost-there, really' new powerline.

" load the 'new' powerline if available
let g:_powerline_vim = "/usr/lib/python2.7/dist-packages/powerline/bindings/vim/plugin/powerline.vim"

let g:Powerline_symbols = 'fancy'
"let g:Powerline_theme  = 'skwp'

" FIXME we should really have a decent fall-back statusline
if filereadable(g:_powerline_vim)
    " ok, this is *really* annoying
    "source g:_powerline_vim
    source /usr/lib/python2.7/dist-packages/powerline/bindings/vim/plugin/powerline.vim
endif

"call Pl#Theme#RemoveSegment('lineinfo')
"call Pl#Theme#RemoveSegment('fileformat')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPES: additional file-to-type matching {{{1

au BufNewFile,BufRead *.psgi      set filetype=perl
au BufNewFile,BufRead cpanfile    set filetype=perl
au BufNewFile,BufRead *.tt        set filetype=tt2html
au BufNewFile,BufRead *.tt2       set filetype=tt2html
au BufNewFile,BufRead Changes     set filetype=changelog
au BufNewFile,BufRead *.zsh-theme set filetype=zsh

" this usually works, but sometimes vim thinks it's not perl
au BufNewFile,BufRead *.t         set filetype=perl


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS: General vim {{{1

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
" XXX reexamine 'nobackup'
set nobackup                   " we're stashing everything in git, anyways
" XXX reexamine 'noswapfile'
set noswapfile
" XXX reexamine 'lazyredraw' vs 'ttyfast'
"set lazyredraw
set ttyfast

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS: key {,re}mappings {{{1

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
" SETTINGS: misc bundle settings {{{1

" TODO refactor this out properly

let g:snippets_dir='~/.vim/snippets,~/.vim/bundle/snipmate.vim/snippets' " ,~/.vim/bundle/*/snippets

let g:git_no_map_default          = 1
let g:bufExplorerShowRelativePath = 1
let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_CommitStep             = 150
" TODO need to highlight TBD appropriately, too
let g:tlTokenList                 = ['FIXME', 'XXX', 'TODO', 'TBD' ]

" github-style ``` markups -- for vim-markup bundle
let g:markdown_github_languages = ['perl', 'ruby', 'erb=eruby']

" Indent Guides: no more counting up for matching! {{{1

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1

" PLUGIN: vim-signify {{{1

" TODO need to handle "normal" sign column
let g:signify_sign_color_inherit_from_linenr = 1
let g:signify_skip_filetype = { 'gitcommit': 1 }


" Evervim: Interface to evernote.com {{{1

" See ~/.vimrc.local for tokens and the like.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: CtrlP {{{1

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: gist {{{1

let g:gist_detect_filetype        = 1
let g:gist_clip_command           = 'xclip -selection clipboard'
let g:gist_post_private           = 1
let g:gist_show_privates          = 1
let g:gist_get_multiplefile       = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: tagbar and ctags configuration {{{1

nnoremap <leader>l :TagbarToggle<CR>
nnoremap <leader>o :TagbarOpenAutoClose<CR>

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
" PLUGIN: vim-gnupg options, etc {{{1

let g:GPGPreferArmor       = 1
let g:GPGDefaultRecipients = ["cweyl@alumni.drew.edu"]

"   g:GPGFilePattern
"
"     If set, overrides the default set of file patterns that determine
"     whether this plugin will be activated.  Defaults to
"     '*.\(gpg\|asc\|pgp\)'.

" ok, this is more complex than it needs to be, but works :)
let g:GPGFilePattern = '\(*.\(gpg\|asc\|pgp\)\|.pause\)'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSV RainbowCSV: plugin config(s)  {{{1

" so we have a couple options here.  An intensely full-featured plugin for
" csv/tsv/etc manipulation exists here:
"
"    https://github.com/chrisbra/csv.vim
"
" ...but appears to be overkill for my needs, as usually I'm only examining
" csv files, not actually manipluating them in vim.  This one contains pretty
" syntax highlighting (very pretty *and* very useful), without much else:
"
"     https://github.com/vim-scripts/rainbow_csv.vim

" no configuration, currently.

" VimOrganizer: plugin config {{{1

" nothing here, currently.  check out ftplugin/org.vim

" Fugitive And Git: fugitive (git) mappings and config {{{1

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

" This section very happily stolen from / based on:
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
  setlocal spell spelllang=en_us spellcapcheck=0
  normal gg0
  if getline('.') == ''
    start
  end
endfunction

" TODO: examine and refactor/consolidate, if at all possible
"autocmd BufEnter *.git/*_EDITMSG exe BufEnterCommit()
autocmd BufEnter *.git/COMMIT_EDITMSG exe BufEnterCommit()
autocmd BufEnter .git/PULLREQ_EDITMSG set filetype=gitcommit
autocmd BufEnter .git/TAG_EDITMSG     set filetype=gitcommit

" Automatically remove fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: Vitra - Trac UI for ViM (bundle config) {{{1

" most of our trac server configuration will be done in ~/.vimrc.local
" so as to prevent userids and passwords from floating about :)

" default: 'status!=closed'
let g:tracTicketClause = 'owner=cweyl&status!=closed'
let g:tracServerList   = {}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PERL: Perl testing helpers {{{1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SECTION: Inline block manipulation (e.g. prettification) {{{1

" prettify a section of json
command! -range -nargs=* Tidy <line1>,<line2>! json_xs -f json -t json-pretty

command! -range -nargs=* MXRCize <line1>,<line2>perldo perldo return unless /$NS/; s/$NS([A-Za-z0-9:]+)/\$self->\l$1_class/; s/::(.)/__\l$1/g; s/([A-Z])/_\l$1/g

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC: mappings {{{1

" for TaskList
map <leader>v <Plug>TaskList

nnoremap ,= :Tabularize /=><CR>
vnoremap ,= :Tabularize /=><CR>

" make C-PgUp and C-PgDn work, even under screen
" see https://bugs.launchpad.net/ubuntu/+source/screen/+bug/82708/comments/1
:nmap <ESC>[5;5~ <C-PageUp>
:nmap <ESC>[6;5~ <C-PageDown>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN: vim-pipe filetype configuration {{{1

" tapVerboseOutput appears to be significantly better than perl.tap
autocmd FileType perl let b:vimpipe_filetype = "tapVerboseOutput"
autocmd FileType perl let b:vimpipe_command  = "perl -I lib/ -"

autocmd FileType puppet let b:vimpipe_command="T=`mktemp`; cat - > $T && puppet-lint $T; rm $T"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source Local Configs: ~/.vimrc.local, if present {{{1

" any machine-specific settings
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ATTIC: potentially useful, but unused or retired {{{1

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

" Statusline: pre-powerline statusline setup {{{2
" -- moved to attic when we adopted powerline
" statusline with pretty git bits
"set statusline=%-10([%n%H%M%R%W]%)\ %y%*%*%#StatusLineNC#\ %#ErrorMsg#\ %{GitBranchInfoTokens()[0]}\ %#StatusLine#\ %f%=%P\ %10((%l-%c/%L)%)

" GITMAPPINGS: pre-fugitive mappings {{{2
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

" Pathogen: old init settings {{{2

" these were in use before we switched over to neobundle.

"" This must be first, because it changes other options as side effect
"set nocompatible
"runtime bundle/vim-pathogen/autoload/pathogen.vim

"execute pathogen#infect()
"filetype plugin indent on
"Helptags

" 2}}} 1}}}
" vim: set foldmethod=marker foldlevel=0 :

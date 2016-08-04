" Name:             ~/.vimrc
" Summary:          My ~/.vimrc and configuration
" Maintainer:       Chris Weyl <cweyl@alumni.drew.edu>
" Canonical Source: https://github.com/RsrchBoy/vimfiles
" License:          CC BY-NC-SA 4.0 (aka Attribution-NonCommercial-ShareAlike)

" This must be first, because it changes other options as side effect
set nocompatible

" VimPlug BEGIN: "strategic" plugin manager ;) {{{1
call plug#begin()

" General Bundles: {{{1
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-capslock'
Plug 'DataWraith/auto_mkdir'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tsaleh/vim-align'
Plug 'thinca/vim-ref'
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/AutoAlign'

" Libraries: library plugins/bundles {{{1
" Vim Misc: ...by xolox {{{2

Plug 'xolox/vim-misc'

" Ingo Library: {{{2"{{{"}}}

" NOTE: no non-autoload viml

Plug 'vim-scripts/ingo-library'

" CountJump: {{{2

" NOTE: no non-autoload viml

" depends: ingo-library

Plug 'vim-scripts/CountJump'

" WebAPI: {{{2

Plug 'mattn/webapi-vim'

" }}}2

" Appish Or External Interface: bundles {{{1
" Calendar: +config {{{2

let g:calendar_google_calendar = 1
let g:calendar_google_task     = 1

Plug 'itchyny/calendar.vim', { 'on': 'Calendar' }

" Tmux Navigator: {{{2

Plug 'christoomey/vim-tmux-navigator'

" Mappings: move even in insert mode
inoremap <silent> <C-H> <ESC>:TmuxNavigateLeft<cr>
inoremap <silent> <C-J> <ESC>:TmuxNavigateDown<cr>
inoremap <silent> <C-K> <ESC>:TmuxNavigateUp<cr>
inoremap <silent> <C-L> <ESC>:TmuxNavigateRight<cr>
inoremap <silent> <C-\> <ESC>:TmuxNavigatePrevious<cr>

" }}}2
Plug 'diepm/vim-rest-console'


" GIT And Version Controlish: bundles {{{1
" Git WIP: {{{2

let g:git_wip_disable_signing = 1

" FIXME make git-wip build step *WORK*
            " \   'build': { 'unix': 'mkdir -p ~/bin ; ln -s `pwd`/git-wip ~/bin/ ||:' },
Plug 'bartman/git-wip', { 'rtp': 'vim' }

" Fugitive: {{{2

" FIXME Gfixup is a work in progress
command! -nargs=? Gfixup :Gcommit --fixup=HEAD <q-args>

" {,re}mappings {{{3
" this is a cross between the old git-vim commands I'm used to, but invoking
" fugitive instead.

nmap <silent> <Leader>gs :Gstatus<Enter>
nmap <silent> <Leader>gd :call Gitv_OpenGitCommand("diff --no-color -- ".expand('%'), 'new')<CR>
nmap <silent> <Leader>gD :call Gitv_OpenGitCommand("diff --no-color --cached %", 'new')<CR>
nmap <silent> <Leader>gh :call Gitv_OpenGitCommand("show --no-color", 'new')<CR>
nmap <silent> <Leader>ga :Gwrite<bar>call sy#start()<CR>
nmap <silent> <Leader>gc :Gcommit<Enter>
nmap <silent> <Leader>gf :Gcommit --fixup HEAD<CR>
nmap <silent> <Leader>gF :Gcommit --fixup 'HEAD~'<CR>
nmap <silent> <Leader>gS :Gcommit --squash HEAD

" trial -- intent to add
nmap <silent> <Leader>gI :Git add --intent-to-add %<bar>call sy#start()<CR>

nmap <silent> <Leader>gA :Git add -pi %<bar>call sy#start()<CR>
nmap <silent> <Leader>gl :Git lol<Enter>
nmap <silent> <Leader>gD :Git! diff --word-diff %<Enter>
nmap <silent> <Leader>gp :Git push<Enter>
nmap <silent> <Leader>gb :Gblame -w<Enter>

nmap <silent> <leader>gv :Gitv<cr>
nmap <silent> <leader>gV :Gitv!<cr>

" make handling indexes a little easier {{{3

" This section very happily stolen from / based on:
" https://github.com/aaronjensen/vimfiles/blob/master/vimrc

function! BufReadIndex()
  setlocal cursorline
  setlocal nohlsearch

  nnoremap <buffer> <silent> j :call search('^#\t.*','W')<Bar>.<CR>
  nnoremap <buffer> <silent> k :call search('^#\t.*','Wbe')<Bar>.<CR>
endfunction

function! BufEnterCommit()
  setlocal filetype=gitcommit
  setlocal nonumber
  setlocal spell spelllang=en_us spellcapcheck=0
  setlocal foldcolumn=0
  setlocal textwidth=72
  normal gg0
  if getline('.') == ''
    start
  end
endfunction

" autocmds (e.g. for pull req, tag edits, etc...) {{{3

augroup vimrc-fugitive
    au!

    " Use j/k in status
    autocmd BufReadCmd *.git/index             exe BufReadIndex()
    autocmd BufReadCmd *.git/worktrees/*/index exe BufReadIndex()
    autocmd BufEnter   *.git/index             silent normal j
    autocmd BufEnter   *.git/worktrees/*/index silent normal j

    " the 'hub' tool creates a number of comment files formatted in the same way
    " as a git commit message.
    autocmd BufEnter *.git/**/*_EDITMSG exe BufEnterCommit()

    " Automatically remove fugitive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete

    " e.g. after we did something :Dispatchy, like :Gfetch
    au QuickFixCmdPost .git/**/index call fugitive#reload_status()

    " on buffer initialization, set our work and common dirs
    au User Fugitive     let b:git_worktree  = fugitive#buffer().repo().tree()
    au User FugitiveBoot let b:git_commondir = fugitive#buffer().repo().git_chomp('rev-parse','--git-common-dir')
augroup END
" }}}3

" "plugins"

Plug 'tpope/vim-rhubarb'

" Origin: is really 'tpope/vim-fugitive', but there's some git-workdirs fixes
" I'm pulling into my own fork that I'm needing at the moment.
Plug 'tpope/vim-fugitive'

" Gist: {{{2

let g:gist_detect_filetype        = 1
let g:gist_clip_command           = 'xclip -selection clipboard'
let g:gist_post_private           = 1
let g:gist_show_privates          = 1
let g:gist_get_multiplefile       = 1

Plug 'mattn/gist-vim', { 'on': 'Gist' }

" Signify: {{{2

Plug 'mhinz/vim-signify'

" Mappings: {{{3

nmap <leader>gj <Plug>(signify-next-hunk)
nmap <leader>gk <Plug>(signify-prev-hunk)

" Settings: {{{3

" TODO: need to handle "normal" sign column
let g:signify_vcs_list      = [ 'git' ]
let g:signify_skip_filetype = { 'gitcommit': 1 }

" NOTE: This also saves the buffer to disk!
let g:signify_update_on_bufenter    = 1
let g:signify_update_on_focusgained = 1
let g:signify_cursorhold_normal     = 0
let g:signify_cursorhold_insert     = 0

" AutoCommands: {{{3

augroup vimrc-Signify
    autocmd!

    autocmd BufEnter             * call sy#start()
    autocmd WinEnter             * call sy#start()
    autocmd FileChangedShellPost * call sy#start()
    autocmd ShellCmdPost         * call sy#start()
augroup END

" }}}2
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'int3/vim-extradite', { 'on': 'Extradite' }

Plug 'vim-scripts/ConflictMotions'
Plug 'vim-scripts/ConflictDetection'

" Perl Bundles: {{{1
Plug 'vim-perl/vim-perl'
Plug 'LStinson/perlhelp-vim', { 'on': ['PerlHelp', 'PerlMod'] }
Plug 'vim-scripts/log4perl.vim'

" General Syntax And Filetype Plugins: bundles {{{1
" Lua: {{{2

" TODO these are basically all TRIAL bundles, as I haven't worked with much
" lua before now

" sooooo.... yeah.  may have to try these suckers out independently.

Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }
Plug 'xolox/vim-lua-inspect', { 'for': 'lua' }
Plug 'WolfgangMehner/lua-support', { 'for': 'lua' }

" }}}2
Plug 'tpope/vim-git'
Plug 'othree/html5-syntax.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'cespare/vim-toml'
Plug 'RsrchBoy/vim-sshauthkeys'
Plug 'zaiste/tmux.vim'
Plug 'argent-smith/JSON.vim'
Plug 'tmatilai/gitolite.vim'
Plug 'evanmiller/nginx-vim-syntax'
Plug 'vim-scripts/iptables'
Plug 'RsrchBoy/interfaces' " syntax for /etc/network/interfaces
Plug 'smancill/conky-syntax.vim'
Plug 'apeschel/vim-syntax-syslog-ng'
Plug 'ekalinin/Dockerfile.vim'
Plug 'groenewege/vim-less'
Plug 'kurayama/systemd-vim-syntax'
Plug 'tpope/vim-haml'
Plug 'nono/jquery.vim'
Plug 'fmoralesc/vim-pinpoint'
Plug 'vim-scripts/deb.vim'

" ColorSchemes: {{{1
" ZenBurn: {{{2

let g:zenburn_high_Contrast = 1
let g:zenburn_transparent   = 1

Plug 'jnurmine/Zenburn'

" Solarized: {{{2

let g:solarized_termtrans = 1
"let g:solarized_termcolors = 256 " needed on terms w/o solarized palette

Plug 'altercation/vim-colors-solarized'

" }}}2

" Trial Bundles: maybe, maybe not! {{{1
" ToDo Style Plugins: ...because there's more than one?! {{{2

" 'vitalk/vim-simple-todo' {{{3

Plug 'vitalk/vim-simple-todo'

" 'freitass/todo.txt-vim' {{{3

" settings unchanged

nnoremap <silent> <Leader>td :split ~/todo.txt<CR>

" Autocmds:
augroup vimrc-todo.txt
    au!

    " self-removes on execution
    au BufNewFile,BufRead *todo.txt call plug#load('todo.txt-vim') | execute 'set ft=todo | au! vimrc-todo.txt'
augroup END

" note this syntax prevents autoloading
Plug 'freitass/todo.txt-vim', { 'on': [] }

" }}}3

" LazyList: {{{2

" the plugin author's configuration:

nnoremap gli :LazyList
vnoremap gli :LazyList

let g:lazylist_omap = 'il'
let g:lazylist_maps = [
                        \ 'gl',
                        \ {
                                \ 'l'  : '',
                                \ '*'  : '* ',
                                \ '-'   : '- ',
                                \ 't'   : '- [ ] ',
                                \ '2'  : '%2%. ',
                                \ '3'  : '%3%. ',
                                \ '4'  : '%4%. ',
                                \ '5'  : '%5%. ',
                                \ '6'  : '%6%. ',
                                \ '7'  : '%7%. ',
                                \ '8'  : '%8%. ',
                                \ '9'  : '%9%. ',
                                \ '.1' : '1.%1%. ',
                                \ '.2' : '2.%1%. ',
                                \ '.3' : '3.%1%. ',
                                \ '.4' : '4.%1%. ',
                                \ '.5' : '5.%1%. ',
                                \ '.6' : '6.%1%. ',
                                \ '.7' : '7.%1%. ',
                                \ '.8' : '8.%1%. ',
                                \ '.9' : '9.%1%. ',
                        \ }
                \ ]


" fwiw, almost all of this is in autoload/
Plug 'KabbAmine/lazyList.vim', { 'on': 'LazyList' }

" }}}2
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-syntax' " , { 'depends': 'vim-textobj-user' }
" filetype
Plug 'jtratner/vim-flavored-markdown'
" unite
Plug 'Shougo/unite.vim'

" Unmanaged Plugins: {{{1
" Grrrit: gerrit interface... ish {{{2

" still in development

Plug 'RsrchBoy/vim-grrrit', { 'on': 'GrrritChanges' }
" Plug '~/work/vim/vim-grrrit', { 'on': 'GrrritChanges' }

" }}}2

" VimPlug END: "strategic" plugin manager ;) {{{1
call plug#end()

" CONFIGURATION: global or general {{{1
" notes {{{2
"
" Configuration options that impact vim itself, rather than plugin or syntax
" settings.  (generally)
"
" "global" vars for use here and elsewhere {{{2

" settings {{{2

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
set smarttab
set expandtab                  " Convert all tabs typed to spaces
set shiftwidth=4               " Indent/outdent by four columns
set shiftround                 " Indent/outdent to nearest tabstop
set matchpairs+=<:>            " Allow % to bounce between angles too
set splitright                 " open new vsplit to the right
set ignorecase
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
set spellfile+=~/.vim/spell/en.utf-8.add

" terminal bits: {{{2

" initial hackery to let us set terminal titles!

if &term =~ "screen.*"
    set t_ts=k
    set t_fs=\
endif
" if &term =~ "screen.*" || &term == "xterm"
" if exists("$TMUX")
if exists("$TMUX") && empty($TMUX)
    " set title
    " set titlestring=%{rsrchboy#termtitle()}
endif

" folding {{{2

"set foldmethod=marker
set foldlevel=1
set foldcolumn=3

" fold functions {{{2

" toggle fold columns on/off, issuing a VimResized event afterwards (so things
" can sensibly redraw themselves)
func! ToggleFoldColumn()
    if &foldcolumn > 0
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=3
    endif

    doau VimResized
endfunc

func! FoldOnLeadingPounds(lnum)
    let l0 = getline(a:lnum)

    if l0 =~ '^##'
        return '>'.(matchend(getline(v:lnum),'^#\+')-1)
    elseif l0 =~ '^#='
        return '>0'
    endif

    return '='
endfunc

"}}}2

" NeoBundle: NeoBundle for bundle/plugin management {{{1
" notes {{{2

" A pretty bog-simple list of plugins; few fancy things so far, though I
" really ought to enable lazy-loading, etc on some.
"
" Note that no real attention is paid to making sure everything works on
" Windows systems.  If the information is there, I'll put it in, but
" otherwise...  Heck, it's been quite some time, and likely to be even longer.
"
" see also: https://github.com/Shougo/neobundle.vim

" Config: neobundle defaults, etc {{{2

let g:neobundle#default_options = {
            \   '_': {
            \       'lazy': 0,
            \   },
            \}

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

" }}}2

" BUNDLES BEGIN: Initialization {{{1
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Libraries: library plugins/bundles {{{1
" TLib: {{{2

NeoBundleLazy 'tomtom/tlib_vim', {
            \   'autoload': {
            \       'functions': 'tlib#',
            \   },
            \   'verbose': 0,
            \}

" }}}2

" Process Execution Bundles: {{{1
" Dispatch Via Shell: a "glue" plugin? {{{2

NeoBundleLazy 'p0deje/vim-dispatch-vimshell', {
            \   'augroup': 'dispatch-vimshell',
            \   'depends': ['vimshell.vim'],
            \}

" VimShell: {{{2

" taken from neobundle's help (same author)
NeoBundleLazy 'Shougo/vimshell.vim',{
        \ 'depends' : 'vimproc',
        \ 'autoload' : {
        \   'commands' : [{ 'name' : 'VimShell',
        \                   'complete' : 'customlist,vimshell#complete'},
        \                 'VimShellExecute', 'VimShellInteractive',
        \                 'VimShellTerminal', 'VimShellPop'],
        \   'mappings' : '<Plug>'
        \ }}


" VimProc: {{{2

NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin'  : 'make -f make_cygwin.mak',
    \ 'mac'     : 'make -f make_mac.mak',
    \ 'unix'    : 'make -f make_unix.mak',
    \ },
\ }

" Dispatch: {{{2

let g:dispatch_handlers = ['vimshell', 'tmux', 'screen', 'windows', 'iterm', 'x11', 'headless']

NeoBundleLazy 'tpope/vim-dispatch', {
            \   'depends': 'vim-dispatch-vimshell',
            \   'autoload': {
            \       'commands': [ 'Dispatch', 'Make', 'Start', 'Focus' ],
            \       'functions': 'dispatch#',
            \   },
            \   'verbose': 1,
            \}

" }}}2

" General Bundles: {{{1
" VimGnuPG: transparently work with encrypted files {{{2

NeoBundleLazy 'jamessan/vim-gnupg', {
            \   'autoload': { 'filename_patterns': ['\.gpg$','\.asc$','\.pgp$'] },
            \   'augroup':  'GnuPG',
            \   'verbose': 1,
            \}

" Settings: {{{3

let g:GPGPreferArmor       = 1
let g:GPGDefaultRecipients = ["cweyl@alumni.drew.edu"]

"   g:GPGFilePattern
"
"     If set, overrides the default set of file patterns that determine
"     whether this plugin will be activated.  Defaults to
"     '*.\(gpg\|asc\|pgp\)'.

" ok, this is more complex than it needs to be, but works :)
let g:GPGFilePattern = '\(*.\(gpg\|asc\|pgp\)\|.pause\)'

" PostSource Hook: {{{3

if neobundle#tap('vim-gnupg')

    function! neobundle#hooks.on_post_source(bundle)
        silent! execute 'doautocmd GnuPG BufReadCmd'
        silent! execute 'doautocmd GnuPG FileReadCmd'
    endfunction

    call neobundle#untap()
endif

" VimPipe: {{{2

" Settings: {{{3

" default mappings conflict with PerlHelp
let g:vimpipe_invoke_map = ',r'
let g:vimpipe_close_map  = ',p'

" AutoCommands: {{{3

augroup vimrc-vimpipe
    au!

    " tapVerboseOutput appears to be significantly better than perl.tap
    autocmd FileType perl let b:vimpipe_filetype = "tapVerboseOutput"
    autocmd FileType perl let b:vimpipe_command  = "source ~/perl5/perlbrew/etc/bashrc ; perl -I lib/ -"

    autocmd FileType puppet let b:vimpipe_command="T=`mktemp`; cat - > $T && puppet-lint $T; rm $T"

augroup end

" }}}3

NeoBundleLazy 'krisajenkins/vim-pipe', {
            \   'autoload': {
            \       'commands': ['VimPipe'],
            \       'mappings': [[ 'n', g:vimpipe_invoke_map ]],
            \   },
            \   'verbose': 1,
            \}

" BufExplorer: {{{2

let g:bufExplorerShowRelativePath = 1
" let g:bufExplorerShowTabBuffer    = 1

NeoBundleLazy 'RsrchBoy/bufexplorer.zip', {
\'augroup':  'BufExplorer',
\'autoload': { 'commands': ['BufExplorer'], 'mappings': ['<LocalLeader>be'] },
\'verbose': 1,
\}
" CtrlP: {{{2

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix\|startify'

NeoBundle 'kien/ctrlp.vim'

" Tabular: {{{2

NeoBundleLazy 'godlygeek/tabular', {
            \   'autoload': {
            \       'commands': [
            \           'Tabularize',
            \           'AddTabularPattern',
            \           'AddTabularPipeline',
            \       ],
            \   },
            \   'verbose': 1,
            \}

" Mappings: {{{3

nnoremap <silent> ,= :Tabularize first_fat_comma<CR>
nnoremap <silent> ,- :Tabularize first_equals<CR>

nnoremap <silent> ,{  :Tabularize first_squiggly<CR>
nnoremap <silent> ,}  :Tabularize /}/l1c0<CR>
nnoremap <silent> ,]  :Tabularize /]/l1c0<CR>

" PostSource Hook: {{{3

if neobundle#tap('tabular')

    " Do Things when the bundle is vivified
    function! neobundle#hooks.on_post_source(bundle)

        " ...kinda.  assumes that the first '=' found is part of a fat comma
        AddTabularPattern first_fat_comma /^[^=]*\zs=>/l1
        AddTabularPattern first_equals    /^[^=]*\zs=/l1
        AddTabularPattern first_squiggly  /^[^{]*\zs{/l1
    endfunction

    call neobundle#untap()
endif

" }}}3

" NERD Tree: {{{2

map <leader>l :NERDTreeToggle<CR>

augroup vimrc-nerdtree
    au!

    " close if we're the only window left
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

augroup end

NeoBundle 'scrooloose/nerdtree', { 'augroup': 'NERDTreeHijackNetrw' }

" Startify: nifty start screen {{{2

"let g:startify_bookmarks = [ '~/.vimrc' ]
" autouse sessions with startify.  (aka be useful!)
let g:startify_session_detection   = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root  = 1
let g:startify_empty_buffer_key    = 'o'
let g:startify_restore_position    = 1

let g:startify_custom_header       =
    \ map(split(system('echo $USER@$HOST | figlet -t ; echo .; echo .; uname -a'), '\n'), '"   ". v:val') + ['','']
"let g:startify_custom_footer = ''

augroup vimrc-startify
    au!
    autocmd BufWinEnter startify* setlocal nonumber foldcolumn=0
augroup end


" files to skip including in the list
let g:startify_skiplist = [
           \ 'COMMIT_EDITMSG',
           \ $VIMRUNTIME .'/doc',
           \ 'bundle/.*/doc',
           \ ]

NeoBundle 'mhinz/vim-startify'

" Airline: {{{2

NeoBundle 'bling/vim-airline'

" Settings: {{{3

let g:airline_theme = 'dark'

" Extensions Config: {{{3

let g:airline#extensions#bufferline#enabled           = 0
let g:airline#extensions#syntastic#enabled            = 1
let g:airline#extensions#tabline#enabled              = 1
let g:airline#extensions#tagbar#enabled               = 1
let g:airline#extensions#tmuxline#enabled             = 0
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" Branchname Config: {{{3
" if a string is provided, it should be the name of a function that
" takes a string and returns the desired value
let g:airline#extensions#branch#format = 'CustomBranchName'
function! CustomBranchName(name)
    "return '[' . a:name . ']'
    if a:name == ''
        return a:name
    endif
    "return fugitive#repo().git_chomp('describe', '--all', '--long')

    let l:info   = a:name

    let l:ahead  = fugitive#repo().git_chomp('rev-list', a:name.'@{upstream}..HEAD')
    let l:behind = fugitive#repo().git_chomp('rev-list', 'HEAD..'.a:name.'@{upstream}')
    let l:info  .= ' [+' . len(split(l:ahead, '\n')) . '/-' . len(split(l:behind, '\n')) . ']'

    return l:info
endfunction

" symbols {{{3
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇ '
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
let g:airline_left_sep = ''
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
let g:airline_right_sep = ''
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'
"let g:airline_symbols.linenr = '¶ '
"let g:airline#extensions#branch#symbol = "\ue822"

" AutoCommands: {{{3

augroup vimrc#airline
    au!

    " wipe on, say, :Dispatch or similar
    au QuickFixCmdPost dispatch-make-complete if exists('b:airline_head') | unlet b:airline_head | fi
    au User FugitiveCommit                    if exists('b:airline_head') | unlet b:airline_head | fi
    au FileChangedShellPost * AirlineRefresh
    au ShellCmdPost         * AirlineRefresh
augroup END

" PostSource Hook: {{{3

if neobundle#tap('vim-airline')

    function! neobundle#hooks.on_post_source(bundle)

        let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'capslock', 'tablemode', 'iminsert'])
    endfunction

    call neobundle#untap()
endif

" }}}3

" JunkFile: {{{2

NeoBundleLazy 'Shougo/junkfile.vim', {
      \ 'autoload' : {
      \     'commands' : 'JunkfileOpen',
      \     'unite_sources' : ['junkfile', 'junkfile/new'],
      \     'functions': 'junkfile#',
      \ },
      \ 'verbose': 1,
      \}

" Vim Indent Guides: no more counting up for matching! {{{2

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1

NeoBundleLazy 'nathanaelkane/vim-indent-guides', { 'autoload': { 'insert': 1 } }

" NeoComplete: ...and associated bundles {{{2

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

let g:neocomplete#enable_smart_case = 1
"g:neocomplete#enable_auto_close_preview

" NeoBundleLazy 'Shougo/neco-syntax'
" NeoBundleLazy 'Shougo/neoinclude.vim'
" NeoBundleLazy 'c9s/perlomni.vim', { 'name': 'perlomni' }
" NeoBundleLazy 'Shougo/neocomplete.vim', {
"             \   'autoload': {
"             \       'commands': [ 'NeoCompleteEnable' ],
"             \   },
"             \   'depends': [ 'vimproc', 'perlomni', 'neoinclude.vim', 'neco-syntax' ],
"             \   'disabled': !has('lua'),
"             \   'verbose': 0,
"             \}

" SuperTab: {{{2

" FIXME appears to conflict with snipmate :(

let g:SuperTabNoCompleteAfter  = ['^', '\s', '\\']

" NeoBundleLazy 'ervandew/supertab', { 'autoload': { 'insert': 1 } }

" Tagbar: {{{2

nmap <silent> <leader>ttb :TagbarToggle<CR>

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

" Perl: ctags configuration {{{3

"    \ 'ctagsbin': 'perl-tags',
"    \ 'ctagsargs': '--outfile -',
let g:tagbar_type_perl = {
    \ 'sort' : 1,
    \ 'deffile' : '$HOME/.vim/ctags/perl',
    \ 'kinds' : [
        \ 'p:packages:1:0',
        \ 'u:uses:1:0',
        \ 'A:aliases:0:0',
        \ 'q:requires:1:0',
        \ 'c:constants:0:0',
        \ 'o:package globals:0:0',
        \ 'R:readonly:0:0',
        \ 'f:formats:0:0',
        \ 'e:extends',
        \ 'r:roles:1:0',
        \ 'a:attributes',
        \ 's:subroutines',
        \ 'l:labels',
        \ 'P:POD',
    \ ],
    \ 'sro' : '',
    \ 'kind2scope' : {
        \ 'p' : 'packages',
    \ },
    \ 'scope2kind' : {
        \ 'packages' : 'p',
        \ 'subroutines' : 's',
    \ },
\ }

" Puppet: ctags configuration {{{3

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

" }}}3

NeoBundleLazy 'majutsushi/tagbar', {
            \   'autoload': {
            \       'commands': 'Tagbar',
            \   },
            \   'verbose': 1,
            \}

" Snipmate: {{{2

NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'garbas/vim-snipmate', { 'depends': 'vim-addon-mw-utils' }

" }}}2

" GIT And Version Controlish: bundles {{{1
" Gitv: {{{2

" Settings: {{{3

let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_CommitStep             = 150
let g:Gitv_TellMeAboutIt          = 0

" AutoCommands: {{{3

augroup vimrc-gitv
    au!

    " prettify gerrit refs
    au User GitvSetupBuffer silent %s/refs\/changes\/\d\d\//change:/ge

    " update commit list on :Dispatch finish
    " NOTE this does not update the commit in the preview pane
    "au QuickFixCmdPost <buffer> :normal u
    "
    " For whatever reason the buffer-local au above isn't being created when
    " in the gitv ftplugin...?!  So we'll do this here.  *le sigh*
    au QuickFixCmdPost gitv-* :normal u

    "au BufNewFile gitv-* au QuickFixCmdPost <buffer=abuf> normal u
    au FileType gitv au QuickFixCmdPost <buffer=abuf> normal u

augroup END

" }}}3

" FIXME use our upstream, for the moment
"
" ...as there are a number of PR's I have outstanding with upstream.
"
" NeoBundleLazy 'gregsexton/gitv', {
NeoBundleLazy 'RsrchBoy/gitv', {
            \ 'autoload': {
            \   'commands': [
            \       {
            \           'name': 'Gitv',
            \           'complete': 'customlist,gitv#util#completion',
            \       },
            \   ],
            \   'functions': 'Gitv_OpenGitCommand',
            \ },
            \ 'verbose': 1,
            \}

" }}}2

" Appish Or External Interface: bundles {{{1
" Terraform: {{{2

NeoBundleLazy 'hashivim/vim-terraform', {
            \   'autoload': {
            \       'filename_patterns': [ '\.tf$', '\.tfvars$', '\.tfstate$' ],
            \       'verbose': 1,
            \   },
            \}

" MediaWiki Editor: {{{2

NeoBundleLazy 'aquach/vim-mediawiki-editor', {
            \   'disabled': !has('python'),
            \   'depends': 'mediawiki.vim',
            \   'autoload': {
            \       'filetypes': 'mediawiki',
            \       'commands': ['MWRead', 'MWWrite', 'MWBrowse'],
            \   },
            \   'verbose': 1,
            \}

" TweetVim: {{{2

NeoBundleLazy 'basyura/twibill.vim'
NeoBundleLazy 'basyura/bitly.vim'
NeoBundleLazy 'tyru/open-browser.vim'
NeoBundleLazy 'mattn/favstar-vim'
NeoBundleLazy 'basyura/TweetVim', {
\ 'depends': [
\   'twibill.vim',
\   'bitly.vim',
\   'favstar-vim',
\   'open-browser.vim',
\ ],
\ 'autoload': { 'commands' : [ 'TweetVimHomeTimeline', 'TweetVimSay', 'TweetVimCommandSay' ] },
\ 'verbose': 1,
\}

" AutoCommands: {{{3

augroup vimrc-tweetvim
    autocmd!
    autocmd FileType tweetvim setlocal nonumber foldcolumn=0
augroup END

" Mappings: {{{3

nnoremap <silent> <Leader>TT :TweetVimHomeTimeline<CR>
nnoremap <silent> <Leader>TS :TweetVimSay<CR>

" Settings: {{{3

let g:tweetvim_tweet_per_page   = 50
let g:tweetvim_display_source   = 1
let g:tweetvim_display_time     = 1
let g:tweetvim_expand_t_co      = 1
let g:tweetvim_display_username = 1
let g:tweetvim_open_buffer_cmd  = '$tabnew'

" }}}3

" TmuxLine: {{{2

let g:tmuxline_powerline_separators = 0

let g:tmuxline_preset = {
    \'a'    : ['#(whoami)@#H'],
    \'b'    : '#S',
    \'win'  : ['#I#F', '#W'],
    \'cwin' : ['#I#F', '#W'],
    \}

NeoBundleLazy 'edkolev/tmuxline.vim', {
            \   'external_commands': 'tmux',
            \   'autoload': {
            \       'commands': ['Tmuxline', 'TmuxlineSnapshot'],
            \   },
            \   'verbose': 0,
            \}

" VimRepress: {{{2
NeoBundleLazy 'pentie/VimRepress', {
\ 'autoload': {
\   'commands': ['BlogNew', 'BlogOpen', 'BlogList'],
\ },
\ 'disabled': !has('python'),
\ 'verbose': 1,
\}
" Vitra: Trac interface {{{2

" NOTE: we don't actually use this plugin anymore, not having need to access
" any Trac servers.

" most of our trac server configuration will be done in ~/.vimrc.local
" so as to prevent userids and passwords from floating about :)

" default: 'status!=closed'
let g:tracTicketClause = 'owner=cweyl&status!=closed'
let g:tracServerList   = {}

augroup vimrc-vitra
    au!
    autocmd BufWinEnter Ticket:*      setlocal nonumber foldcolumn=0
    autocmd BufWinEnter Ticket:.Edit* setlocal filetype=tracwiki spell spelllang=en_us spellcapcheck=0 foldcolumn=0
augroup end

NeoBundleLazy 'vim-scripts/tracwiki', { 'autoload': { 'filetypes': 'tracwiki' } }
NeoBundleLazy 'nsmgr8/vitra', { 'depends': 'tracwiki', 'verbose': 1 }

" VimOrganizer: {{{2

NeoBundleLazy 'hsitz/VimOrganizer', {
            \   'autoload': {
            \       'filetypes': ['org', 'vimorg-agenda-mappings', 'vimorg-main-mappings'],
            \   },
            \   'verbose': 1,
            \}

" VimWiki: {{{2

let g:vimwiki_use_calendar = 1
let g:calendar_action      = 'vimwiki#diary#calendar_action'
let g:calendar_sign        = 'vimwiki#diary#calendar_sign'

NeoBundleLazy 'vim-scripts/vimwiki', {
            \   'autoload': {
            \       'commands': ['Vimwiki', 'VimwikiIndex'],
            \       'mappings': [
            \           '<Plug>Vimwiki',
            \           '<leader>ww',
            \           '<leader>wt',
            \           '<leader>ws',
            \           '<leader>w<leader>t',
            \       ],
            \       'functions': 'vimwiki#',
            \   },
            \   'verbose': 1,
            \}

" }}}2

" OS Specific Bundles: OSX {{{1
" Vitality: iTerm2/tmux {{{2

" this looks worth examining...  if we're ever in the situation of needing to
" use a mac :\

NeoBundleLazy 'sjl/vitality.vim', {
            \   'external_commands': 'tmux',
            \   'disabled': !neobundle#util#is_mac(),
            \}

" }}}2

" Perl Bundles: {{{1
" perl-in-vim bundles {{{2

augroup vimrc-perl-in-vim
    au!

    " self-removes on execution
    au FileType vim.perl call neobundle#source('update_perl_line_directives') | call neobundle#source('syntax_check_embedded_perl') | execute('au! vimrc-perl-in-vim')
augroup END

"neobundle#source('update_perl_line_directives')
"neobundle#source('syntax_check_embedded_perl')

NeoBundleLazy 'vim-scripts/update_perl_line_directives',    { 'autoload': { 'filetypes': 'vim.perl' }, 'verbose': 1, 'disabled': !has('perl') }
NeoBundleLazy 'vim-scripts/syntax_check_embedded_perl.vim', { 'autoload': { 'filetypes': 'vim.perl' }, 'verbose': 1, 'disabled': !has('perl') }
" }}}2
" NeoBundleLazy 'osfameron/perl-tags-vim',  { 'autoload': { 'filetypes': 'perl'     } }
" NeoBundleLazy 'c9s/cpan.vim', { 'autoload': { 'filetypes': 'perl' } }

" General Syntax And Filetype Plugins: bundles {{{1
" mediawiki {{{2

NeoBundleLazy 'chikamichi/mediawiki.vim', {
            \   'autoload': {
            \       'filetypes': 'mediawiki',
            \   },
            \   'verbose': 1,
            \}

" vim: {{{2

" Not a complete autovivification, but enough. 90% of the time we'll have at
" least one buffer open with a vim ft and that'll trigger the load anyways.

NeoBundleLazy 'tpope/vim-scriptease', {
            \   'autoload': {
            \       'commands': [
            \           'Breakadd',
            \           'Disarm',
            \           'PP', 'PPmsg',
            \           'Runtime',
            \           'Scriptnames',
            \           'Time',
            \           'Verbose',
            \           'Vedit', 'Vopen', 'Vsplit', 'Vvsplit', 'Vtabedit', 'Vpedit',
            \       ],
            \       'mappings': [
            \           ['n', 'zS'],
            \           ['n', 'g!'],
            \           ['v', 'g!'],
            \       ],
            \       'filetypes': ['vim'],
            \   },
            \   'verbose': 1,
            \}

" puppet {{{2
NeoBundleLazy 'puppetlabs/puppet-syntax-vim', { 'autoload': { 'filetypes': 'puppet' } }

" CSV {{{2
NeoBundleLazy 'chrisbra/csv.vim', { 'autoload': { 'filetypes': 'csv' } }

" mkd {{{2

NeoBundleLazy 'plasticboy/vim-markdown', {
            \   'depends': 'tabular',
            \   'autoload': {
            \       'filetypes': [ 'mkd', 'markdown', 'mkd.markdown' ],
            \       'mappings': [ '<Plug>Markdown_' ],
            \   },
            \   'verbose': 1,
            \}

let g:vim_markdown_initial_foldlevel = 1
let g:vim_markdown_frontmatter       = 1

" vim-chef and dependencies {{{2
NeoBundleLazy 'vadv/vim-chef', {
\   'autoload': { 'filetypes': [ 'chef' ] },
\   'depends': [
\       'tlib_vim',
\       'vim-snipmate',
\   ],
\   'verbose': 1,
\}
" vim-go {{{2
NeoBundleLazy 'fatih/vim-go', {
\ 'augroup': 'vim-go',
\ 'autoload': {
\   'filetypes': ['godoc', 'gohtmltmpl', 'gotexttmpl', 'go', 'vimgo'],
\ },
\ 'verbose': 1,
\}
" HiLinks: see the stack of syntax for the current text {{{2

NeoBundleLazy 'kergoth/vim-hilinks', {
            \   'augroup': 'HLTMODE',
            \   'autoload': {
            \       'commands': [ 'HLT', 'HLTm' ],
            \       'mappings': '<Leader>hlt',
            \   },
            \   'verbose': 1,
            \}

" }}}2

" Trial Bundles: maybe, maybe not! {{{1
" RIV: reStructured Text {{{2

NeoBundleLazy 'Rykka/riv.vim'

" Packer: {{{2

NeoBundleLazy 'markcornick/vim-packer', {
            \   'augroup': 'packer',
            \   'autoload': {
            \       'commands': 'Packer'
            \   },
            \   'verbose': 1,
            \}
+
" Afterimage: because... too cool. {{{2

" I'm not sure I'll ever use this... but dang.

NeoBundleLazy 'tpope/vim-afterimage', {
            \   'autoload': {
            \       'filename_patterns': ['\.ico$','\.png$','\.gif$','\.pdf$','\.plist$'],
            \   },
            \   'verbose': 1,
            \}

" MultipleCursors: {{{2

NeoBundleLazy 'terryma/vim-multiple-cursors', {
            \   'autoload': {
            \       'commands': 'MultipleCursors',
            \       'mappings': [['n', '<C-n>']],
            \   },
            \   'verbose': 1,
            \}

" Play Nice: with neocomplete {{{3

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" }}}3

" Settings: {{{3

let g:extradite_showhash = 1

" Mappings: {{{3

nnoremap <silent> <Leader>gE :Extradite<CR>

" AutoCmds: {{{3

augroup vimrc#extradite
    au!

    au FileType extradite nnoremap <buffer> <silent> <F1> :h extradite-mappings<CR>
augroup END

" PostSource Hook: {{{3

if neobundle#tap('vim-extradite')

    function! neobundle#hooks.on_post_source(bundle)

        " create the buffer-local :Extradite command
        silent! execute 'doautocmd User Fugitive'

        augroup vimrc#extradite#post_source_hook
            au!

            " ...and in buffers created before we loaded extradite, too
            au CmdUndefined Extradite :doautocmd User Fugitive
        augroup END
    endfunction

    call neobundle#untap()
endif

" }}}3

" VimSignature: show marks in sign column {{{2

" commands: Signature*

" FIXME this currently appears to overwrite signify signs -- well, all other
" signs, really.

NeoBundleLazy 'kshenoy/vim-signature', {
            \   'disable': !has('signs'),
            \}

" DbExt: {{{2

" TODO: disable unless we have DBI, etc, installed.

NeoBundleLazy 'vim-scripts/dbext.vim', {
            \   'disable': !has('perl'),
            \   'autoload': {
            \       'functions': ['dbext#', 'dbext_dbi#'],
            \       'commands': [
            \           'DBDescribe',
            \           'DBExec',
            \           'DBList',
            \           'DBPrompt',
            \           'DBSelect',
            \       ],
            \   },
            \   'verbose': 1,
            \}

" PipeMySQL: {{{2

" TODO check this one out, too: NLKNguyen/pipe-mysql.vim
NeoBundleLazy 'NLKNguyen/pipe.vim',{
            \   'autoload': { 'commands': 'Pipe' },
            \   'verbose': 1,
            \}
NeoBundleLazy 'NLKNguyen/pipe-mysql.vim', {
            \   'depends': 'pipe-mysql.vim',
            \   'verbose': 1,
            \}

" Gerrit Code Review: ...maybe we can make life easier {{{2

NeoBundleLazy 'stargrave/gerrvim'

NeoBundleLazy 'itissid/gv', {
            \   'disable': !has('python'),
            \   'autoload': {
            \       'commands': ['GvShowChanges','GvShowStatus'],
            \       'functions': 'gv#',
            \   },
            \   'verbose': 1,
            \}

" Unite Issues: jira and github, really {{{2

NeoBundleLazy 'rafi/vim-unite-issue', {
            \   'directory': 'unite-issue',
            \   'unite_sources': [ 'issue' ],
            \   'depends': [
            \       'open-browser.vim', 'unite.vim',
            \   ],
            \}

" Pull Requests: github/unite {{{2

NeoBundleLazy 'joker1007/unite-pull-request', {
            \   'unite_sources': [ 'pull-request' ],
            \   'depends': [
            \       'unite.vim',
            \   ],
            \}

" Jira Integration: {{{2
NeoBundle 'mnpk/vim-jira-complete'
NeoBundle 'RsrchBoy/vim-jira-open'
" }}}2

" VimGitLog: lazy {{{2
NeoBundleLazy 'kablamo/vim-git-log', { 'autoload': { 'commands': 'GitLog' }, 'verbose': 1 }

" TSkeletons: {{{2

NeoBundleLazy 'tomtom/tskeleton_vim', { 'depends': [ 'tlib_vim' ] }
NeoBundleLazy 'tomtom/tskeletons', { 'depends': [ 'tskeleton_vim' ] }

let g:tskelMapGoToNextTag = 0

" TabMan: {{{2

NeoBundleLazy 'kien/tabman.vim', {
            \   'autoload': {
            \       'commands': [ 'TMToggle', 'TMFocus' ],
            \       'mappings': [ '<leader>mt', '<leader>mf' ],
            \   },
            \   'verbose': 1,
            \}

" BetterWhitespace: 18 Jul 2015 {{{2

" NOTE replaces: NeoBundle 'bronson/vim-trailing-whitespace'
" FIXME ... if it would just work.  grr

let g:better_whitespace_filetypes_blacklist = [ 'git', 'mail', 'help' ]

nmap <silent> ,<space> :StripWhitespace<CR>

NeoBundle 'ntpeters/vim-better-whitespace'

" Notes: an alternative to vimwiki?? {{{2

" FIXME need to figure out the significance of other files in the notes dirs
" first
let g:notes_directories = [ '~/notes' ]
let g:notes_suffix = '.notes'

NeoBundleLazy 'xolox/vim-notes', {
            \   'autoload': {
            \       'commands': [
            \           {
            \               'name': ['Note', 'RecentNotes'],
            \               'complete': 'customlist,xolox#notes#cmd_complete',
            \           },
            \           {
            \               'name': ['SearchNotes'],
            \               'complete': 'customlist,xolox#notes#keyword_complete',
            \           },
            \           'RecentNotes', 'MostRecentNote',
            \       ],
            \       'filetypes': 'notes',
            \       'functions': 'xolox#notes#',
            \   },
            \   'verbose': 1,
            \}

" GithubIssues: {{{2

" NOTE: don't autoload on gitcommit f/t at the moment, as this plugin either
" does not support authenticated requests (or we don't have it configured) and
" it's WICKED SLOW when the number of allowed requests is exceeded.

NeoBundleLazy 'jaxbot/github-issues.vim', {
            \   'disable': !has('python'),
            \   'autoload': {
            \       'commands': ['Gissues', 'Gmiles', 'Giadd'],
            \       'filetypes_DISABLED': 'gitcommit',
            \   },
            \   'verbose': 1,
            \}

" GitHub Dashboard: {{{2

let g:github_dashboard = {}
let g:github_dashboard['emoji'] = 1
let g:github_dashboard['RrschBoy'] = 1

NeoBundleLazy 'junegunn/vim-github-dashboard', {
            \   'disable': !has('ruby'),
            \   'verbose': 1,
            \   'autoload': {
            \       'commands': ['GHA', 'GHD', 'GHDashboard', 'GHActivity'],
            \   },
            \}

" ToggleLists: toggle the quickfix / locationlist windows easily {{{2

let g:toggle_list_no_mappings = 1

nmap <silent> <Leader>tqf :call ToggleQuickfixList()<cr>
nmap <silent> <Leader>tll :call ToggleLocationList()<cr>

NeoBundleLazy 'milkypostman/vim-togglelist', {
            \   'autoload': {
            \       'functions': [ 'ToggleLocationList', 'ToggleQuickfixList' ],
            \   },
            \   'verbose': 0,
            \}

" IndentObject: because indentation is ... {{{2

NeoBundleLazy 'austintaylor/vim-indentobject', {
            \   'autoload': {
            \       'mappings': [
            \           ['ov', 'ai'],
            \           ['ov', 'ii'],
            \       ],
            \   },
            \   'verbose': 1,
            \}

" Obsession: by tpope {{{2

NeoBundleLazy 'tpope/vim-obsession', {
            \   'autoload': {
            \       'commands': 'Obsession',
            \   },
            \   'verbose': 1,
            \}

" WindowSwap: {{{2

" FIXME needs config, etc

let g:windowswap_map_keys = 0
NeoBundleLazy 'wesQ3/vim-windowswap'

" }}}2
NeoBundleLazy 'mattn/googletasks-vim', { 'verbose': 1, 'autoload': { 'commands': 'GoogleTasks' } }
NeoBundle 'vim-scripts/gtk-vim-syntax'
NeoBundle 'dhruvasagar/vim-table-mode'
NeoBundle 'mhinz/vim-tmuxify'
NeoBundle 'Shougo/neomru.vim'
" 18 Jul 2015
" Syntastic: {{{2

NeoBundleLazy 'scrooloose/syntastic', { 'verbose': 1 }

" }}}
NeoBundle 'chrisbra/NrrwRgn'
" 27 Jul 2015
" FIXME need a ProjectionistDetect au for detecting Perl projects
NeoBundle 'tpope/vim-projectionist'
NeoBundleLazy 'klen/python-mode', { 'autoload': { 'filetypes': 'python' }, 'verbose': 1 }
" 11 Aug 2015
NeoBundleLazy 'dhruvasagar/vimmpc', { 'autoload': { 'commands': 'MPC' }, 'verbose': 1, 'disable': !has('python') }
NeoBundle 'tpope/vim-speeddating'
" see https://github.com/LucHermitte/local_vimrc
"NeoBundle 'LucHermitte/lh-vim-lib', {'name': 'lh-vim-lib'}
"NeoBundle 'LucHermitte/local_vimrc', {'depends': 'lh-vim-lib'}

" Probation: {{{1
NeoBundleLazy 'scrooloose/nerdcommenter'
NeoBundleLazy 'lukaszkorecki/vim-GitHubDashBoard'
" github issues query
NeoBundleLazy 'mklabs/vim-issues'
" to help handle other author's tabstop/etc settings w/o explicit modelines
NeoBundleLazy 'embear/vim-localvimrc'
NeoBundleLazy 'thinca/vim-localrc'

" Bundles Attic: {{{1
" no longer used! {{{2
"NeoBundle 'bling/vim-bufferline'
"NeoBundle 'kakkyz81/evervim'
"NeoBundle 'Zuckonit/vim-airline-tomato'

" }}}2

" Source Local Bundles: if any... {{{1
if filereadable(expand("~/.vimrc.bundles.local"))
    source ~/.vimrc.bundles.local
endif

" BUNDLES END: Initialization: {{{1
" end(): {{{2
call neobundle#end()

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

" }}}2

" Mappings: {{{1
" Text Formatting: {{{2

vmap Q gq

" FIXME: should this be "gqip"?
nmap Q gqap

nnoremap <silent> ,++ <c-a>
nnoremap <silent> ,-- <c-x>

" Configy: {{{2
set pastetoggle=<F2>

" Normal Mode Mappings: {{{2
nmap <LocalLeader>fc :call ToggleFoldColumn()<CR>

" this is somewhat irksome
nmap <silent> <LocalLeader>ft :filetype detect<CR>

nmap <silent> <F1> :h rsrchboy-normal-mappings<CR>
nmap <silent> <F3> :setlocal nonumber!<CR>
nmap <silent> <F5> :setlocal spell! spelllang=en_us<CR>
nmap <silent> <F7> :tabp<CR>
nmap <silent> <F8> :tabn<CR>

" make C-PgUp and C-PgDn work, even under screen
" see https://bugs.launchpad.net/ubuntu/+source/screen/+bug/82708/comments/1
nmap <ESC>[5;5~ <C-PageUp>
nmap <ESC>[6;5~ <C-PageDown>

nmap <silent> OO :only<CR>

" Visual Mode Mappings: {{{2
vmap <F3> :setlocal nonumber!<CR>
vmap <F5> :setlocal spell! spelllang=en_us<CR>
vmap <F7> :tabp<CR>
vmap <F8> :tabn<CR>

" Insert Mode Mappings: {{{2

imap <silent> jj <ESC>

" Command: {{{2

" Save with sudo if you're editing a readonly file in #vim
" https://twitter.com/octodots/status/196996096910827520
cmap w!! w !sudo tee % >/dev/null

" }}}2

" AutoCommands: {{{1
" filetype-setting autocommands {{{2

" NOTE: commands for specific filetypes are generally contained in
" ftplugin/*.vim  This section concerns itself mainly with those commands
" necessary to help vim in deciding what filetype a file actually is.

augroup vimrc-filetype-set
    au!

    au BufNewFile,BufRead *.psgi              set filetype=perl
    au BufNewFile,BufRead cpanfile            set filetype=perl
    au BufNewFile,BufRead Rexfile             set filetype=perl
    au BufNewFile,BufRead *.tt                set filetype=tt2html
    au BufNewFile,BufRead *.tt2               set filetype=tt2html
    au BufNewFile,BufRead Changes             set filetype=changelog
    au BufNewFile,BufRead *.zsh-theme         set filetype=zsh
    au BufNewFile,BufRead *.snippets          set filetype=snippets
    au BufNewFile,BufRead *.snippet           set filetype=snippet
    au BufNewFile,BufRead .gitgot*            set filetype=yaml
    au BufNewFile,BufRead .oh-my-zsh/themes/* set filetype=zsh
    au BufNewFile,BufRead .gitconfig.local    set filetype=gitconfig
    au BufNewFile,BufRead gitconfig.local     set filetype=gitconfig
    au BufNewFile,BufRead .vagrantuser        set filetype=yaml
    au BufNewFile,BufRead .aws/credentials    set filetype=dosini

    " e.g. /etc/NetworkManager/dnsmasq.d/...
    au BufNewFile,BufRead **/dnsmasq.d/*         set filetype=dnsmasq

    " this usually works, but sometimes vim thinks a .t file isn't Perl
    au BufNewFile,BufRead *.t set filetype=perl

    " common Chef patterns
    au BufNewFile,BufRead attributes/*.rb   set filetype=ruby.chef
    au BufNewFile,BufRead recipes/*.rb      set filetype=ruby.chef
    au BufNewFile,BufRead templates/*/*.erb set filetype=eruby.chef

augroup end

" filetype-specific autocommands {{{2

augroup vimrc-filetype
    au!
    " these have been moved to ftplugin/ files.
augroup end

" }}}2

let g:snippets_dir='~/.vim/snippets,~/.vim/bundle/*/snippets'

" APPEARANCE: colors, themes, etc {{{1
" Syntax AutoCommands: {{{2

augroup vimrc-syntax
    au!
    au Syntax * :hi SpecialKey ctermfg=darkgrey
augroup end

" colorscheme autocmds {{{2

augroup vimrc-colorscheme
    au!

    au ColorScheme zenburn   source ~/.vim/local/colors/zenburn.vim
    au ColorScheme solarized source ~/.vim/local/colors/solarized.vim

augroup end

" }}}2
colorscheme zenburn
syntax on

" Perl: Perl testing helpers {{{1
" TODO where did I go?! {{{2

" }}}2

" Inline Block Manipulation: aka prettification {{{1
" Uniq: trim to unique lines {{{2
"
" There's *got* to be a better way to do this than shelling out, but I'm out
" of tuits at the moment.

command! -range -nargs=* Uniq <line1>,<line2>! uniq

" json {{{2
command! -range -nargs=* JsonTidy <line1>,<line2>! /usr/bin/json_xs -f json -t json-pretty

" columns {{{2

command! -range -nargs=* ColumnTidy <line1>,<line2>! /usr/bin/column -t

" cowsay {{{2
command! -range -nargs=* Cowsay <line1>,<line2>! cowsay -W 65
command! -range -nargs=* BorgCowsay <line1>,<line2>! cowsay -W 65 -b

" Perl helpers {{{2
command! -range -nargs=* PerlTidy <line1>,<line2>! perltidy
command! -range -nargs=* MXRCize <line1>,<line2>perldo perldo return unless /$NS/; s/$NS([A-Za-z0-9:]+)/\$self->\l$1_class/; s/::(.)/__\l$1/g; s/([A-Z])/_\l$1/g

" }}}2

" Source Local Configs: ...if present {{{1
" ~/.vimrc.local {{{2

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" }}}2

" FINALIZE: set secure, etc.  closing commands. {{{1
" commands {{{2
set secure
set exrc

" }}}2

" vim: set foldmethod=marker foldlevel=1 foldcolumn=5 :

" Name:             ~/.vimrc
" Summary:          My ~/.vimrc and configuration
" Maintainer:       Chris Weyl <cweyl@alumni.drew.edu>
" Canonical Source: https://github.com/RsrchBoy/vimfiles
" License:          CC BY-NC-SA 4.0 (aka Attribution-NonCommercial-ShareAlike)

" This must be first, because it changes other options as side effect
set nocompatible

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

" Recipies: yay for shortcuts! (disabled) {{{1
"NeoBundle 'Shougo/neobundle-vim-recipes', { 'force' : 1 }

" Libraries: library plugins/bundles {{{1
NeoBundleLazy 'MarcWeber/vim-addon-mw-utils'
NeoBundleLazy 'mattn/webapi-vim'
NeoBundleLazy 'vim-scripts/ingo-library'
NeoBundleLazy 'vim-scripts/CountJump', { 'depends': 'ingo-library' }
NeoBundleLazy 'tomtom/tlib_vim'

" General Bundles: {{{1
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

NeoBundleLazy 'tpope/vim-dispatch', {
            \   'autoload': {
            \       'commands': [ 'Dispatch', 'Make', 'Start', 'Focus' ],
            \   },
            \   'verbose': 1,
            \}

" VimGnuPG: transparently work with encrypted files {{{2

" settings {{{3
let g:GPGPreferArmor       = 1
let g:GPGDefaultRecipients = ["cweyl@alumni.drew.edu"]

"   g:GPGFilePattern
"
"     If set, overrides the default set of file patterns that determine
"     whether this plugin will be activated.  Defaults to
"     '*.\(gpg\|asc\|pgp\)'.

" ok, this is more complex than it needs to be, but works :)
let g:GPGFilePattern = '\(*.\(gpg\|asc\|pgp\)\|.pause\)'

" }}}3

NeoBundleLazy 'jamessan/vim-gnupg', {
            \ 'autoload': { 'filename_patterns': ['\.gpg$','\.asc$','\.pgp$'] },
            \ 'augroup':  'GnuPG',
            \ 'verbose': 1,
            \}

if neobundle#tap('vim-gnupg')

    function! neobundle#hooks.on_post_source(bundle)
        silent! execute 'doautocmd GnuPG BufReadCmd'
        silent! execute 'doautocmd GnuPG FileReadCmd'
    endfunction

    call neobundle#untap()
endif


" VimPipe: {{{2

augroup vimrc-vimpipe
    au!

    " tapVerboseOutput appears to be significantly better than perl.tap
    autocmd FileType perl let b:vimpipe_filetype = "tapVerboseOutput"
    autocmd FileType perl let b:vimpipe_command  = "source ~/perl5/perlbrew/etc/bashrc ; perl -I lib/ -"

    autocmd FileType puppet let b:vimpipe_command="T=`mktemp`; cat - > $T && puppet-lint $T; rm $T"

augroup end

NeoBundleLazy 'krisajenkins/vim-pipe', {
            \   'autoload': { 'commands': ['VimPipe'], 'mappings': ['<LocalLeader>r'] },
            \   'verbose': 1,
            \}

" BufExplorer: {{{2

let g:bufExplorerShowRelativePath = 1

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

nnoremap ,= :Tabularize /=><CR>
nnoremap ,- :Tabularize /=<CR>

NeoBundle 'godlygeek/tabular'

" NERD Tree: {{{2

map <leader>l :NERDTreeToggle<CR>

augroup vimrc-nerdtree
    au!

    " clVose if we're the only window left
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
    \ map(split(system('fortune | cowsay -W 60 ; echo .; echo .; uname -a'), '\n'), '"   ". v:val') + ['','']
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

let g:airline_theme = 'dark'

" extensions config {{{3
let g:airline#extensions#bufferline#enabled           = 0
let g:airline#extensions#syntastic#enabled            = 1
let g:airline#extensions#tabline#enabled              = 1
let g:airline#extensions#tagbar#enabled               = 1
let g:airline#extensions#tmuxline#enabled             = 0
let g:airline#extensions#whitespace#mixed_indent_algo = 1

" fugitive bits {{{3
"" if a string is provided, it should be the name of a function that
"" takes a string and returns the desired value
"let g:airline#extensions#branch#format = 'CustomBranchName'
"function! CustomBranchName(name)
"    return '[' . a:name . ']'
"endfunction

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

" }}}3

"NeoBundle 'bling/vim-airline', { 'depends': [ 'vim-capslock', 'taboo' ] }
NeoBundle 'bling/vim-airline', { 'depends': [ 'vim-capslock' ] }

" JunkFile: {{{2

NeoBundleLazy 'Shougo/junkfile.vim', {
      \ 'autoload' : {
      \   'commands' : 'JunkfileOpen',
      \   'unite_sources' : ['junkfile', 'junkfile/new'],
      \ },
      \ 'verbose': 1,
\ }

" Vim Indent Guides: no more counting up for matching! {{{2

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1

NeoBundle 'nathanaelkane/vim-indent-guides'

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

NeoBundleLazy 'Shougo/neco-syntax'
NeoBundleLazy 'Shougo/neoinclude.vim'
NeoBundleLazy 'c9s/perlomni.vim', { 'name': 'perlomni' }
NeoBundleLazy 'Shougo/neocomplete.vim', {
            \   'autoload': {
            \       'commands': [ 'NeoCompleteEnable' ],
            \   },
            \   'depends': [ 'vimproc', 'perlomni', 'neoinclude.vim', 'neco-syntax' ],
            \   'disabled': !has('lua'),
            \   'verbose': 0,
            \}

" SuperTab: {{{2

let g:SuperTabNoCompleteAfter  = ['^', '\s', '\\']

NeoBundleLazy 'ervandew/supertab', { 'autoload': { 'insert': 1 } }

" }}}2
NeoBundleLazy 'vim-scripts/Align'
NeoBundle 'vim-scripts/AutoAlign', { 'depends': 'Align' }
NeoBundle 'DataWraith/auto_mkdir'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'garbas/vim-snipmate', { 'depends': 'vim-addon-mw-utils' }
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tsaleh/vim-align'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Townk/vim-autoclose'

" ColorSchemes: {{{1
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jnurmine/Zenburn'

" GIT And Version Controlish: bundles {{{1
" Fugitive: {{{2

" FIXME Gfixup is a work in progress
command! -nargs=? Gfixup :Gcommit --fixup=HEAD <q-args>

" helper functions {{{3

function! RunGitWrite()
    execute "Gwrite"
    call SignifyOnBufEnter()
endfunction

function! RunGitAddParts()
    execute "Git add -pi %"
    call SignifyOnBufEnter()
endfunction

" {,re}mappings {{{3
" this is a cross between the old git-vim commands I'm used to, but invoking
" fugitive instead.

nnoremap <silent> <Leader>gs :Gstatus<Enter>
nnoremap <silent> <Leader>gd :call Gitv_OpenGitCommand("diff --no-color -- ".expand('%'), 'new')<CR>
nnoremap <silent> <Leader>gD :call Gitv_OpenGitCommand("diff --no-color --cached %", 'new')<CR>
nnoremap <silent> <Leader>gh :call Gitv_OpenGitCommand("show --no-color", 'new')<CR>
nnoremap <silent> <Leader>ga :call RunGitWrite()<CR>
nnoremap <silent> <Leader>gc :Gcommit<Enter>
nnoremap <silent> <Leader>gf :Gcommit --fixup HEAD<CR>
nnoremap <silent> <Leader>gF :Gcommit --fixup 'HEAD~'<CR>
nnoremap <silent> <Leader>gS :Gcommit --squash HEAD

nnoremap <silent> <Leader>gA :call RunGitAddParts()<CR>
nnoremap <silent> <Leader>gl :Git lol<Enter>
nnoremap <silent> <Leader>gD :Git! diff --word-diff %<Enter>
nnoremap <silent> <Leader>gp :Git push<Enter>
nnoremap <silent> <Leader>gb :Gblame -w<Enter>

nnoremap <silent> <leader>gv :Gitv --all<cr>
nnoremap <silent> <leader>gV :Gitv! --all<cr>
vnoremap <silent> <leader>gV :Gitv! --all<cr>

" make handling indexes a little easier {{{3

" This section very happily stolen from / based on:
" https://github.com/aaronjensen/vimfiles/blob/master/vimrc

" Use j/k in status {{{3
function! BufReadIndex()
  setlocal cursorline
  setlocal nohlsearch

  nnoremap <buffer> <silent> j :call search('^#\t.*','W')<Bar>.<CR>
  nnoremap <buffer> <silent> k :call search('^#\t.*','Wbe')<Bar>.<CR>
endfunction

autocmd BufReadCmd *.git/index exe BufReadIndex()
autocmd BufEnter   *.git/index silent normal gg0j

" Start in insert mode for commit {{{3
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

" filetype autocmds (e.g. for pull req, tag edits, etc...) {{{3

" the 'hub' tool creates a number of comment files formatted in the same way
" as a git commit message.
autocmd BufEnter *.git/*_EDITMSG exe BufEnterCommit()

" Automatically remove fugitive buffers {{{3
autocmd BufReadPost fugitive://* set bufhidden=delete

" }}}3

NeoBundle 'tpope/vim-fugitive', { 'augroup': 'fugitive' }

" Gitv: {{{2

let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_CommitStep             = 150

NeoBundleLazy 'gregsexton/gitv', {
            \ 'autoload': {
            \   'commands': 'Gitv',
            \   'functions': 'Gitv_OpenGitCommand',
            \ },
            \ 'depends': ['vim-fugitive'],
            \ 'verbose': 1,
            \}

" Gist: {{{2

let g:gist_detect_filetype        = 1
let g:gist_clip_command           = 'xclip -selection clipboard'
let g:gist_post_private           = 1
let g:gist_show_privates          = 1
let g:gist_get_multiplefile       = 1

NeoBundleLazy 'mattn/gist-vim', {
            \ 'autoload': { 'commands': 'Gist' },
            \ 'depends': [ 'webapi-vim' ],
            \ 'verbose': 1,
            \}

" Signify: {{{2

" TODO: need to handle "normal" sign column
let g:signify_vcs_list      = [ 'git' ]
let g:signify_skip_filetype = { 'gitcommit': 1 }

" NOTE: This also saves the buffer to disk!
let g:signify_update_on_bufenter    = 1
let g:signify_update_on_focusgained = 1
let g:signify_cursorhold_normal     = 0
let g:signify_cursorhold_insert     = 0

func! SignifyOnBufEnter()
    "if exists('sy_path')
        call sy#start()
    "endif
endfunc

augroup vimrc-Signify
    autocmd!
    autocmd BufEnter * call SignifyOnBufEnter()
    autocmd WinEnter * call SignifyOnBufEnter()
augroup END

NeoBundle 'mhinz/vim-signify'

" }}}2
NeoBundle 'bartman/git-wip',    { 'rtp': 'vim', 'build': { 'unix': 'mkdir -p ~/bin ; ln -s `pwd`/git-wip ~/bin/ ||:' } }
NeoBundle 'vim-scripts/ConflictMotions',   { 'depends': [ 'CountJump' ] }
NeoBundle 'vim-scripts/ConflictDetection', { 'depends': [ 'CountJump' ] }

" Appish Or External Interface: bundles {{{1
" TweetVim: ...and configuration {{{2

augroup vimrc-tweetvim
    autocmd!
    autocmd FileType tweetvim setlocal nonumber foldcolumn=0
augroup END

nnoremap <Leader>TT :TweetVimHomeTimeline<CR>

let g:tweetvim_tweet_per_page   = 50
let g:tweetvim_display_source   = 1
let g:tweetvim_display_time     = 1
let g:tweetvim_expand_t_co      = 1
let g:tweetvim_display_username = 1

NeoBundleLazy 'basyura/twibill.vim'
NeoBundleLazy 'basyura/bitly.vim', { 'depends': 'webapi-vim' }
NeoBundleLazy 'tyru/open-browser.vim'
NeoBundleLazy 'mattn/favstar-vim'
NeoBundleLazy 'basyura/TweetVim', {
\ 'depends': [
\   'twibill.vim',
\   'bitly.vim',
\   'favstar-vim',
\   'open-browser.vim',
\   'webapi-vim',
\ ],
\ 'autoload': { 'commands' : [ 'TweetVimHomeTimeline', 'TweetVimSay', 'TweetVimCommandSay' ] },
\ 'verbose': 1,
\}

" TmuxLine: {{{2
NeoBundleLazy 'edkolev/tmuxline.vim', { 'autoload': { 'commands': ['Tmuxline', 'TmuxlineSnapshot'] }, 'verbose': 0 }

let g:tmuxline_powerline_separators = 0

" VimRepress: {{{2
NeoBundleLazy 'pentie/VimRepress', {
\ 'autoload': {
\   'commands': ['BlogNew', 'BlogOpen', 'BlogList'],
\ },
\ 'disabled': !has('python'),
\ 'verbose': 1,
\}
" Calendar: +config {{{2

let g:calendar_google_calendar = 1
let g:calendar_google_task     = 1

NeoBundleLazy 'itchyny/calendar.vim', {
\ 'autoload': {
\   'commands': 'Calendar',
\ },
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

" }}}2
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'vim-scripts/vimwiki'
NeoBundle 'hsitz/VimOrganizer'

" Perl Bundles: {{{1
" perl-in-vim bundles {{{2
NeoBundleLazy 'vim-scripts/update_perl_line_directives',    { 'autoload': { 'filetypes': 'vim.perl' }, 'disabled': !has('perl') }
NeoBundleLazy 'vim-scripts/syntax_check_embedded_perl.vim', { 'autoload': { 'filetypes': 'vim.perl' }, 'disabled': !has('perl') }
" }}}2
NeoBundle     'vim-perl/vim-perl'
NeoBundleLazy 'vim-scripts/log4perl.vim', { 'autoload': { 'filetypes': 'log4perl' } }
NeoBundleLazy 'osfameron/perl-tags-vim',  { 'autoload': { 'filetypes': 'perl'     } }
NeoBundleLazy 'LStinson/perlhelp-vim', { 'autoload': { 'filetypes': 'perl' } }
NeoBundleLazy 'c9s/cpan.vim', { 'autoload': { 'filetypes': 'perl' } }

" General Syntax And Filetype Plugins: bundles {{{1
" haml {{{2
NeoBundleLazy 'tpope/vim-haml', { 'autoload': { 'filetypes': ['haml','sass','scss'] } }
source ~/.vim/bundle/vim-haml/ftdetect/haml.vim

" puppet {{{2
NeoBundleLazy 'puppetlabs/puppet-syntax-vim', { 'autoload': { 'filetypes': 'puppet' } }
source ~/.vim/bundle/puppet-syntax-vim/ftdetect/puppet.vim

" CSV {{{2
NeoBundleLazy 'chrisbra/csv.vim', { 'autoload': { 'filetypes': 'csv' } }
source ~/.vim/bundle/csv.vim/ftdetect/csv.vim

" mkd {{{2

let g:vim_markdown_initial_foldlevel=1

NeoBundleLazy 'plasticboy/vim-markdown', { 'autoload': { 'filetypes': 'mkd' } }
source ~/.vim/bundle/vim-markdown/ftdetect/mkd.vim

" vim-chef and dependencies {{{2
NeoBundleLazy 'vadv/vim-chef', {
\   'autoload': { 'filetypes': [ 'chef' ] },
\   'depends': [
\       'tlib_vim',
\       'vim-snipmate',
\   ],
\   'verbose': 1,
\}
" deb.vim {{{2
NeoBundleLazy 'vim-scripts/deb.vim', {
\ 'autoload': { 'filename_patterns': '\.deb$' },
\ 'verbose': 1,
\}
" vim-go {{{2
NeoBundleLazy 'fatih/vim-go', {
\ 'augroup': 'vim-go',
\ 'autoload': {
\   'filetypes': ['godoc', 'gohtmltmpl', 'gotexttmpl', 'go', 'vimgo'],
\ },
\ 'verbose': 1,
\}
" vim-pinpoint {{{2
NeoBundleLazy 'fmoralesc/vim-pinpoint', {
\ 'autoload': {
\   'filetypes': 'pinpoint', 'filename_patterns': '\.pin$',
\ },
\}
"source ~/.vim/bundle/vim-pinpoint/ftdetect/pinpoint.vim

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
NeoBundleLazy 'nono/jquery.vim', { 'autoload': { 'filetypes': 'jquery' } }
NeoBundle 'zaiste/tmux.vim'
NeoBundle 'othree/html5-syntax.vim'
NeoBundle 'argent-smith/JSON.vim'
NeoBundle 'tmatilai/gitolite.vim'
NeoBundle 'evanmiller/nginx-vim-syntax'
NeoBundle 'vim-scripts/iptables'
NeoBundle 'RsrchBoy/interfaces' " syntax for /etc/network/interfaces
NeoBundle 'smancill/conky-syntax.vim'
NeoBundle 'apeschel/vim-syntax-syslog-ng'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'kurayama/systemd-vim-syntax'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-git'

" Trial Bundles: maybe, maybe not! {{{1
" VimGitLog: lazy {{{2
NeoBundleLazy 'kablamo/vim-git-log', { 'depends': 'vim-fugitive', 'autoload': { 'commands': 'GitLog' }, 'verbose': 1 }

" TSkeletons: {{{2

NeoBundle 'tomtom/tskeleton_vim', { 'depends': [ 'tlib_vim' ] }
NeoBundle 'tomtom/tskeletons', { 'depends': [ 'tskeleton_vim' ] }

" TabMan:

NeoBundleLazy 'kien/tabman.vim', {
            \   'autoload': {
            \       'commands': [ 'TMToggle', 'TMFocus' ],
            \       'mappings': [ '<leader>mt', '<leader>mf' ],
            \   },
            \   'verbose': 1,
            \}

" }}}2
NeoBundleLazy 'mattn/googletasks-vim', { 'verbose': 1, 'autoload': { 'commands': 'GoogleTasks' } }
NeoBundle 'vim-scripts/gtk-vim-syntax'
NeoBundle 'dhruvasagar/vim-table-mode'
NeoBundle 'tpope/vim-obsession'
NeoBundle 'freitass/todo.txt-vim'
NeoBundle 'mhinz/vim-tmuxify'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'vitalk/vim-simple-todo'
" jira 'integration' {{{2
NeoBundle 'mnpk/vim-jira-complete'
NeoBundle 'RsrchBoy/vim-jira-open'


" 18 Jul 2015 {{{2
" NOTE replaces: NeoBundle 'bronson/vim-trailing-whitespace'
" FIXME ... if it would just work.  grr
NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'chrisbra/NrrwRgn'
NeoBundle 'wesQ3/vim-windowswap'

" 27 Jul 2015 {{{2
NeoBundle 'tpope/vim-projectionist'
NeoBundleLazy 'klen/python-mode', { 'autoload': { 'filetypes': 'python' }, 'verbose': 1 }

" 11 Aug 2015 {{{2
NeoBundleLazy 'WolfgangMehner/lua-support', {
            \ 'verbose': 1,
            \ 'autoload': {
            \   'filetypes': 'lua',
            \ },
            \}

" }}}2
NeoBundleLazy 'dhruvasagar/vimmpc', { 'autoload': { 'commands': 'MPC' }, 'verbose': 1, 'disable': !has('python') }
NeoBundleLazy 'gcmt/taboo.vim'
NeoBundle 'tpope/vim-capslock'
NeoBundle 'tpope/vim-speeddating'
" see https://github.com/LucHermitte/local_vimrc
"NeoBundle 'LucHermitte/lh-vim-lib', {'name': 'lh-vim-lib'}
"NeoBundle 'LucHermitte/local_vimrc', {'depends': 'lh-vim-lib'}
" FIXME TODO need b:endwise_* settings for perl!
NeoBundle 'tpope/vim-endwise'
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

"}}}2

" Probation: {{{1
NeoBundleLazy 'lukaszkorecki/vim-GitHubDashBoard'
" github issues query
NeoBundleLazy 'mklabs/vim-issues'
" to help handle other author's tabstop/etc settings w/o explicit modelines
NeoBundleLazy 'embear/vim-localvimrc'
NeoBundleLazy 'thinca/vim-localrc'

" Attic: no longer used {{{1
" all {{{2
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

" key {,re}mappings {{{2
set pastetoggle=<F2>

" normal mode remappings
nnoremap <LocalLeader>fc :call ToggleFoldColumn()<CR>
nnoremap <F3> :setlocal nonumber!<CR>
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>
nnoremap <F7> :tabp<CR>
nnoremap <F8> :tabn<CR>

" visual/insert mode remappings
vnoremap <F3> :setlocal nonumber!<CR>
vnoremap <F5> :setlocal spell! spelllang=en_us<CR>
vnoremap <F7> :tabp<CR>
vnoremap <F8> :tabn<CR>

" make C-PgUp and C-PgDn work, even under screen
" see https://bugs.launchpad.net/ubuntu/+source/screen/+bug/82708/comments/1
:nmap <ESC>[5;5~ <C-PageUp>
:nmap <ESC>[6;5~ <C-PageDown>

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

    " this usually works, but sometimes vim thinks a .t file isn't Perl
    au BufNewFile,BufRead *.t set filetype=perl

    " common Chef patterns
    au BufNewFile,BufRead attributes/*.rb   set filetype=ruby.chef
    au BufNewFile,BufRead recipies/*.rb     set filetype=ruby.chef
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
" Syntax AU: {{{2

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

" colorscheme settings {{{2

let g:zenburn_high_Contrast = 1
let g:zenburn_transparent   = 1

let g:solarized_termtrans = 1
"let g:solarized_termcolors = 256 " needed on terms w/o solarized palette

" }}}2
colorscheme zenburn
syntax on

" Tagbar And CTags: configuration {{{1
" mappings {{{2

nnoremap <leader>q :TagbarToggle<CR>
nnoremap <leader>w :TagbarOpenAutoClose<CR>

" settings {{{2

let g:tagbar_autoclose = 0

" How to display different "custom" filetypes
"
" perl {{{3

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

" puppet {{{3

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

" }}}2

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

" cowsay {{{2
command! -range -nargs=* Cowsay <line1>,<line2>! cowsay -W 65
command! -range -nargs=* BorgCowsay <line1>,<line2>! cowsay -W 65 -b

" Perl helpers {{{2
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

" ATTIC: potentially useful, but unused or retired {{{1
" commented old bits {{{2
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

" POWERLINE: segments and settings {{{2

"" if you're using the rho-pi/dev ubuntu PPA, then you can install snapshots of
"" the 'almost-there, really' new powerline.

"" load the 'new' powerline if available
"let g:_powerline_vim = "/usr/lib/python2.7/dist-packages/powerline/bindings/vim/plugin/powerline.vim"

"let g:Powerline_symbols = 'fancy'
""let g:Powerline_theme  = 'skwp'

"" FIXME we should really have a decent fall-back statusline
"if filereadable(g:_powerline_vim)
    "" ok, this is *really* annoying
    ""source g:_powerline_vim
    "source /usr/lib/python2.7/dist-packages/powerline/bindings/vim/plugin/powerline.vim
"endif

""call Pl#Theme#RemoveSegment('lineinfo')
""call Pl#Theme#RemoveSegment('fileformat')

" }}}2

" vim: set foldmethod=marker foldlevel=1 foldcolumn=5 :


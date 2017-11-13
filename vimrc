" Name:             ~/.vimrc
" Summary:          My ~/.vimrc and configuration
" Maintainer:       Chris Weyl <cweyl@alumni.drew.edu>
" Canonical Source: https://github.com/RsrchBoy/vimfiles
" License:          CC BY-NC-SA 4.0 (aka Attribution-NonCommercial-ShareAlike)

" give any spawned shells a clue
let $IN_VIM = exists('$IN_VIM') ? $IN_VIM + 1 : 1

set encoding=utf-8
scriptencoding utf-8

" Vim Plug BEGIN: "strategic" plugin manager ;) {{{1
call plug#begin()

" General Bundles: {{{1
" Buffers And Tabs And Files Oh My: {{{2

Plug 'jeetsukumaran/vim-buffergator', { 'on': 'BuffergatorOpen' }

" TabMan: {{{3

" Settings: {{{4

let g:tabman_toggle = '<leader>mt'
let g:tabman_focus  = '<leader>mf'

" AutoLoad: {{{4
" load, then run.  this mapping will be overwritten on plugin load
execute "nnoremap <silent> " . g:tabman_toggle . " :call plug#load('tabman.vim') <bar> TMToggle<CR>"
execute "nnoremap <silent> " . g:tabman_focus  . " :call plug#load('tabman.vim') <bar> TMFocus<CR>"

" }}}4

Plug 'kien/tabman.vim', { 'on': [ 'TMToggle', 'TMFocus' ] }

" BufExplorer: {{{3

let g:bufExplorerShowRelativePath = 1
let g:bufExplorerShowTabBuffer    = 1

Plug 'jlanzarotta/bufexplorer'

" FuzzyFinder: {{{3

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

nnoremap <C-P> :Files<CR>

" }}}3

" Alignment: {{{2

" EasyAlign: {{{3

xmap gA <Plug>(EasyAlign)
nmap gA <Plug>(EasyAlign)

Plug 'junegunn/vim-easy-align', { 'on': [ '<Plug>(EasyAlign)', 'EasyAlign' ] }

" Tabular: {{{3

Plug 'godlygeek/tabular', {
            \   'on': [
            \       'Tabularize',
            \       'AddTabularPattern',
            \       'AddTabularPipeline',
            \   ],
            \}

" Mappings: {{{4

nnoremap <silent> ,= :Tabularize first_fat_comma<CR>
nnoremap <silent> ,- :Tabularize first_equals<CR>

nnoremap <silent> ,{  :Tabularize first_squiggly<CR>
nnoremap <silent> ,}  :Tabularize /}/l1c0<CR>
nnoremap <silent> ,]  :Tabularize /]/l1c0<CR>
nnoremap <silent> ,)  :Tabularize /)/l1c0<CR>

" PostSource Hook: {{{4

augroup vimrc#tabular
    au!

    au! User tabular call s:PluginLoadedTabular()
augroup END

" Do Things when the bundle is vivified
function! s:PluginLoadedTabular()

    " ...kinda.  assumes that the first '=' found is part of a fat comma
    AddTabularPattern first_fat_comma /^[^=]*\zs=>/l1
    AddTabularPattern first_equals    /^[^=]*\zs=/l1
    AddTabularPattern first_squiggly  /^[^{]*\zs{/l1
endfunction

" }}}4

" }}}3

" Follow My Lead: {{{2

" load, then run.  this mapping will be overwritten on plugin load
nnoremap <silent> <leader>fml :call plug#load('vim-follow-my-lead') <bar> execute ':call FMLShow()'<CR>

let g:fml_all_sources = 1

Plug 'rsrchboy/vim-follow-my-lead', { 'on': [ '<Plug>(FollowMyLead)', 'FMLShow' ] }

" Snippets: {{{2

let g:snippets_dir='~/.vim/snippets,~/.vim/bundle/*/snippets'

Plug 'SirVer/ultisnips'

" SuperTab: {{{2

" " FIXME appears to conflict with snipmate...?

let g:SuperTabNoCompleteAfter  = ['^', '\s', '\\']

Plug 'ervandew/supertab'

" Denite: unused?? {{{2

Plug 'Shougo/denite.nvim'
Plug 'rafi/vim-unite-issue'
Plug 'joker1007/unite-pull-request'

" Vim Look And Feel: {{{2

map /  <Plug>(incsearch-forward)

Plug 'haya14busa/incsearch.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jszakmeister/vim-togglecursor'

" BetterWhitespace: {{{3

let g:better_whitespace_filetypes_blacklist = [ 'git', 'mail', 'help', 'startify' ]

nmap <silent> ,<space> :StripWhitespace<CR>

Plug 'ntpeters/vim-better-whitespace'

" NeoComplete: ...and associated bundles {{{3

" FIXME finalize settings

" settings: {{{4

let g:deoplete#enable_at_startup = 1

" let g:neocomplete#enable_at_startup                 = 1
let g:neocomplete#enable_smart_case                 = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

"g:neocomplete#enable_auto_close_preview

"             \   'disabled': !has('lua'),

" perlomni settings: {{{4

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" }}}4

Plug 'Shougo/neoinclude.vim'

if has('python3')
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
endif

" filetype complete sources for deoplete
" Plug 'deoplete-go'      " go
Plug 'Shougo/neco-vim'  " viml
Plug 'c9s/perlomni.vim' " Perl

" other complete sources
Plug 'Shougo/neco-syntax'

" Startify: nifty start screen {{{3

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

Plug 'mhinz/vim-startify'

" Airline: {{{3

Plug 'bling/vim-airline'

" Settings: {{{4

let g:airline_theme = 'dark'

let g:airline#extensions#ale#enabled                  = 1
let g:airline#extensions#bufferline#enabled           = 0
let g:airline#extensions#obsession#enabled            = 1
let g:airline#extensions#syntastic#enabled            = 0
let g:airline#extensions#tabline#enabled              = 0
let g:airline#extensions#tabline#show_close_button    = 0
let g:airline#extensions#tabline#tab_min_count        = 2
let g:airline#extensions#tabline#buffer_nr_show       = 1
let g:airline#extensions#tagbar#enabled               = 1
let g:airline#extensions#tmuxline#enabled             = 0
let g:airline#extensions#whitespace#mixed_indent_algo = 1
" let g:airline#extensions#wordcount#enabled            = 0

let g:airline#extensions#tabline#ignore_bufadd_pat =
        \ '\c\vgundo|undotree|vimfiler|tagbar|nerd_tree|previewwindow|help|nofile'

" Branchname Config: {{{4
" if a string is provided, it should be the name of a function that
" takes a string and returns the desired value
let g:airline#extensions#branch#format = 'CustomBranchName'
function! CustomBranchName(name)
    "return '[' . a:name . ']'
    if a:name ==# ''
        return a:name
    endif

    let l:info = a:name

    " This isn't perfect, but it does keep things from blowing up rather
    " loudly when we're editing a file that's actually a symlink to a file in
    " a git work tree.  (This appears to confuse vim-fugitive.)
    try
        " let l:ahead  = fugitive#repo().git_chomp('rev-list', a:name.'@{upstream}..HEAD')
        " let l:behind = fugitive#repo().git_chomp('rev-list', 'HEAD..'.a:name.'@{upstream}')
        " let l:info  .= ' [+' . len(split(l:ahead, '\n')) . '/-' . len(split(l:behind, '\n')) . ']'
        let l:ahead  = len(split(fugitive#repo().git_chomp('rev-list', a:name.'@{upstream}..HEAD'), '\n'))
        let l:behind = len(split(fugitive#repo().git_chomp('rev-list', 'HEAD..'.a:name.'@{upstream}'), '\n'))
        let l:ahead  = l:ahead  ? 'ahead '  . l:ahead  : ''
        let l:behind = l:behind ? 'behind ' . l:behind : ''
        let l:commit_info = join(filter([l:ahead, l:behind], { idx, val -> val !=# '' }), ' ')
        let l:info .= len(l:commit_info) ? ' [' . l:commit_info . ']' : ''
    catch
        return a:name
    endtry

    return l:info
endfunction

" symbols {{{4
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇ '
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" AutoCommands: {{{4

augroup vimrc#airline
    au!

    " wipe on, say, :Dispatch or similar
    au QuickFixCmdPost dispatch-make-complete silent! unlet b:airline_head | AirlineRefresh
    au User FugitiveCommit                    silent! unlet b:airline_head | AirlineRefresh
    au FileChangedShellPost * silent! unlet b:airline_head | :AirlineRefresh
    au ShellCmdPost         * silent! unlet b:airline_head | :AirlineRefresh

    au User Fugitive silent! Glcd
augroup END

" PostSource Hook: {{{4

" FIXME: This was named incorrectly for some time; revalidate before
" reenabling
"au! User vim-airline call s:PluginLoadedAirline()

" Do Things when the bundle is vivified
function! s:PluginLoadedAirline()
    let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'capslock', 'tablemode', 'iminsert'])
endfunction

" }}}4

" DimInactive: {{{3

let g:diminactive_enable_focus = 1
let g:diminactive_filetype_blacklist = ['startify', 'fugitiveblame']

Plug 'blueyed/vim-diminactive'

" }}}3

" }}}2
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-characterize'
Plug 'DataWraith/auto_mkdir'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession'
Plug 'thinca/vim-ref'
" all those irksome ... irks
" Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'Shougo/junkfile.vim'
Plug 'tpope/vim-speeddating'
Plug 'christoomey/vim-system-copy'
Plug 'junegunn/vader.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'AndrewRadev/splitjoin.vim'

" Libraries: library plugins/bundles {{{1
" TLib: {{{2

Plug 'tomtom/tlib_vim'

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
Plug 'junegunn/vim-emoji'
Plug 'Shougo/context_filetype.vim'
Plug 'tpope/vim-repeat'

" Appish Or External Interface: bundles {{{1
" CodeRevew: pachreview, github, etc {{{2

Plug 'junkblocker/patchreview-vim'
Plug 'codegram/vim-codereview' ", { 'on': 'CodeReview' }

" ALE Or CALE: async linting {{{2

" NOTE this basically requires either vim8 or neovim; vim 7.4 etc aren't
" *that* old, so we'll include some checks...

" Function: s:MaybeLocalPlugin {{{3

function! s:MaybeLocalPlugin(name) abort

    if filereadable(expand('~/work/vim/' . a:name . '/.git/config'))
        Plug '~/work/vim/' . a:name
    else
        Plug 'rsrchboy/' . a:name
    endif

endfunction

" }}}3

if has('job') && has('timers') && has('channel')

    call s:MaybeLocalPlugin('vim-voose')
    call s:MaybeLocalPlugin('vim-kale')

    Plug 'rsrchboy/ale'

    " this clobbers :Glgrep
    let g:ale_set_loclist = 0

    let g:ale_docker_allow                = 1
    let g:ale_perl_perl_use_docker        = 'always'
    let g:ale_perl_perlcritic_showrules   = 1
    let g:ale_perl_perlcritic_as_warnings = 1

    " calm things down a bit
    let g:ale_type_map = { 'phpcs': { 'ES': 'WS', 'E': 'W' } }

    " additional aliases
    let g:ale_linter_aliases = {
                \   'vader': 'vim',
                \}
    " tweak linters lists
    let g:ale_linters = {
                \   'perl': [ 'perlcritic', 'proselint' ],
                \   'help': [ 'proselint'               ],
                \}
    " configure fixers
    let g:ale_fixers = {
                \   'help': [ 'remove_trailing_lines', 'align_help_tags' ],
                \}

    augroup vimrc#ale
        au!

        " if our f/t is perl, set some additional options
        " FIXME this might be good for other plugins too...
        au User Fugitive let b:git_worktree = fugitive#repo().tree()
        au User Fugitive if &ft == 'perl'
                \   | let b:ale_perl_perl_options = '-I ' . b:git_worktree . '/lib'
                \       . ' -I ' . b:git_worktree . '/t/lib'
                \   | endif
    augroup END
endif

" Travis: status {{{2

if has('python')
    Plug 'keith/travis.vim', { 'on': 'Travis' }
endif

" GithubIssues: {{{2

" NOTE: don't autoload on gitcommit f/t at the moment, as this plugin either
" does not support authenticated requests (or we don't have it configured) and
" it's WICKED SLOW when the number of allowed requests is exceeded.

if has('python')
    Plug 'jaxbot/github-issues.vim', { 'on': ['Gissues', 'Gmiles', 'Giadd'] }
endif

" VimOrganizer: {{{2

Plug 'hsitz/VimOrganizer', { 'for': ['org', 'vimorg-agenda-mappings', 'vimorg-main-mappings'] }

" VimPipe: {{{2

" Settings: {{{3

" default mappings conflict with PerlHelp
let g:vimpipe_invoke_map = ',r'
let g:vimpipe_close_map  = ',p'

" AutoCommands: set pipe commands for specific filetypes {{{3

augroup vimrc-vimpipe
    au!

    " perl settings handled in after/ftplugin/perl.vim
    autocmd FileType puppet let b:vimpipe_command="T=`mktemp`; cat - > $T && puppet-lint $T; rm $T"

augroup end

" AutoLoad: {{{3

" load, then run.  this mapping will be overwritten on plugin load
execute 'nnoremap <silent> ' . g:vimpipe_invoke_map . " :call plug#load('vim-pipe') <bar> %call VimPipe()<CR>"

" }}}3

Plug 'krisajenkins/vim-pipe', { 'on': [] }

" Notes: an alternative to vimwiki?? {{{2

" FIXME need to figure out the significance of other files in the notes dirs
" first
let g:notes_directories = [ '~/Shared/notes' ]
let g:notes_suffix = '.notes'

Plug 'xolox/vim-notes'

" DbExt: {{{2


if has('perl')

    " TODO: disable unless we have DBI, etc, installed.
    Plug 'vim-scripts/dbext.vim', {
                \   'on': [
                \       'DBDescribe',
                \       'DBExec',
                \       'DBList',
                \       'DBPrompt',
                \       'DBSelect',
                \   ],
                \}
endif

" GitHub Integration: {{{2

" github-complete {{{3

Plug 'rhysd/github-complete.vim'

" GitHub Dashboard: {{{3

let g:github_dashboard = {}
let g:github_dashboard['emoji'] = 1
let g:github_dashboard['RrschBoy'] = 1

if has('ruby')
    Plug 'junegunn/vim-github-dashboard', { 'on': ['GHA', 'GHD', 'GHDashboard', 'GHActivity'] }
endif

" }}}3

" TweetVim: {{{2

Plug 'basyura/twibill.vim'
Plug 'basyura/bitly.vim'
Plug 'tyru/open-browser.vim'
Plug 'mattn/favstar-vim'
Plug 'basyura/TweetVim', { 'on': [
            \   'TweetVimAddAccount',
            \   'TweetVimCommandSay',
            \   'TweetVimHomeTimeline',
            \   'TweetVimSay',
            \ ] }

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

" Slack: hmmmm {{{2

Plug 'heavenshell/vim-slack', { 'on': ['Slack','SlackFile'] }

" Calendar: +config {{{2

let g:calendar_google_calendar = 1
let g:calendar_google_task     = 1

Plug 'itchyny/calendar.vim', { 'on': 'Calendar' }

" Vitra: Trac interface {{{2

" NOTE: we don't actually use this plugin anymore, not having need to access
" any Trac servers.

" most of our trac server configuration will be done in ~/.vimrc.local
" so as to prevent userids and passwords from floating about :)

" default: 'status!=closed'
let g:tracTicketClause = 'owner=cweyl&status!=closed'
let g:tracServerList   = {}

augroup vimrc#vitra
    au!

    au User vitra call s:PluginLoadedVitra()
augroup END

" Do Things when the bundle is vivified
function! s:PluginLoadedVitra()
    augroup vimrc-vitra
        au!
        autocmd BufWinEnter Ticket:*      setlocal nonumber foldcolumn=0
        autocmd BufWinEnter Ticket:.Edit* setlocal filetype=tracwiki spell spelllang=en_us spellcapcheck=0 foldcolumn=0
    augroup end
endfunction

" Plug 'vim-scripts/tracwiki'
" Plug 'nsmgr8/vitra', { 'on': 'TTOpen' }

" VimRepress: {{{2

if has('python')
    Plug 'pentie/VimRepress', { 'on': ['BlogNew', 'BlogOpen', 'BlogList'] }
endif

" MediaWiki Editor: {{{2

if has('python')
    Plug 'aquach/vim-mediawiki-editor', {
                \   'for': 'mediawiki',
                \   'on': ['MWRead', 'MWWrite', 'MWBrowse'],
                \}
endif

" TmuxLine: {{{2

let g:tmuxline_powerline_separators = 0

let g:tmuxline_preset = {
    \'a'    : ['#(whoami)@#H'],
    \'b'    : '#S',
    \'win'  : ['#I#F', '#W'],
    \'cwin' : ['#I#F', '#W'],
    \}

Plug 'edkolev/tmuxline.vim', { 'on': ['Tmuxline', 'TmuxlineSnapshot'] }

" TmuxFocusEvents: {{{2

Plug 'tmux-plugins/vim-tmux-focus-events'

" Tmux Navigator: {{{2

Plug 'christoomey/vim-tmux-navigator'

" Mappings: move even in insert mode
inoremap <silent> <C-H> <ESC>:TmuxNavigateLeft<cr>
inoremap <silent> <C-J> <ESC>:TmuxNavigateDown<cr>
inoremap <silent> <C-K> <ESC>:TmuxNavigateUp<cr>
inoremap <silent> <C-L> <ESC>:TmuxNavigateRight<cr>
inoremap <silent> <C-\> <ESC>:TmuxNavigatePrevious<cr>

" Terraform: {{{2

" load this plugin on filename matches
augroup vimrc-terraform
    au!

    au BufRead,BufNewFile *.tf{,state,vars} execute 'au! vimrc-terraform' | call plug#load('vim-terraform')
augroup END

Plug 'hashivim/vim-terraform', { 'for': [ 'terraform' ] }

" VimWiki: {{{2

let g:vimwiki_use_calendar = 1
let g:calendar_action      = 'vimwiki#diary#calendar_action'
let g:calendar_sign        = 'vimwiki#diary#calendar_sign'

let g:vimwiki_list = [{'path': '~/Shared/vimwiki/', 'path_html': '~/public_html/'}]

            " \     '<leader>ww',
            " \     '<leader>wt',
            " \     '<leader>ws',
            " \     '<leader>w<leader>t',

Plug 'vim-scripts/vimwiki', {
            \ 'on': [
            \     'Vimwiki',
            \     'VimwikiIndex',
            \     '<Plug>Vimwiki',
            \ ],
            \}

" }}}2
Plug 'diepm/vim-rest-console'
Plug 'cryptomilk/git-modeline.vim'


" GIT And Version Controlish: bundles {{{1
" Hub: ...and pandoc, for better PR formatting {{{2

Plug 'vim-pandoc/vim-pandoc'
Plug 'jez/vim-github-hub'

" Gitv: {{{2

" Settings: {{{3

let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_CommitStep             = 150
let g:Gitv_TellMeAboutIt          = 0

" AutoCommands: {{{3

augroup vimrc-gitv
    au!

    " autoload gitv
    au FuncUndefined Gitv_OpenGitCommand :call plug#load('gitv')

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
" Plug 'gregsexton/gitv', {
Plug 'RsrchBoy/gitv', { 'on': 'Gitv' }

" Extradite: {{{2

Plug 'int3/vim-extradite', { 'on': 'Extradite' }

" Settings: {{{3

let g:extradite_showhash = 1

" Mappings: {{{3

nnoremap <silent> <Leader>gE :Extradite<CR>

" AutoCmds: {{{3

augroup vimrc#extradite
    au!

    au FileType extradite nnoremap <buffer> <silent> <F1> :h extradite-mappings<CR>
    au User vim-extradite call s:PluginLoadedExtradite()
augroup END

" PostSource Hook: {{{3

" Do Things when the bundle is vivified
function! s:PluginLoadedExtradite()

    " create the buffer-local :Extradite command
    silent! execute 'doautocmd User Fugitive'

    augroup vimrc#extradite#post_source_hook
        au!

        " ...and in buffers created before we loaded extradite, too
        au CmdUndefined Extradite :doautocmd User Fugitive
    augroup END
endfunction

" }}}3

" Git WIP: {{{2

let g:git_wip_disable_signing = 1

Plug 'RsrchBoy/git-wip', { 'rtp': 'vim' }
            " we handle this with our dotfiles now
            " \   'do': 'cp vim/plugin/git-wip ~/bin/git-wip',
            " \}

" Fugitive: {{{2

" FIXME Gfixup is a work in progress
command! -nargs=? Gfixup :Gcommit --no-verify --fixup=HEAD <q-args>

" {,re}mappings {{{3
" this is a cross between the old git-vim commands I'm used to, but invoking
" fugitive instead.

nmap <silent> <Leader>gs :Gstatus<Enter>
nmap <silent> <Leader>gd :call Gitv_OpenGitCommand("diff --no-color -- ".expand('%'), 'new')<CR>
nmap <silent> <Leader>gD :Gdiff<CR>
nmap <silent> <Leader>gh :call Gitv_OpenGitCommand("show --no-color", 'new')<CR>
nmap <silent> <Leader>ga :Gwrite<bar>call sy#start()<CR>
nmap <silent> <Leader>gc :Gcommit<Enter>
nmap <silent> <Leader>gf :Gcommit --no-verify --fixup HEAD --no-verify<CR>
nmap <silent> <Leader>gF :Gcommit --no-verify --fixup 'HEAD~'<CR>
nmap <silent> <Leader>gS :Gcommit --no-verify --squash HEAD

" trial -- intent to add
nmap <silent> <Leader>gI :Git add --intent-to-add %<bar>call sy#start()<CR>

" nmap <silent> <Leader>gA :execute ':!git -C ' . b:git_worktree . ' add -pi ' . resolve(expand('%')) <bar> call sy#start()<CR>
nmap <silent> <Leader>gA :execute ':!git -C ' . b:git_worktree . ' add -pi ' . fugitive#buffer().path() <bar> call sy#start()<CR>
nmap <silent> <Leader>gp :Git push<CR>
nmap <silent> <Leader>gb :DimInactiveBufferOff<CR>:Gblame -w<CR>

nmap <silent> <leader>gv :GV<cr>
nmap <silent> <leader>gV :GV!<cr>

" autocmds (e.g. for pull req, tag edits, etc...) {{{3

augroup vimrc-fugitive
    au!

    " Automatically remove fugitive buffers
    autocmd BufReadPost fugitive://* set bufhidden=delete

    " e.g. after we did something :Dispatchy, like :Gfetch
    au QuickFixCmdPost .git/**/index call fugitive#reload_status()

    " on buffer initialization, set our work and common dirs
    au User Fugitive     let b:git_worktree  = fugitive#buffer().repo().tree()
    au User FugitiveBoot let b:git_commondir = fugitive#buffer().repo().git_chomp('rev-parse','--git-common-dir')
augroup END
" }}}3

" fugitive has a number of bugs/PR's outstanding related to symlinks (files in
" buffers, directories, repository locations, worktrees, etc) and worktrees.
"
" Unfortunately, these are things I use rather heavily, so it looks like I get
" to maintain my own fork for a while... le sigh
Plug 'rsrchboy/vim-fugitive'

" Plugins: for :Gbrowse {{{3

Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tommcdo/vim-fubitive'

" }}}3

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

    " note with the right tweaks to tmux and the use of vim-tmux-focus-events
    " this works with console vim as well!
    autocmd FocusGained * call sy#start()
augroup END

" }}}3

" }}}2
Plug 'tpope/vim-git'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'rhysd/conflict-marker.vim'
Plug 'gisphm/vim-gitignore'


" Perl Bundles: {{{1
" Perl: main vim-perl plugin {{{2

" support highlighting for the new syntax
let g:perl_sub_signatures=1

" use my fork until several PR's are merged (orig: vim-perl/...)
Plug 'RsrchBoy/vim-perl', { 'branch': 'active' }

" }}}2
Plug 'LStinson/perlhelp-vim', { 'on': ['PerlHelp', 'PerlMod'] }
Plug 'vim-scripts/log4perl.vim'

" General Syntax And Filetype Plugins: bundles {{{1
" GnuPG: transparently work with encrypted files {{{2

Plug 'jamessan/vim-gnupg', { 'on': [] }

" Hooks And Loaders: {{{3

augroup vimrc#gnupg
    au!

    " force the autocmds to run after we've loaded the plugin
    au User vim-gnupg nested edit
    au BufRead,BufNewFile *.{gpg,asc,pgp,pause} call plug#load('vim-gnupg') | execute 'au! vimrc#gnupg BufRead,BufNewFile'
augroup END

" Settings: {{{3

let g:GPGPreferArmor       = 1
let g:GPGDefaultRecipients = ['0x84CC74D079416376', '0x1535F82E8083A84A']
let g:GPGFilePattern       = '\(*.\(gpg\|asc\|pgp\)\|.pause\)'

" }}}3

" go: {{{2

" Settings: {{{3

let g:go_highlight_functions         = 1
let g:go_highlight_methods           = 1
let g:go_highlight_fields            = 1
let g:go_highlight_types             = 1
let g:go_highlight_operators         = 1
let g:go_highlight_build_constraints = 1

" }}}3

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" mkd {{{2

Plug 'plasticboy/vim-markdown', { 'for': [ 'mkd', 'markdown', 'mkd.markdown' ] }

let g:vim_markdown_initial_foldlevel = 1
let g:vim_markdown_frontmatter       = 1

" vim: {{{2

" scriptease: {{{3

" Not a complete autovivification, but enough. 90% of the time we'll have at
" least one buffer open with a vim ft and that'll trigger the load anyways.

" we may (will) use this mapping largely outside of vim-ft files
nmap zS <Plug>ScripteaseSynnames

Plug 'tpope/vim-scriptease', {
            \   'on': [ '<Plug>ScripteaseSynname', 'Scriptnames', 'Runtime', 'PP', 'PPmsg', 'Messages' ],
            \   'for': 'vim',
            \}

" embedded perl: {{{3

if has('perl')
    Plug 'vim-scripts/update_perl_line_directives', { 'for': 'vim' }
    " The next looks quite promising, but needs to be updated to handle being
    " in a plugin directory vs ~/.vim.
    "Plug 'vim-scripts/syntax_check_embedded_perl.vim', { 'for': 'vim' }
    Plug 'RsrchBoy/syntax_check_embedded_perl.vim', { 'on': [] }
endif

" }}}3

" Lua: {{{2

" TODO these are basically all TRIAL bundles, as I haven't worked with much
" lua before now

" sooooo.... yeah.  may have to try these suckers out independently.

Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }
Plug 'xolox/vim-lua-inspect', { 'for': 'lua' }
Plug 'WolfgangMehner/lua-support', { 'for': 'lua' }

" html(ish) {{{2

Plug 'othree/html5-syntax.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-haml'
Plug 'kchmck/vim-coffee-script'
Plug 'nono/jquery.vim'
" CSS
Plug 'groenewege/vim-less'

" System Or App Configuration: {{{2

Plug 'RsrchBoy/vim-sshauthkeys'
Plug 'tmatilai/gitolite.vim'
Plug 'vim-scripts/iptables'
Plug 'RsrchBoy/interfaces' " syntax for /etc/network/interfaces
Plug 'chr4/nginx.vim'
Plug 'smancill/conky-syntax.vim'
Plug 'apeschel/vim-syntax-syslog-ng'
Plug 'wgwoods/vim-systemd-syntax'
Plug 'FredDeschenes/httplog'
Plug 'vim-scripts/openvpn', { 'for': 'openvpn' }
" Plug 'chr4/sslsecure.vim'
Plug 'tmux-plugins/vim-tmux'

" Configuration Management: e.g. puppet, chef, etc {{{2

Plug 'puppetlabs/puppet-syntax-vim', { 'for': 'puppet' }
Plug 'vadv/vim-chef',                { 'for': 'chef'   }
Plug 'pearofducks/ansible-vim'
" for ansible templates
Plug 'lepture/vim-jinja'

" Packaging: deb, arch, etc {{{2

Plug 'vim-scripts/deb.vim'
Plug 'Firef0x/PKGBUILD.vim'

" Programming Languages: ...that aren't Perl {{{2

Plug 'vim-ruby/vim-ruby'
Plug 'klen/python-mode',             { 'for': 'python' }
Plug 'rust-lang/rust.vim'

" File Formats: csv, json, et al {{{2

Plug 'rhysd/vim-json',   { 'branch': 'reasonable-bool-number' }
Plug 'chrisbra/csv.vim', { 'for':    'csv'                    }

" }}}2
Plug 'cespare/vim-toml'
Plug 'ekalinin/Dockerfile.vim'
Plug 'fmoralesc/vim-pinpoint'
Plug 'vim-scripts/gtk-vim-syntax'
Plug 'chikamichi/mediawiki.vim'
Plug 'easymotion/vim-easymotion'
Plug 'rsrchboy/mojo.vim'
Plug 'exu/pgsql.vim'
Plug 'andrewstuart/vim-kubernetes'
Plug 'tpope/vim-afterimage'

" Text Objects: {{{1
" See also https://github.com/kana/vim-textobj-user/wiki
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-diff'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'glts/vim-textobj-comment'
call s:MaybeLocalPlugin('vim-textobj-heredocs')
Plug 'reedes/vim-textobj-quote'
Plug 'kana/vim-textobj-line'
" Plug 'Julian/vim-textobj-brace'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'lucapette/vim-textobj-underscore'
Plug 'kana/vim-textobj-function'
" note: php/python/ruby/etc helpers exist, if we start dabbling there
Plug 'thinca/vim-textobj-function-perl', { 'for': 'perl' }
Plug 'vimtaku/vim-textobj-sigil',        { 'for': 'perl' }
Plug 'spacewander/vim-textobj-lua',      { 'for': 'lua'  }
Plug 'akiyan/vim-textobj-php',           { 'for': 'php'  }

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

Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }

" 'freitass/todo.txt-vim' {{{2

" settings unchanged

nnoremap <silent> <Leader>td :split ~/todo.txt<CR>

" Autocmds: {{{4

augroup vimrc-todo.txt
    au!

    " self-removes on execution -- note it is important to do the removal
    " *first*, otherwise Very Bad Things happen.  (or at least Things That
    " Look Like Very Bad Things)
    au BufNewFile,BufRead *[Tt]odo.txt execute 'au! vimrc-todo.txt' | call plug#load('todo.txt-vim') | execute 'set ft=todo'
augroup END

" PostSource Hook: {{{4

" ensure our autoload hook is dropped, however we get loaded
au User todo.txt execute 'au! vimrc-todo.txt'

" }}}4

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
Plug 'mattn/googletasks-vim', { 'on': 'GoogleTasks' }
" filetype
Plug 'jtratner/vim-flavored-markdown'
" Plug 'kien/rainbow_parentheses.vim'

" Jira Integration: {{{2
Plug 'mnpk/vim-jira-complete', {'on': []}
Plug 'RsrchBoy/vim-jira-open', {'on': []}
" }}}2


" Unmanaged Plugins: {{{1
" Perl: {{{2

if has('perl')

    " the Perl API -- we just want it, no vim bits
    Plug 'mikegrb/WebService-Linode', { 'on': [] }
    " g:plug_home is set by plug#begin(), tho not documented (AFAICT)
    perl push @INC, VIM::Eval('g:plug_home') . '/WebService-Linode/lib'
    call s:MaybeLocalPlugin('vim-linode')

    call s:MaybeLocalPlugin('vim-embedded-perl')
endif

call s:MaybeLocalPlugin('vim-ducttape')

" }}}2

" Source any plugin-related 'dropins'
call rsrchboy#sourcecfgdir('plugins')

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

" set title
set autoindent                 " Preserve current indent on new lines
set autoread                   " reload when changed -- e.g. 'git co ...'
set background=dark
" set backspace=eol,start,indent
set backspace=indent,eol,start " Make backspaces delete sensibly
set expandtab                  " Convert all tabs typed to spaces
set hidden
set ignorecase
set incsearch
set laststatus=2
" set lazyredraw
set list
" set listchars+=tab:\|.
set matchpairs+=<:>            " Allow % to bounce between angles too
set modeline
set modelines=2
set nostartofline              " try to preserve column on motion commands
set number
set shiftround                 " Indent/outdent to nearest tabstop
set shiftwidth=4               " Indent/outdent by four columns
set showmatch
set smartcase
set smarttab
set spellfile+=~/.vim/spell/en.utf-8.add
set splitright                 " open new vsplit to the right
set t_Co=256                   " Explicitly tell Vim we can handle 256 colors
set tabstop=4                  " Indentation levels every four columns
set textwidth=78               " Wrap at this column
set ttimeoutlen=10
set ttyfast
set whichwrap+=<,>,h,l
" XXX reexamine 'nobackup'
set nobackup                   " we're stashing everything in git, anyways
" XXX reexamine 'noswapfile'
set noswapfile


let g:maplocalleader = ','

" terminal bits: {{{2

" initial hackery to let us set terminal titles!

if &term =~ 'screen.*'
    set t_ts=k
    set t_fs=\
endif
" if &term =~ 'screen.*' || &term == 'xterm'
" if exists("$TMUX")
if exists('$TMUX') && empty($TMUX)
    " set title
    " set titlestring=%{rsrchboy#termtitle()}
endif

" folding {{{2

" Start our folding at level 1, but after that enforce at a high enough level
" that we shouldn't discover our current position has been folded away after
" switching windows
set foldlevelstart=1
set foldlevel=10
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
    let l:l0 = getline(a:lnum)

    if l:l0 =~ '^##'
        return '>'.(matchend(getline(v:lnum),'^#\+')-1)
    elseif l:l0 =~ '^#='
        return '>0'
    endif

    return '='
endfunc

"}}}2

" Mappings: {{{1
" Section: memory aids ;)  {{{2

nnoremap <leader>SS :call rsrchboy#ShowSurroundMappings()<CR>
nnoremap <leader>SM :call rsrchboy#ShowBufferMappings()<CR>

nnoremap <leader>GM :call rsrchboy#cheats#mappings()<CR>

" Text Formatting: {{{2

" vmap Q gq

" " FIXME: should this be "gqip"?
" nmap Q gqap

" Configy: {{{2
set pastetoggle=<F2>

" Normal Mode Mappings: {{{2
nmap <Leader>fc :call ToggleFoldColumn()<CR>

" this is somewhat irksome
nmap <silent> <Leader>ft :filetype detect<CR>

nmap <silent> <F1> :h rsrchboy-normal-mappings<CR>
nmap <silent> <F3> :setlocal nonumber!<CR>
nmap <silent> <F5> :setlocal spell! spelllang=en_us<CR>
nmap <silent> <F7> :tabp<CR>
nmap <silent> <F8> :tabn<CR>

" Stop suspending, more shelling.  This should be less frustrating than often
" being in an unexpected directory
nnoremap <C-Z> :shell<CR>

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
    au BufNewFile,BufRead *access.log*        set filetype=httplog
    au BufRead,BufNewFile */.ssh/config.d/*   set filetype=sshconfig

    " e.g. /etc/NetworkManager/dnsmasq.d/...
    au BufNewFile,BufRead **/dnsmasq.d/*         set filetype=dnsmasq

    " this usually works, but sometimes vim thinks a .t file isn't Perl
    au BufNewFile,BufRead *.t set filetype=perl

    " common Chef patterns
    au BufNewFile,BufRead attributes/*.rb   set filetype=ruby.chef
    au BufNewFile,BufRead recipes/*.rb      set filetype=ruby.chef
    au BufNewFile,BufRead templates/*/*.erb set filetype=eruby.chef

    " FIXME commenting this out, as vim-github-hub should set this for us
    " " the 'hub' tool creates a number of comment files formatted in the same way
    " " as a git commit message.
    " autocmd BufEnter *.git/**/*_EDITMSG set filetype=gitcommit

    " openvpn bundle config files
    autocmd BufNewFile,BufRead *.ovpn set filetype=openvpn

    " dosini-style files
    autocmd BufNewFile,BufRead .tidyallrc    set filetype=dosini
    autocmd BufNewFile,BufRead .perlcriticrc set filetype=dosini
augroup end

" filetype-specific autocommands {{{2

augroup vimrc-filetype
    au!

    " these have been moved to ftplugin/ files.
    "
    " ...mostly
    autocmd FileType crontab    setlocal commentstring=#\ %s
    autocmd FileType debcontrol setlocal commentstring=#\ %s
    autocmd FileType GV         setlocal nolist
    autocmd FileType tmux       set tw=0
augroup end

" }}}2

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

" JsonTidy: {{{2
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
" ~/.vimrc.d {{{2

" This will allow the use of "drop-in" configs

call rsrchboy#sourcedir('~/.vimrc.d')

" ~/.vimrc.local {{{2

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" }}}2

" FINALIZE: set secure, etc.  closing commands. {{{1
" commands {{{2
set secure
set exrc

" }}}2

" vim: set foldmethod=marker foldcolumn=5 :

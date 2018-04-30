" Name:             ~/.vimrc
" Summary:          My ~/.vimrc and configuration
" Maintainer:       Chris Weyl <cweyl@alumni.drew.edu>
" Canonical Source: https://github.com/rsrchboy/vimfiles
" License:          CC BY-NC-SA 4.0 (aka Attribution-NonCommercial-ShareAlike)

" give any spawned shells a clue
let $IN_VIM = exists('$IN_VIM') ? $IN_VIM + 1 : 1

set encoding=utf-8
scriptencoding utf-8

" Plugins: ;) {{{1
call plug#begin() " {{{2

" The 'Plug' command (understandably) barfs on script-local variables, so
" we're going to kinda kludge it with a global we'll use and unlet later.

let g:pluginOpts = {}

function! s:MaybeLocalPlugin(name) abort " {{{2

    " this is getting a touch unwieldly
    if filereadable(expand('~/work/vim/' . a:name . '/.git/config'))
        Plug '~/work/vim/' . a:name
    elseif filereadable(expand('~/work/vim/' . a:name . '/.git')) " worktree
        Plug '~/work/vim/' . a:name
    elseif filereadable(expand('/shared/git/vim/' . a:name . '/.git/config'))
        Plug '/shared/git/vim/' . a:name
    else
        Plug 'rsrchboy/' . a:name
    endif

endfunction

" Plugins: general bundles: {{{2

Plug 'jlanzarotta/bufexplorer', { } " {{{3

let g:bufExplorerShowRelativePath = 1
let g:bufExplorerShowTabBuffer    = 1

Plug 'AndrewRadev/splitjoin.vim' " {{{3

let g:splitjoin_trailing_comma = 1

Plug 'junegunn/vim-easy-align', { 'on': [ '<Plug>(EasyAlign)', 'EasyAlign' ] } " {{{3

xmap gA <Plug>(EasyAlign)
nmap gA <Plug>(EasyAlign)

" s:tabularPlugOpts {{{3

let s:tabularPlugOpts = {
            \   'on': [
            \       'Tabularize',
            \       'AddTabularPattern',
            \       'AddTabularPipeline',
            \   ],
            \}

call plug#('godlygeek/tabular', s:tabularPlugOpts)  " {{{3

" TODO probably can drop this entirely in favor of easyalign

" Mappings: {{{4

nnoremap <silent> ,= :Tabularize first_fat_comma<CR>
nnoremap <silent> ,- :Tabularize first_equals<CR>

nnoremap <silent> ,{  :Tabularize first_squiggly<CR>
nnoremap <silent> ,}  :Tabularize /}/l1c0<CR>
nnoremap <silent> ,]  :Tabularize /]/l1c0<CR>
nnoremap <silent> ,)  :Tabularize /)/l1c0<CR>

augroup vimrc#tabular " {{{3
    au!

    au! User tabular call s:PluginLoadedTabular()
augroup END

function! s:PluginLoadedTabular() " {{{3

    " ...kinda.  assumes that the first '=' found is part of a fat comma
    AddTabularPattern first_fat_comma /^[^=]*\zs=>/l1
    AddTabularPattern first_equals    /^[^=]*\zs=/l1
    AddTabularPattern first_squiggly  /^[^{]*\zs{/l1
endfunction

" }}}4

Plug 'SirVer/ultisnips' " {{{3

" " give this a shot
" Plug 'KeyboardFire/vim-minisnip'
" Plug 'joereynolds/deoplete-minisnip'

let g:snippets_dir='~/.vim/snippets,~/.vim/plugged/*/snippets'

Plug 'ervandew/supertab' " {{{3

let g:SuperTabNoCompleteAfter  = ['^', '\s', '\\']

Plug 'kana/vim-arpeggio'            " {{{3
augroup vimrc#arpeggio " {{{3
    au!
    au! VimEnter,SessionLoadPost * call s:PluginLoadedArpeggio()
    au! User vim-arpeggio          call s:PluginLoadedArpeggio()
augroup END

fun! s:PluginLoadedArpeggio() " {{{3
    if get(g:, 'SessionLoad', 0) || !exists(':Arpeggio')
        return
    endif
    Arpeggio inoremap jk  <Esc>
    " Arpeggio inoremap WQ  <Esc>:wq<CR>
    Arpeggio imap WQ  <Esc>:wq<CR>
    Arpeggio nmap WQ  :wq<CR>
    Arpeggio nnoremap OW  :only<CR>
endfun

Plug 'haya14busa/incsearch.vim' " {{{3

map /  <Plug>(incsearch-forward)

Plug 'ntpeters/vim-better-whitespace' " {{{3

let g:better_whitespace_filetypes_blacklist = [ 'git', 'mail', 'help', 'startify', 'diff' ]

nmap <silent> ,<space> :StripWhitespace<CR>

Plug 'mhinz/vim-startify' " {{{3

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

Plug 'vim-airline/vim-airline' " {{{3

let g:airline_theme = 'dark'

let g:airline#extensions#ale#enabled                  = 1
let g:airline#extensions#bufferline#enabled           = 0
let g:airline#extensions#obsession#enabled            = 1
let g:airline#extensions#fugitiveline#enabled         = 0
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

let g:airline#extensions#branch#format = 'CustomBranchName'
let g:airline#extensions#hunks#non_zero_only = 1

function! CustomBranchName(name) " {{{3

    if a:name ==# ''
        return a:name
    endif

    if (@% =~# '^fugitive://.*') && &diff

        " See ':h fugitive-revision'
        " fugitive:///home/rsrchboy/.vim/.git//0/...
        if @% =~# '^fugitive://.*//0/.*'
            return a:name
            " return '[INDEX] ' . a:name
        elseif @% =~# '^fugitive://.*//1/.*'
            return '[BASE] ' . a:name
        elseif @% =~# '^fugitive://.*//2/.*'
            return '[TARGET] ' . a:name
        elseif @% =~# '^fugitive://.*//3/.*'
            return '[MERGED] ' . a:name
        endif

    endif

    if &diff | return 'worktree(' . a:name . ')' | endif

    " skip fugitive buffers outright
    if @% =~# '^fugitive://.*'
        return ''
    endif

    let l:info = a:name

    " This isn't perfect, but it does keep things from blowing up rather
    " loudly when we're editing a file that's actually a symlink to a file in
    " a git work tree.  (This appears to confuse vim-fugitive.)
    try
        let l:flags = ''
        try
            let l:ahead  = ducttape#git#revlist_count(a:name.'@{u}..HEAD')
            let l:behind = ducttape#git#revlist_count('HEAD..'.a:name.'@{u}')
            let l:flags .= ducttape#git#has_staged()   ? '!' : ''
            let l:flags .= ducttape#git#has_modified() ? '&' : ''
            " #status() for rebase, merge, etc
            " #has_staged(), #has_stash()
            let l:state = ducttape#git#state()
            let l:flags .= len(l:state) ? ' ' . toupper(l:state) : ''
        catch /^Vim\%((\a\+)\)\=:E117/
            let l:ahead  = len(split(fugitive#repo().git_chomp('rev-list', a:name.'@{upstream}..HEAD'), '\n'))
            let l:behind = len(split(fugitive#repo().git_chomp('rev-list', 'HEAD..'.a:name.'@{upstream}'), '\n'))
        endtry
        let l:ahead  = l:ahead  ? 'ahead '  . l:ahead  : ''
        let l:behind = l:behind ? 'behind ' . l:behind : ''
        let l:commit_info = join(filter([l:ahead, l:behind], { idx, val -> val !=# '' }), ' ')
        let l:info .= l:flags
        let l:info .= len(l:commit_info) ? ' [' . l:commit_info . ']' : ''
    catch
        return a:name
    endtry

    return l:info
endfunction

if !exists('g:airline_symbols') " {{{3
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇ '
let g:airline_left_sep = ''
let g:airline_right_sep = ''

augroup vimrc#airline " {{{3
    au!

    " wipe on, say, :Dispatch or similar
    au QuickFixCmdPost      dispatch-make-complete call rsrchboy#statuslineRefresh()

    " a somewhat roundabout way to ensure the statusline of the window/buffer
    " we end up in is refreshed after a commit, so the subject is updated
    au User     FugitiveCommitFinish  let g:_statusline_needs_refreshing = 1
    au BufEnter *                     call s:BufEnterRefresh()

    " This is somewhat roundabout, but if we want to put the airline head
    " display back to something sensible this appears to be the only
    " reasonable way to do it w/o changing fugitive
    au OptionSet diff unlet! b:airline_head b:airline_head_subject |
    \   if has_key(w:, 'fugitive_diff_restore') |
    \       let w:fugitive_diff_restore .= '|unlet! b:airline_head b:airline_head_subject' |
    \   endif

    au FileChangedShellPost * call rsrchboy#statuslineRefresh()
    au ShellCmdPost         * call rsrchboy#statuslineRefresh()
    au FocusGained          * call rsrchboy#statuslineRefresh()
    au TabEnter             * unlet! b:airline_head b:airline_head_subject
    " au TabEnter,FocusGained * call rsrchboy#statuslineRefresh()
augroup END

fun! s:BufEnterRefresh() " {{{3
    if !exists('g:_statusline_needs_refreshing')
        return
    endif
    unlet g:_statusline_needs_refreshing
    call rsrchboy#statuslineRefresh()
    return
endfun

"au! User vim-airline call s:PluginLoadedAirline() " {{{3

" FIXME: This was named incorrectly for some time; revalidate before
" reenabling

" " Do Things when the bundle is vivified
" function! s:PluginLoadedAirline()
"     let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'capslock', 'tablemode', 'iminsert'])
" endfunction

Plug 'blueyed/vim-diminactive' " {{{3

let g:diminactive_enable_focus = 1
let g:diminactive_filetype_blacklist = ['startify', 'fugitiveblame']

Plug 'Carpetsmoker/confirm_quit.vim' " {{{3

let g:confirm_quit_nomap = 1

cnoremap <silent> q<CR>  :call confirm_quit#confirm(0, 'always')<CR>
cnoremap <silent> wq<CR> :call confirm_quit#confirm(1, 'always')<CR>
cnoremap <silent> x<CR>  :call confirm_quit#confirm(1, 'always')<CR>
nnoremap <silent> ZZ     :call confirm_quit#confirm(1, 'always')<CR>

" }}}3
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jszakmeister/vim-togglecursor'
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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dispatch'
Plug 'Shougo/junkfile.vim'
Plug 'tpope/vim-speeddating'
Plug 'christoomey/vim-system-copy'
Plug 'junegunn/vader.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'Raimondi/delimitMate'
Plug 'moll/vim-bbye', { 'on': 'Bdelete' }
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-peekaboo'

" Plugins: library plugins/bundles {{{2

Plug 'tomtom/tlib_vim'
Plug 'xolox/vim-misc'
Plug 'vim-scripts/ingo-library'
Plug 'vim-scripts/CountJump'
Plug 'mattn/webapi-vim'
Plug 'junegunn/vim-emoji'
Plug 'Shougo/context_filetype.vim'
Plug 'tpope/vim-repeat'

" Plugins: appish or external interface {{{2

Plug 'thinca/vim-ref'
Plug 'keith/travis.vim', { 'on': 'Travis' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " {{{3

nnoremap <C-P> :Files<CR>
nnoremap <C-L> :Tabs<CR>
nnoremap <C-O> :Projects<CR>

command! -bang -nargs=* GGrep
    \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)
command! -bang -nargs=0 Projects
    \ call rsrchboy#fzf#Projects(<bang>0)
command! -bang -nargs=0 Tabs
    \ call rsrchboy#fzf#Tabs(<bang>0)

" See help for *map-modes*
command! -bar -bang VMaps call fzf#vim#maps("v", <bang>0)
command! -bar -bang SMaps call fzf#vim#maps("s", <bang>0)
command! -bar -bang XMaps call fzf#vim#maps("x", <bang>0)
command! -bar -bang OMaps call fzf#vim#maps("o", <bang>0)
command! -bar -bang IMaps call fzf#vim#maps("i", <bang>0)
command! -bar -bang LMaps call fzf#vim#maps("l", <bang>0)
command! -bar -bang CMaps call fzf#vim#maps("c", <bang>0)
command! -bar -bang TMaps call fzf#vim#maps("t", <bang>0)

augroup vimrc#fzf " {{{3
    au!
    au User Fugitive nnoremap <buffer> <C-P> :GFiles --others --exclude-standard --cached<CR>
augroup END

Plug 'codegram/vim-codereview' ", { 'on': 'CodeReview' }
" call s:MaybeLocalPlugin('vim-voose'), { 'on': [] } " {{{3
" call s:MaybeLocalPlugin('vim-kale'),  { 'on': [] } " {{{3

let g:kale#verbose = 1

Plug 'rsrchboy/ale' " {{{3

" NOTE this basically requires either vim8 or neovim; vim 7.4 etc aren't
" *that* old, so we'll include some checks...

if has('job') && has('timers') && has('channel')

    let g:ale_command_wrapper = 'unshare --user --net --kill-child'

    " when enabled, this clobbers :Glgrep
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
                \   | let b:vimpipe_command  = 'perl -I ' . b:git_worktree . '/lib/ -'
                \   | endif
    augroup END
endif

Plug 'jaxbot/github-issues.vim', { 'on': ['Gissues', 'Gmiles', 'Giadd'] } " {{{3

let g:github_upstream_issues = 1
let g:gissues_lazy_load      = 1

Plug 'krisajenkins/vim-pipe', { 'on': [] } " {{{3

" default mappings conflict with PerlHelp
let g:vimpipe_invoke_map = ',r'
let g:vimpipe_close_map  = ',p'

" load, then run.  this mapping will be overwritten on plugin load
execute 'nnoremap <silent> ' . g:vimpipe_invoke_map . " :call plug#load('vim-pipe') <bar> %call VimPipe()<CR>"

augroup vimrc#vimpipe " {{{3
    au!
    " perl settings handled in after/ftplugin/perl.vim
    autocmd FileType puppet let b:vimpipe_command="T=`mktemp`; cat - > $T && puppet-lint $T; rm $T"
augroup end

Plug 'xolox/vim-notes', { 'on': 'Note' } " {{{3

" FIXME need to figure out the significance of other files in the notes dirs
" first
let g:notes_directories = [ '~/Shared/notes' ]
let g:notes_suffix = '.notes'

" g:pluginOpts.dbext {{{3

let g:pluginOpts.dbext =
            \ { 'on': [
            \       'DBDescribe',
            \       'DBExec',
            \       'DBList',
            \       'DBPrompt',
            \       'DBSelect',
            \   ],
            \}
" TODO: disable unless we have DBI, etc, installed.

Plug 'vim-scripts/dbext.vim', g:pluginOpts.dbext " {{{3
Plug 'itchyny/calendar.vim', { 'on': 'Calendar' } " {{{3

let g:calendar_google_calendar = 1
let g:calendar_google_task     = 1

" Plug 'vim-scripts/tracwiki' " {{{3

" NOTE: we don't actually use this plugin anymore, not having need to access
" any Trac servers.

" Plug 'nsmgr8/vitra', { 'on': 'TTOpen' } " {{{3

" NOTE: we don't actually use this plugin anymore, not having need to access
" any Trac servers.

" most of our trac server configuration will be done in ~/.vimrc.local
" so as to prevent userids and passwords from floating about :)

" default: 'status!=closed'
let g:tracTicketClause = 'owner=cweyl&status!=closed'
let g:tracServerList   = {}

augroup vimrc#vitra " {{{3
    au!
    au User vitra call s:PluginLoadedVitra()
augroup END

function! s:PluginLoadedVitra() " {{{3
    augroup vimrc-vitra
        au!
        autocmd BufWinEnter Ticket:*      setlocal nonumber foldcolumn=0
        autocmd BufWinEnter Ticket:.Edit* setlocal filetype=tracwiki spell spelllang=en_us spellcapcheck=0 foldcolumn=0
    augroup end
endfunction

Plug 'pentie/VimRepress', { 'on': ['BlogNew', 'BlogOpen', 'BlogList'] } " {{{3
" let g:pluginOpts.mweditor " {{{3

let g:pluginOpts.mweditor =
            \ {
            \   'for': 'mediawiki',
            \   'on': ['MWRead', 'MWWrite', 'MWBrowse'],
            \}

Plug 'aquach/vim-mediawiki-editor', g:pluginOpts.mweditor " {{{3
Plug 'edkolev/tmuxline.vim', { 'on': ['Tmuxline', 'TmuxlineSnapshot'] } " {{{3

let g:tmuxline_powerline_separators = 0

let g:tmuxline_preset = {
    \'a'    : ['#(whoami)@#H'],
    \'b'    : '#S',
    \'win'  : ['#I#F', '#W'],
    \'cwin' : ['#I#F', '#W'],
    \}

Plug 'tmux-plugins/vim-tmux-focus-events' " {{{3
Plug 'christoomey/vim-tmux-navigator' " {{{3

let g:tmux_navigator_no_mappings = 1

" Mappings: move even in insert mode
inoremap <silent> <C-H> <ESC>:TmuxNavigateLeft<cr>
inoremap <silent> <C-J> <ESC>:TmuxNavigateDown<cr>
inoremap <silent> <C-K> <ESC>:TmuxNavigateUp<cr>
inoremap <silent> <C-L> <ESC>:TmuxNavigateRight<cr>
inoremap <silent> <C-\> <ESC>:TmuxNavigatePrevious<cr>

" let g:pluginOpts.vimwiki " {{{3

let g:pluginOpts.vimwiki =
            \ {
            \ 'on': [
            \     'Vimwiki',
            \     'VimwikiIndex',
            \     '<Plug>Vimwiki',
            \ ],
            \}

            " \     '<leader>ww',
            " \     '<leader>wt',
            " \     '<leader>ws',
            " \     '<leader>w<leader>t',

Plug 'vim-scripts/vimwiki', g:pluginOpts.vimwiki " {{{3

let g:vimwiki_use_calendar = 1
let g:calendar_action      = 'vimwiki#diary#calendar_action'
let g:calendar_sign        = 'vimwiki#diary#calendar_sign'

let g:vimwiki_list = [{'path': '~/Shared/vimwiki/', 'path_html': '~/public_html/'}] " }}}3

" Plugins: orgmode/organizer-style {{{2

" Plug 'hsitz/VimOrganizer', { 'for': ['org', 'vimorg-agenda-mappings', 'vimorg-main-mappings'] }
Plug 'hsitz/VimOrganizer'
" Plug 'jceb/vim-orgmode' " {{{3

let g:org_indent = 1

" }}}3
" Plug 'vim-scripts/utl.vim', { 'on': 'votl' }
Plug 'vimoutliner/vimoutliner'

" Plugins: neocomplete / deoplete / etc {{{2

Plug 'Shougo/neoinclude.vim' " {{{3

" FIXME finalize settings

" Ok, so.  I like deoplete, I think, but it adds ~500msec to startup time,
" more than doubling it.  Arrrrgh.

" let g:neocomplete#enable_at_startup                 = 1
let g:neocomplete#enable_smart_case                 = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" }}}5

if has('python3')
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
endif

" }}}3
Plug 'zchee/deoplete-go', { 'for': 'go' }
Plug 'Shougo/neco-vim',   { 'for': 'vim' }
Plug 'c9s/perlomni.vim',  { 'for': 'perl' }
Plug 'Shougo/neco-syntax'

" Plugins: git and version controlish {{{2

Plug 'int3/vim-extradite', { 'on': 'Extradite' } " {{{3

let g:extradite_showhash = 1

nnoremap <silent> <Leader>gE :Extradite<CR>

augroup vimrc#extradite " {{{3
    au!

    au FileType extradite nnoremap <buffer> <silent> <F1> :h extradite-mappings<CR>
    au User vim-extradite call s:PluginLoadedExtradite()
augroup END

function! s:PluginLoadedExtradite() " {{{3

    " create the buffer-local :Extradite command
    silent! execute 'doautocmd User Fugitive'

    augroup vimrc#extradite#post_source_hook
        au!

        " ...and in buffers created before we loaded extradite, too
        au CmdUndefined Extradite :doautocmd User Fugitive
    augroup END
endfunction

Plug 'tpope/vim-rhubarb'             " {{{3 fugitive :Gbrowse plugin
Plug 'shumphrey/fugitive-gitlab.vim' " {{{3 fugitive :Gbrowse plugin
Plug 'tommcdo/vim-fubitive'          " {{{3 fugitive :Gbrowse plugin
Plug 'rsrchboy/vim-fugitive'         " {{{3

" fugitive has a number of bugs/PR's outstanding related to symlinks and
" worktrees.  Unfortunately, these are things I use rather heavily, so it
" looks like I get to maintain my own fork for a while... le sigh

nnoremap <silent> <Leader>gs :Gstatus<Enter>
nnoremap <silent> <Leader>gd :Gdiff<bar>call sy#start()<CR>
nnoremap <silent> <Leader>gh :Gsplit HEAD^{}<CR>
nnoremap <silent> <Leader>ga :call rsrchboy#git#add_to_index()<CR>
nnoremap <silent> <Leader>gc :Gcommit<Enter>
nnoremap <silent> <Leader>gf :call rsrchboy#git#fixup()<CR>
nnoremap <silent> <Leader>gS :call rsrchboy#git#squash()<CR>

nnoremap <silent> <Leader>gA :Git add -pi % <bar> call sy#start()<CR>
nnoremap <silent> <Leader>gp :Git push<CR>
nnoremap <silent> <Leader>gb :DimInactiveBufferOff<CR>:Gblame -w<CR>

nnoremap <silent> <leader>gv :GV<CR>
nnoremap <silent> <leader>gV :GV!<CR>

augroup vimrc#fugitive " {{{3
    au!

    " Automatically remove fugitive buffers
    " autocmd BufReadPost fugitive://* set bufhidden=delete

    " e.g. after we did something :Dispatchy, like :Gfetch
    au QuickFixCmdPost .git/**/index call fugitive#reload_status()

    " au QuickFixCmdPost \[Location\ List\] :lopen<CR>
    " au User FugitiveGrepToLLPost :lopen<CR>

    " on buffer initialization, set our work and common dirs
    au User Fugitive     let b:git_worktree  = rsrchboy#git#worktree()
    " au User Fugitive let b:git_commondir = rsrchboy#git#commondir()
    " au User Fugitive     let b:git_worktree  = fugitive#buffer().repo().tree()
    au User FugitiveBoot let b:git_commondir = fugitive#buffer().repo().git_chomp('rev-parse','--git-common-dir')

    au User Fugitive silent! Glcd
augroup END

Plug 'mattn/gist-vim', { 'on': 'Gist' } " {{{3

let g:gist_detect_filetype        = 1
let g:gist_clip_command           = 'xclip -selection clipboard'
let g:gist_post_private           = 1
let g:gist_show_privates          = 1
let g:gist_get_multiplefile       = 1

Plug 'mhinz/vim-signify' " {{{3

nmap <leader>gj <Plug>(signify-next-hunk)
nmap <leader>gk <Plug>(signify-prev-hunk)

" TODO: need to handle "normal" sign column
let g:signify_vcs_list      = [ 'git' ]
let g:signify_skip_filetype = { 'gitcommit': 1 }

" NOTE: This also saves the buffer to disk!
let g:signify_update_on_bufenter    = 1
let g:signify_update_on_focusgained = 1
let g:signify_cursorhold_normal     = 0
let g:signify_cursorhold_insert     = 0

augroup vimrc#signify " {{{3
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
Plug 'tpope/vim-git'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'rhysd/conflict-marker.vim'
Plug 'gisphm/vim-gitignore'
Plug 'rhysd/committia.vim' " {{{3

let g:committia_hooks = {}

function! g:committia_hooks.edit_open(info) " {{{3

    " Scroll the diff window from insert mode
    imap <buffer> <PageDown> <Plug>(committia-scroll-diff-down-half)
    imap <buffer> <PageDown> <Plug>(committia-scroll-diff-up-half)

endfunction " }}}3
Plug 'hotwatermorning/auto-git-diff'

" Plugins: GitHub {{{2

Plug 'junegunn/vim-github-dashboard', { 'on': ['GHA', 'GHD', 'GHDashboard', 'GHActivity'] } " {{{3

let g:github_dashboard = {}
let g:github_dashboard['emoji'] = 1
let g:github_dashboard['rsrchboy'] = 1

" }}}3
Plug 'jez/vim-github-hub'
Plug 'rhysd/github-complete.vim'
Plug 'rhysd/vim-gfm-syntax'

" Plugins: Twitter {{{2

" let g:pluginOpts.TweetVim {{{3

let g:pluginOpts.TweetVim =
            \ { 'on': [
            \   'TweetVimAddAccount',
            \   'TweetVimCommandSay',
            \   'TweetVimHomeTimeline',
            \   'TweetVimSay',
            \ ] }

Plug 'basyura/TweetVim', g:pluginOpts.TweetVim " {{{3

nnoremap <silent> <Leader>TT :TweetVimHomeTimeline<CR>
nnoremap <silent> <Leader>TS :TweetVimSay<CR>

let g:tweetvim_tweet_per_page   = 50
let g:tweetvim_display_source   = 1
let g:tweetvim_display_time     = 1
let g:tweetvim_expand_t_co      = 1
let g:tweetvim_display_username = 1
let g:tweetvim_open_buffer_cmd  = '$tabnew'

augroup vimrc-tweetvim " {{{3
    au!
    au FileType tweetvim setlocal nonumber foldcolumn=0
augroup END
" }}}3
Plug 'basyura/twibill.vim'
Plug 'basyura/bitly.vim'
Plug 'tyru/open-browser.vim', { 'on': [ 'OpenBrowser', '<Plug>(openbrowser-' ] }
Plug 'mattn/favstar-vim', { 'on': 'FavStar' }

" Plugins: Perl {{{2

Plug 'RsrchBoy/vim-perl', { 'branch': 'active' } " {{{3

" use my fork until several PR's are merged (orig: vim-perl/...)

let g:perl_fold = 1
" support highlighting for the new syntax
let g:perl_sub_signatures = 1
" we do this ourselves
let g:perl_nofold_packages = 1

" }}}3
Plug 'LStinson/perlhelp-vim',                   { 'on': ['PerlHelp', 'PerlMod'] }
Plug 'vim-scripts/log4perl.vim'
call s:MaybeLocalPlugin('vim-ducttape')
call s:MaybeLocalPlugin('vim-ducttape-git')
" Plug 'rsrchboy/update_perl_line_directives', { 'for': 'vim' }
" Plug 'RsrchBoy/syntax_check_embedded_perl.vim', { 'on':  []    }

" Install these for use by ducttape
" let g:pluginOpts.p5_git_raw " {{{3
"
" This fork of Git::Raw has Git::CommitBuild enabled in its dzil config, so
" any builds get committed to the build branch.
"
let g:pluginOpts.p5_git_raw = {
    \   'branch': 'build/ditch-embedded-libgit2',
    \   'on': [],
    \   'do': ':call ducttape#install("--notest .")'
    \}
" }}}3
Plug 'rsrchboy/p5-Git-Raw', g:pluginOpts.p5_git_raw

" Plugins: syntax / filetype {{{2

Plug 'sheerun/vim-polyglot' " {{{3

let g:polyglot_disabled = ['git', 'go', 'perl', 'systemd', 'tmux', 'markdown']

" Plug 'vim-pandoc/vim-pandoc', { 'for': 'pandoc' } " {{{3

let g:pandoc#filetypes#pandoc_markdown = 0

" }}}3
Plug 'fmoralesc/vim-pinpoint'
Plug 'vim-scripts/gtk-vim-syntax'
Plug 'chikamichi/mediawiki.vim', { 'for': 'mediawiki' }
Plug 'rsrchboy/mojo.vim'
Plug 'andrewstuart/vim-kubernetes'
Plug 'tpope/vim-afterimage'
Plug 'lervag/vimtex', { 'for': ['tex'] }
Plug 'jamessan/vim-gnupg', { 'on': [] } " {{{3

let g:GPGPreferArmor       = 1
let g:GPGDefaultRecipients = ['0x84CC74D079416376', '0x1535F82E8083A84A']
let g:GPGFilePattern       = '\(*.\(gpg\|asc\|pgp\)\|.pause\)'

augroup vimrc#gnupg " {{{3
    au!

    " force the autocmds to run after we've loaded the plugin
    au User vim-gnupg nested edit
    au BufRead,BufNewFile *.{gpg,asc,pgp,pause} call plug#load('vim-gnupg') | execute 'au! vimrc#gnupg BufRead,BufNewFile'
augroup END

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " {{{3

let g:go_highlight_functions         = 1
let g:go_highlight_methods           = 1
let g:go_highlight_fields            = 1
let g:go_highlight_types             = 1
let g:go_highlight_operators         = 1
let g:go_highlight_build_constraints = 1

Plug 'plasticboy/vim-markdown', { 'for': [ 'mkd', 'markdown', 'mkd.markdown' ] } " {{{3

let g:vim_markdown_initial_foldlevel = 10
let g:vim_markdown_frontmatter       = 1

let g:vim_markdown_fenced_languages = [ 'bash=sh', 'ini=dosini' ]

Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' } " {{{3
" let g:pluginOpts.scriptease {{{3

let g:pluginOpts.scriptease =
            \ {
            \   'on': [ '<Plug>ScripteaseSynname', 'Scriptnames', 'Runtime', 'PP', 'PPmsg', 'Messages' ],
            \   'for': 'vim',
            \ }

Plug 'tpope/vim-scriptease', g:pluginOpts.scriptease " {{{3

" Not a complete autovivification, but enough. 90% of the time we'll have at
" least one buffer open with a vim ft and that'll trigger the load anyways.

" we may (will) use this mapping largely outside of vim-ft files
nmap zS <Plug>ScripteaseSynnames
" }}}3
" Plug 'xolox/vim-lua-ftplugin',                  { 'for': 'lua' }
" Plug 'xolox/vim-lua-inspect',                   { 'for': 'lua' }
" Plug 'WolfgangMehner/lua-support',              { 'for': 'lua' }
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'nono/jquery.vim'
" Plug 'klen/python-mode',                        { 'for': 'python' }
" FIXME the next might be a good candidate for a polyglot PR...
Plug 'chrisbra/csv.vim',                        { 'for': 'csv' }
Plug 'wgwoods/vim-systemd-syntax'
Plug 'lepture/vim-jinja'
Plug 'vadv/vim-chef',                { 'for': 'chef'   }
Plug 'tmux-plugins/vim-tmux'
Plug 'apeschel/vim-syntax-syslog-ng'
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': 'pandoc' }
Plug 'ap/vim-css-color', { 'on': [] }
Plug 'jparise/vim-graphql'

" Plugins: systemy bits {{{2

Plug 'RsrchBoy/vim-sshauthkeys'
Plug 'tmatilai/gitolite.vim'
Plug 'vim-scripts/iptables'
Plug 'RsrchBoy/interfaces'
Plug 'chr4/nginx.vim'
Plug 'smancill/conky-syntax.vim'
Plug 'FredDeschenes/httplog'
Plug 'vim-scripts/openvpn', { 'for': 'openvpn' }
" Plug 'chr4/sslsecure.vim'

" Plugins: s/w packaging: deb, arch, etc {{{2

Plug 'vim-scripts/deb.vim'
Plug 'Firef0x/PKGBUILD.vim', { 'for': 'PKGBUILD' }

" Plugins: text objects: {{{2

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
Plug 'rhysd/vim-textobj-conflict'
" Plug 'Julian/vim-textobj-brace'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'kana/vim-textobj-function'
Plug 'sgur/vim-textobj-parameter'
" note: php/python/ruby/etc helpers exist, if we start dabbling there
Plug 'thinca/vim-textobj-function-perl', { 'for': 'perl' }
Plug 'vimtaku/vim-textobj-sigil',        { 'for': 'perl' }
Plug 'spacewander/vim-textobj-lua',      { 'for': 'lua'  }
Plug 'akiyan/vim-textobj-php',           { 'for': 'php'  }
" Plug 'kana/vim-textobj-help',          { 'for': 'help' }
" Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }

" Plugins: operators {{{2

Plug 'christoomey/vim-sort-motion'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace' " {{{3

map gX <Plug>(operator-replace)

" }}}3

" Plugins: color schemes: {{{2

Plug 'flazz/vim-colorschemes'
Plug 'Reewr/vim-monokai-phoenix'
Plug 'tomasr/molokai'
Plug 'jnurmine/Zenburn' " {{{3

let g:zenburn_high_Contrast = 1
let g:zenburn_transparent   = 1

Plug 'altercation/vim-colors-solarized' " {{{3

let g:solarized_termtrans = 1
"let g:solarized_termcolors = 256 " needed on terms w/o solarized palette

" }}}3

" Plugins: trial {{{2

Plug 'majutsushi/tagbar', { 'on': 'Tagbar' } " {{{3

nmap <silent> <leader>ttb :TagbarToggle<CR>

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1

" Perl: ctags configuration {{{4

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

" Puppet: ctags configuration {{{4

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

" }}}4

Plug 'freitass/todo.txt-vim', { 'for': 'todo' } " {{{3

nnoremap <silent> <Leader>td :split ~/todo.txt<CR>

Plug 'KabbAmine/lazyList.vim', { 'on': 'LazyList' } " {{{3

" the plugin author's configuration:

" nnoremap gli :LazyList
" vnoremap gli :LazyList

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

" }}}3
Plug 'mattn/googletasks-vim', { 'on': 'GoogleTasks' }

call rsrchboy#sourcecfgdir('plugins') " {{{2
call plug#end()
unlet g:pluginOpts " }}}2

" CONFIGURATION: global or general {{{1

" Settings: {{{2

set autoindent                 " Preserve current indent on new lines
set autoread                   " reload when changed -- e.g. 'git co ...'
set background=dark
set backspace=indent,eol,start " Make backspaces delete sensibly
set dictionary=/usr/share/dict/words
set expandtab                  " Convert all tabs typed to spaces
set hidden
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars-=eol:$
set listchars-=tab:>\ ,
set listchars+=tab:\|\ ,trail:-
set matchpairs+=<:>            " Allow % to bounce between angles too
set modeline
set modelines=2
set noerrorbells
set nostartofline              " try to preserve column on motion commands
set number
set pastetoggle=<F2>
set shiftround                 " Indent/outdent to nearest tabstop
set shiftwidth=4               " Indent/outdent by four columns
set showmatch
set smartcase
set smarttab
set softtabstop=4
set spellfile+=~/.vim/spell/en.utf-8.add
set splitright                 " open new vsplit to the right
set tabstop=8
set textwidth=78               " Wrap at this column
set ttimeoutlen=10
set ttyfast
set ttyscroll=3
set whichwrap+=<,>,h,l

" XXX reexamine 'noswapfile'
set noswapfile

" Start our folding at level 1, but after that enforce at a high enough level
" that we shouldn't discover our current position has been folded away after
" switching windows
set foldlevelstart=1
set foldlevel=10
set foldcolumn=3

let g:maplocalleader = ','

if &term ==# 'tmux-256color' " {{{2
    set term=xterm-256color
endif

if has('persistent_undo') " {{{2
    set undofile
    set undodir=~/.cache/vim/undo/
    if !isdirectory($HOME.'/.cache/vim/undo')
        silent! call mkdir($HOME.'/.cache/vim/undo', 'p', 0700)
    endif
endif

if has('termguicolors') " {{{2
    set termguicolors
endif

augroup vimrc#filetype " {{{2
    au!

    " these have been moved to ftplugin/ files.
    "
    " ...mostly
    autocmd FileType crontab    setlocal commentstring=#\ %s
    autocmd FileType debcontrol setlocal commentstring=#\ %s
    autocmd FileType GV         setlocal nolist
    autocmd FileType tmux       set tw=0
augroup end

augroup vimrc " {{{2
    au!

    au ColorScheme * execute ':runtime! after/colors/'.expand('<amatch>').".vim"

    " perform wip commits on save
    au User Fugitive au! BufWritePost <buffer> silent! call ducttape#git#wip()

    " track buffers against tabs across sessions
    au TabLeave * silent! let g:buf2tab_previous_tabs_buffers = t:bufexp_buf_list
    au User Obsession call buf2tab#SaveTabInfo()
    au SessionLoadPost * call buf2tab#MyRestoreTabBuffers()
augroup end

" }}}2
colorscheme zenburn

" Mappings: {{{1

nnoremap <Leader>SS :call rsrchboy#ShowSurroundMappings()<CR>
nnoremap <Leader>SM :call rsrchboy#ShowBufferMappings()<CR>
nnoremap <Leader>GM :call rsrchboy#cheats#mappings()<CR>
nnoremap <C-Z>      :shell<CR>

nnoremap <silent> <Leader>ft :filetype detect<CR>
nnoremap <silent> <F5>       :setlocal spell! spelllang=en_us<CR>

" make C-PgUp and C-PgDn work, even under screen
" see https://bugs.launchpad.net/ubuntu/+source/screen/+bug/82708/comments/1
nmap <ESC>[5;5~ <C-PageUp>
nmap <ESC>[6;5~ <C-PageDown>

cnoremap w!! w !sudo tee % >/dev/null

" Operators: {{{1

call operator#user#define_ex_command('cutoffs', 'Snip')
map gZ <Plug>(operator-cutoffs)

call operator#user#define_ex_command('tidy-json', 'JsonTidy')
map tJ <Plug>(operator-tidy-json)
call operator#user#define_ex_command('tidy-column', 'ColumnTidy')
map tC <Plug>(operator-tidy-column)

" Inline Block Manipulation: aka prettification {{{1
command! -range -nargs=0 Snip       <line1>,<line2>call rsrchboy#snip#Snip()
command! -range -nargs=* Uniq       <line1>,<line2>! uniq
command! -range -nargs=* JsonTidy   <line1>,<line2>! json_xs -f json -t json-pretty
command! -range -nargs=* ColumnTidy <line1>,<line2>! /usr/bin/column -t
command! -range -nargs=* Cowsay     <line1>,<line2>! cowsay -W 65
command! -range -nargs=* BorgCowsay <line1>,<line2>! cowsay -W 65 -b
command! -range -nargs=* PerlTidy   <line1>,<line2>! perltidy
command! -range -nargs=* MXRCize    <line1>,<line2>perldo perldo return unless /$NS/; s/$NS([A-Za-z0-9:]+)/\$self->\l$1_class/; s/::(.)/__\l$1/g; s/([A-Z])/_\l$1/g

" Source Local Configs: ...if present {{{1

call rsrchboy#sourcedir('~/.vimrc.d')
if filereadable(expand('~/.vimrc.local')) " {{{2
    source ~/.vimrc.local
endif " }}}2

" FINALIZE: set secure, etc.  closing commands. {{{1
set secure
set exrc    " }}}1

" vim: set foldmethod=marker foldcolumn=5 :

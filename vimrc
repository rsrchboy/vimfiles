" Name:             ~/.vimrc
" Summary:          My ~/.vimrc and configuration
" Maintainer:       Chris Weyl <cweyl@alumni.drew.edu>
" Canonical Source: https://github.com/RsrchBoy/vimfiles
" License:          CC BY-NC-SA 4.0 (aka Attribution-NonCommercial-ShareAlike)

" This must be first, because it changes other options as side effect
set nocompatible

" NeoBundle: NeoBundle for bundle/plugin management {{{1
" notes {{{2

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

" General: bundles
NeoBundle 'DataWraith/auto_mkdir'
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
NeoBundle 'thinca/vim-ref'
NeoBundle 'nathanaelkane/vim-indent-guides'

" ColorSchemes:
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jnurmine/Zenburn'

" GIT And Version Controlish: bundles
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'bartman/git-wip', { 'rtp': 'vim', 'build': { 'unix': 'ln -s `pwd`/git-wip ~/bin/' } }
NeoBundle 'mhinz/vim-signify'
NeoBundle 'vim-scripts/ingo-library'      " dependency of the next three
NeoBundle 'vim-scripts/CountJump'         " dependency of the next two
NeoBundle 'vim-scripts/ConflictMotions'   " 3-way merge motions TRIAL
NeoBundle 'vim-scripts/ConflictDetection' " 3-way merge motions TRIAL

" Appish Or External Interface: bundles
NeoBundle 'vim-scripts/VimRepress'
NeoBundle 'vim-scripts/vimwiki'

" Perl: bundles
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'vim-scripts/log4perl.vim'
NeoBundle 'c9s/cpan.vim'
NeoBundle 'LStinson/perlhelp-vim'
NeoBundle 'vim-scripts/update_perl_line_directives'     " could use some work
NeoBundle 'vim-scripts/syntax_check_embedded_perl.vim'  " could use some work

" General Syntax And Filetype Plugins: bundles
NeoBundle 'hsitz/VimOrganizer'
NeoBundle 'nono/jquery.vim'
NeoBundle 'othree/html5-syntax.vim'
NeoBundle 'puppetlabs/puppet-syntax-vim'
NeoBundle 'tpope/vim-haml'
NeoBundle 'argent-smith/JSON.vim'
NeoBundle 'tmatilai/gitolite.vim'
NeoBundle 'evanmiller/nginx-vim-syntax'
NeoBundle 'fmoralesc/vim-pinpoint'
NeoBundle 'vim-scripts/iptables'
NeoBundle 'chrisbra/csv.vim'
NeoBundle 'vim-scripts/deb.vim'
NeoBundle 'RsrchBoy/interfaces' " syntax for /etc/network/interfaces
NeoBundle 'smancill/conky-syntax.vim'
NeoBundle 'apeschel/vim-syntax-syslog-ng'

" Vim Behavioural: startify and the like -- adding/tweaking "core" functionality
NeoBundle 'mhinz/vim-startify'
NeoBundle 'zaiste/tmux.vim'
NeoBundle 'bling/vim-airline'

" Trial Bundles: maybe, maybe not!
NeoBundle 'kablamo/vim-git-log'
NeoBundle 'mhinz/vim-tmuxify'
NeoBundle 'dhruvasagar/vim-table-mode'
NeoBundle 'tpope/vim-obsession'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'mattn/googletasks-vim'
NeoBundle 'freitass/todo.txt-vim'
NeoBundle 'ervandew/supertab'
" how.... did I miss this one?!
NeoBundle 'msanders/snipmate.vim'
" to help handle other author's tabstop/etc settings w/o explicit modelines
NeoBundle 'embear/vim-localvimrc'
NeoBundle 'groenewege/vim-less' " syntax
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'itchyny/calendar.vim'
NeoBundle 'kien/tabman.vim'
NeoBundle 'vim-scripts/Align'
NeoBundle 'vim-scripts/AutoAlign'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'fatih/vim-go'

" Probation:
NeoBundle 'junegunn/vim-github-dashboard'
NeoBundle 'lukaszkorecki/vim-GitHubDashBoard'
" github issues query
NeoBundle 'mklabs/vim-issues'

" Attic: no longer used
"NeoBundle 'vim-scripts/tracwiki'
"NeoBundle 'nsmgr8/vitra'   " trac
"NeoBundle 'kakkyz81/evervim'
"NeoBundle 'Zuckonit/vim-airline-tomato'

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

" AUGROUP: default group for commands defined in here
" ...we switch back to the default at the end of this file.  Trial approach.
augroup vimrc
au!

" APPEARANCE: colors, themes, etc {{{1
" colorscheme autocmds {{{2

" see after/plugin/colorscheme.vim

" colorscheme settings {{{2

let g:zenburn_high_Contrast = 1

let g:solarized_termtrans = 1
"let g:solarized_termcolors = 256 " needed on terms w/o solarized palette

" vim settings {{{2

" see after/plugin/colorscheme.vim

" folding {{{2

"set foldmethod=marker
set foldlevel=1
set foldcolumn=3

" generic fold functions {{{2

func! FoldOnLeadingPounds(lnum)
    let l0 = getline(a:lnum)

    if l0 =~ '^##'
        return '>'.(matchend(getline(v:lnum),'^#\+')-1)
    elseif l0 =~ '^#='
        return '>0'
    endif

    return '='
endfunc

" }}}2

" General Vim: Configuration {{{1
" notes {{{2
"
" Configuration options that impact vim itself, rather than plugin or syntax
" settings.  (generally)
"
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

" key {,re}mappings {{{2
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

" make C-PgUp and C-PgDn work, even under screen
" see https://bugs.launchpad.net/ubuntu/+source/screen/+bug/82708/comments/1
:nmap <ESC>[5;5~ <C-PageUp>
:nmap <ESC>[6;5~ <C-PageDown>

" Save with sudo if you're editing a readonly file in #vim
" https://twitter.com/octodots/status/196996096910827520
cmap w!! w !sudo tee % >/dev/null

" filetype autocommands {{{2
au BufNewFile,BufRead *.psgi              set filetype=perl
au BufNewFile,BufRead cpanfile            set filetype=perl
au BufNewFile,BufRead *.tt                set filetype=tt2html
au BufNewFile,BufRead *.tt2               set filetype=tt2html
au BufNewFile,BufRead Changes             set filetype=changelog
au BufNewFile,BufRead *.zsh-theme         set filetype=zsh
au BufNewFile,BufRead *.snippets          set filetype=snippet
au BufNewFile,BufRead *.snippet           set filetype=snippet
au BufNewFile,BufRead .gitgot*            set filetype=yaml
au BufNewFile,BufRead .oh-my-zsh/themes/* set filetype=zsh
au BufNewFile,BufRead .gitconfig.local    set filetype=gitconfig
" this usually works, but sometimes vim thinks a .t file isn't Perl
au BufNewFile,BufRead *.t         set filetype=perl


" }}}2

" SETTINGS: misc bundle settings {{{1
" TODO: refactor this out properly {{{2

let g:snippets_dir='~/.vim/snippets,~/.vim/bundle/*/snippets'

let g:git_no_map_default          = 1
let g:bufExplorerShowRelativePath = 1
let g:Gitv_TruncateCommitSubjects = 1
let g:Gitv_CommitStep             = 150
" TODO need to highlight TBD appropriately, too
let g:tlTokenList                 = ['FIXME', 'XXX', 'TODO', 'TBD' ]

" }}}2

" AirLine: A lightweight powerline replacement {{{1
" settings {{{2

let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1

" symbols {{{3
" unicode symbols
"let g:airline_left_sep = '»'
""let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
""let g:airline_right_sep = '◀'
""let g:airline_linecolumn_prefix = '␊ '
"let g:airline_linecolumn_prefix = '␤ '
let g:airline_linecolumn_prefix = '¶ '
"let g:airline#extensions#branch#symbol = '⎇ '
let g:airline#extensions#branch#symbol = "\ue822"
"let g:airline#extensions#paste#symbol = 'ρ'
""let g:airline#extensions#paste#symbol = 'Þ'
""let g:airline#extensions#paste#symbol = '∥'
"let g:airline#extensions#whitespace#symbol = 'Ξ'

"" old vim-powerline symbols
""let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
""let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
""let g:airline#extensions#branch#symbol = '⭠ '
"let g:airline#extensions#readonly#symbol = '⭤'
""let g:airline_linecolumn_prefix = '⭡'

" }}}2

" Markdown: autocmds and settings {{{1
" settings {{{2
let g:vim_markdown_initial_foldlevel=1

" }}}2

" Indent Guides: no more counting up for matching! {{{1
" settings {{{2
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1

" }}}2

" Startify: nifty start screen {{{1
" settings {{{2

"let g:startify_bookmarks = [ '~/.vimrc' ]
" autouse sessions with startify.  (aka be useful!)
let g:startify_session_detection   = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root  = 1
let g:startify_empty_buffer_key    = 'o'
let g:startify_restore_position    = 1

" custom header / footer {{{2
let g:startify_custom_header       =
    \ map(split(system('fortune | cowsay -W 60 ; echo .; echo .; uname -a'), '\n'), '"   ". v:val') + ['','']
"let g:startify_custom_footer = ''

" autocmds {{{2
autocmd BufWinEnter startify* setlocal nonumber foldcolumn=0

" files to skip including in the list {{{2
let g:startify_skiplist = [
           \ 'COMMIT_EDITMSG',
           \ $VIMRUNTIME .'/doc',
           \ 'bundle/.*/doc',
           \ ]

" }}}2

" Signify: note changed lines {{{1
" settings {{{2

" TODO: need to handle "normal" sign column
let g:signify_vcs_list                       = [ 'git' ]
"let g:signify_sign_color_inherit_from_linenr = 0
let g:signify_skip_filetype                  = { 'gitcommit': 1 }

"let g:signify_line_highlight = 1

" NOTE: This also saves the buffer to disk!
let g:signify_update_on_bufenter    = 1
let g:signify_update_on_focusgained = 1
let g:signify_cursorhold_normal     = 0
let g:signify_cursorhold_insert     = 0

" TODO: defaults we may want to evaluate
"let g:signify_mapping_toggle = '<leader>gt'
"let g:signify_mapping_toggle_highlight = '<leader>gh'

" }}}2

" Evervim: Interface to evernote.com {{{1
" notes {{{2

" See ~/.vimrc.local for tokens and the like.

" }}}2

" CtrlP: helpful file finder {{{1
" settings {{{2

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix\|startify'

" }}}2

" Gist: post buffers to and otherwise work with gists {{{1
" settings {{{2

let g:gist_detect_filetype        = 1
let g:gist_clip_command           = 'xclip -selection clipboard'
let g:gist_post_private           = 1
let g:gist_show_privates          = 1
let g:gist_get_multiplefile       = 1

" }}}2

" Tagbar And CTags: configuration {{{1
" mappings {{{2

nnoremap <leader>l :TagbarToggle<CR>
nnoremap <leader>o :TagbarOpenAutoClose<CR>

" settings {{{2

let g:tagbar_autoclose = 1

" How to display different "custom" filetypes
"
" perl {{{3

let g:tagbar_type_perl = {
    \ 'sort' : 1,
    \ 'deffile' : '$HOME/.vim/ctags/perl',
    \ 'kinds' : [
        \ 'p:packages:1:0',
        \ 'u:uses:1:0',
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

" VimGnupg: transparently work with encrypted files {{{1
" settings {{{2

let g:GPGPreferArmor       = 1
let g:GPGDefaultRecipients = ["cweyl@alumni.drew.edu"]

"   g:GPGFilePattern
"
"     If set, overrides the default set of file patterns that determine
"     whether this plugin will be activated.  Defaults to
"     '*.\(gpg\|asc\|pgp\)'.

" ok, this is more complex than it needs to be, but works :)
let g:GPGFilePattern = '\(*.\(gpg\|asc\|pgp\)\|.pause\)'

" }}}2

" Dashboard: Github at the moment {{{1
" settings: {{{2

let g:github_dashboard = {}
let g:github_dashboard['emoji'] = 1
let g:github_dashboard['RrschBoy'] = 1

" VimOrganizer: plugin config {{{1
" notes {{{2

" nothing here, currently.  check out ftplugin/org.vim

" }}}2

" Fugitive And Git: fugitive (git) mappings and config {{{1
" {,re}mappings {{{2
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

" autocmds {{{2
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
  normal gg0
  if getline('.') == ''
    start
  end
endfunction

" filetype autocmds (e.g. for pull req, tag edits, etc...) {{{3
autocmd BufEnter *.git/*_EDITMSG exe BufEnterCommit()

" Automatically remove fugitive buffers {{{3
autocmd BufReadPost fugitive://* set bufhidden=delete

" }}}3
" }}}2

" Vitra: Trac UI for ViM (bundle config) {{{1
" settings {{{2

" most of our trac server configuration will be done in ~/.vimrc.local
" so as to prevent userids and passwords from floating about :)

" default: 'status!=closed'
let g:tracTicketClause = 'owner=cweyl&status!=closed'
let g:tracServerList   = {}

" autocmds {{{2
autocmd BufWinEnter Ticket:*      setlocal nonumber foldcolumn=0
autocmd BufWinEnter Ticket:.Edit* setlocal filetype=tracwiki spell spelllang=en_us spellcapcheck=0 foldcolumn=0

" }}}2

" PERL: Perl testing helpers {{{1
" TODO where did I go?! {{{2

" }}}2

" Inline Block Manipulation: aka prettification {{{1
" json {{{2
command! -range -nargs=* Tidy <line1>,<line2>! json_xs -f json -t json-pretty

" cowsay {{{2
command! -range -nargs=* Cowsay <line1>,<line2>! cowsay -W 65
command! -range -nargs=* BorgCowsay <line1>,<line2>! cowsay -W 65 -b

" Perl helpers {{{2
command! -range -nargs=* MXRCize <line1>,<line2>perldo perldo return unless /$NS/; s/$NS([A-Za-z0-9:]+)/\$self->\l$1_class/; s/::(.)/__\l$1/g; s/([A-Z])/_\l$1/g

" }}}2

" TaskList: mappings {{{1
" mappings {{{

map <leader>v <Plug>TaskList

nnoremap ,= :Tabularize /=><CR>
vnoremap ,= :Tabularize /=><CR>

" }}}2

" VimPipe: filetype configuration {{{1
" autocmds {{{2
"
" Perl: {{{3
" tapVerboseOutput appears to be significantly better than perl.tap
autocmd FileType perl let b:vimpipe_filetype = "tapVerboseOutput"
"autocmd FileType perl let b:vimpipe_command  = "perl -I lib/ -"
autocmd FileType perl let b:vimpipe_command  = "source ~/perl5/perlbrew/etc/bashrc ; perl -I lib/ -"

" Puppet: {{{3
autocmd FileType puppet let b:vimpipe_command="T=`mktemp`; cat - > $T && puppet-lint $T; rm $T"

" }}}3
" }}}2

" Calendar: configuration settings {{{1
" settings {{{2

let g:calendar_google_calendar = 1
let g:calendar_google_task     = 1

"}}}2

" NERDTree: configuration settings {{{1

map <leader>l :NERDTreeToggle<CR>

" close if we're the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" SuperTab: settings {{{1

let g:SuperTabNoCompleteBefore = []
let g:SuperTabNoCompleteAfter  = ['^', '\s']

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

" }}}1

" close out our augroup
augroup END

" vim: set foldmethod=marker foldlevel=1 foldcolumn=3 :


" a couple additional settings for git type buffers

if &filetype ==# 'gitrebase'
    " ftplugin/git.vim is sourced by ftplugin/gitrebase.vim, so we bail here
    finish
endif

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

let s:tools = g:rsrchboy#buffer#tools

let b:undo_ftplugin .= ' | setl foldcolumn<'
setlocal foldcolumn=0

" match both 'normal' and worktree indices
if @% =~# '\.git/index$' || @% =~# '\.git/worktrees/.*/index$'

    " let b:is_git       = 'index'
    call s:tools.let('is_git_index', 1)

    " When here, we're typically working with a fugitive status buffer.  We
    " conditionalize this, as we don't want these mappings when, say, writing
    " a commit message.

    setlocal cursorline
    setlocal nohlsearch

    call s:tools.nnoremap('j',      ":call search('^#\t.*','W')<Bar>.<CR>")
    call s:tools.nnoremap('<Down>', ":call search('^#\t.*','W')<Bar>.<CR>")
    call s:tools.nnoremap('k',      ":call search('^#\t.*','Wbe')<Bar>.<CR>")
    call s:tools.nnoremap('<Up>',   ":call search('^#\t.*','Wbe')<Bar>.<CR>")

    call s:tools.nnoremap('q', ':q')
    call s:tools.nnoremap('F', ':Gcommit --no-verify --fixup  HEAD <bar> call fugitive#reload_status()')
    call s:tools.nnoremap('S', ':Gcommit --no-verify --squash HEAD <bar> call fugitive#reload_status()')
    call s:tools.nnoremap('A', ':Git add -A <CR><bar> call fugitive#reload_status()')

    normal ggj
endif

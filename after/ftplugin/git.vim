" a couple additional settings for git type buffers

if &filetype ==# 'gitrebase'
    " ftplugin/git.vim is sourced by ftplugin/gitrebase.vim, so we bail here
    finish
endif

let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard('git')

call s:tools.setl('foldcolumn', '0')
call s:tools.setl('includeexpr', 'fugitive#repo().translate(v:fname)')

" match both 'normal' and worktree indices
if @% =~# '\.git/index$' || @% =~# '\.git/worktrees/.*/index$'

    " let b:is_git       = 'index'
    call s:tools.let('is_git_index', 1)

    " When here, we're typically working with a fugitive status buffer.  We
    " conditionalize this, as we don't want these mappings when, say, writing
    " a commit message.

    call s:tools.setyes('cursorline')
    call s:tools.setno('hlsearch')

    call s:tools.nnoremap('j',      ":call search('^#\t.*','W')<Bar>.<CR>")
    call s:tools.nnoremap('<Down>', ":call search('^#\t.*','W')<Bar>.<CR>")
    call s:tools.nnoremap('k',      ":call search('^#\t.*','Wbe')<Bar>.<CR>")
    call s:tools.nnoremap('<Up>',   ":call search('^#\t.*','Wbe')<Bar>.<CR>")

    call s:tools.nnoremap('q', ':q')
    call s:tools.nnoremap('F', ':Gcommit --no-verify --fixup  HEAD <bar> call fugitive#reload_status()')
    call s:tools.nnoremap('S', ':Gcommit --no-verify --squash HEAD <bar> call fugitive#reload_status()')
    call s:tools.nnoremap('A', ':Git add -A <CR><bar> call fugitive#reload_status()')

    normal ggj

elseif @% =~# '^fugitive://.*$'

    " figure out if we're being used by GV, ... or maybe a WinNew au would be
    " better suited

endif

" FIXME
DimInactiveBufferOff

" __END__

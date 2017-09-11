if exists('b:did_ftplugin_rsrchboy')
    finish
endif
" if !exists('b:undo_ftplugin')
"     let b:undo_ftplugin = 'unlet b:undo_ftplugin'
" endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin = ( exists('b:undo_ftplugin') ? b:undo_ftplugin . ' | ' : '' ) . 'unlet b:did_ftplugin_rsrchboy'

nmap <buffer> <silent> <localleader>F  :execute 'Gcommit --no-verify --fixup=' .gv#sha()<CR>:close<CR>:GV<CR>
nmap <buffer> <silent> <localleader>R  :execute 'Git revert --no-edit '        .gv#sha()<CR>:close<CR>:GV<CR>
nmap <buffer> <silent> <localleader>S  :execute 'Gcommit --no-verify --squash='.gv#sha()<CR>:close<CR>:GV<CR>
nmap <buffer> <silent> <localleader>C  :Gcommit<CR>

" let s:tools = g:rsrchboy#buffer#tools
" call s:tools.llnnoremap('a.', ':s/\s*[.,;]*\s*$/./')

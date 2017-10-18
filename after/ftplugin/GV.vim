if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin = ( exists('b:undo_ftplugin') ? b:undo_ftplugin . '| ' : '' ) . 'unlet b:did_ftplugin_rsrchboy'

let s:tools = g:rsrchboy#buffer#tools

" Section: mappings {{{1

call s:tools.nnore2map('F',  ":execute 'Gcommit --no-verify --fixup=' .gv#sha()<CR>:close<CR>:GV<CR>")
call s:tools.nnore2map('S',  ":execute 'Gcommit --no-verify --squash='.gv#sha()<CR>")
call s:tools.nnore2map('Q',  ":execute 'Gcommit --no-verify --no-edit --squash='.gv#sha()<CR>:close<CR>:GV<CR>")

call s:tools.nnore2map('C', ":Gcommit<CR>")

call s:tools.llnnoremap('rvne', ":execute 'Git revert --no-edit '.gv#sha()<CR>:close<CR>:GV<CR>")
call s:tools.llnnore2map('ria',  ":Git ria<CR>:close<CR>:GV<CR>")

" let s:tools = g:rsrchboy#buffer#tools
" call s:tools.llnnoremap('a.', ':s/\s*[.,;]*\s*$/./')

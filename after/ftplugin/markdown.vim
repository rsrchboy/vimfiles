" a couple additional settings for markdown type buffers

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

let b:undo_ftplugin .= ' | setl ts< sw<'
setlocal tabstop=2
setlocal shiftwidth=2

call rsrchboy#buffer#SetSpellOpts('markdown')

let s:tools = g:rsrchboy#buffer#tools

call s:tools.surround('L', "[](\r)")

setl conceallevel=2

unlet s:tools

" __END__

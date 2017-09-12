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

" __END__

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

let b:undo_ftplugin .= ' | setl ts< sw< aw< awa<'
setlocal tabstop=2
setlocal shiftwidth=2
setlocal autowrite
setlocal autowriteall

call rsrchboy#buffer#SetSpellOpts('vimwiki')

" __END__

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin = 'unlet b:did_ftplugin_rsrchboy'
" let s:tools = g:rsrchboy#buffer#tools

call rsrchboy#buffer#SetSpellOpts('votl')

" __END__

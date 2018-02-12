" a couple additional settings for org type buffers

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
" let b:did_ftplugin_rsrchboy = 1
let s:tools = g:rsrchboy#buffer#tools
call s:tools.let('did_ftplugin_rsrchboy', 1)

let b:undo_ftplugin = 'unlet b:did_ftplugin_rsrchboy'
call rsrchboy#buffer#SetSpellOpts('votl')

" turn on spelling, no caps check at the moment
" setlocal spell spelllang=en_us spellcapcheck=0
call rsrchboy#buffer#SetSpellOpts('org')

unlet s:tools

" __END__

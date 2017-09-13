" Additional setup for notes files

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

call rsrchboy#buffer#SetSpellOpts('notes')

" write them, even when jumping to another buffer
let b:undo_ftplugin .= ' | setl autowriteall<'
setlocal autowriteall

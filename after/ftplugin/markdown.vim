" a couple additional settings for markdown type buffers

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

setlocal tabstop=2
setlocal shiftwidth=2

" turn on spelling, no caps check at the moment
setlocal spell spelllang=en_us spellcapcheck=0

let b:undo_ftplugin .= ' | setl ts< sw< spell< spellcapcheck<'

" __END__

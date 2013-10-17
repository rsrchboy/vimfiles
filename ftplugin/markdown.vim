" a couple additional settings for markdown type buffers

" Only do this when not done yet for this buffer
if exists("b:did_local_markdown_ftplugin")
    finish
endif
let b:did_local_markdown_ftplugin = 1

" turn on spelling, no caps check at the moment
setlocal spell spelllang=en_us spellcapcheck=0

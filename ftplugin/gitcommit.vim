" Additional setup for gitcommit syntax

if exists("b:did_gitcommit_local_ftplugin")
    finish
endif
let b:did_gitcommit_local_ftplugin = 1

" Turn on spellcheck for gitcommits
setlocal spell spelllang=en_us spellcapcheck=0
setlocal nofoldenable

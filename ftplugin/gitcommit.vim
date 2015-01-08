" Additional setup for gitcommit syntax

if exists("b:did_gitcommit_local_ftplugin")
    finish
endif
let b:did_gitcommit_local_ftplugin = 1

setlocal nofoldenable
setlocal foldcolumn=0

" turn on spell-check
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/gitcommit.utf-8.add

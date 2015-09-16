" Additional setup for gitcommit syntax

if exists("b:did_gitcommit_local_ftplugin")
    finish
endif
let b:did_gitcommit_local_ftplugin = 1

" e.g. after we did something :Dispatchy, like :Gfetch
au QuickFixCmdPost <buffer> call fugitive#reload_status()

setlocal nofoldenable
setlocal foldcolumn=0

" don't show tabs and the like (under our configuration)
setlocal nolist

" turn on spell-check
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/gitcommit.utf-8.add

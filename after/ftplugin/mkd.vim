" Additional setup for mkd files

if exists("b:did_mkd_ckw_ftplugin")
    finish
endif
let b:did_mkd_ckw_ftplugin = 1

" turn on spell-check for POD
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/mkd.utf-8.add

setlocal nonumber

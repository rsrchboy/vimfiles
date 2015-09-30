" Additional setup for notes files

if exists("b:did_notes_ckw_ftplugin")
    finish
endif
let b:did_notes_ckw_ftplugin = 1

" turn on spell-check for POD
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/notes.utf-8.add

" write them, even when jumping to another buffer
setlocal autowriteall

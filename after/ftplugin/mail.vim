" Additional setup for mail files

if exists("b:did_mail_ckw_ftplugin")
    finish
endif
let b:did_mail_ckw_ftplugin = 1

" turn on spell-check for POD
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/mail.utf-8.add

setlocal foldcolumn=0

" auto-wrap paragraphs!
set fo=a2tcqlnjr

" local to the buffer
set tw=72

setlocal backup
set swapfile

" TODO: append to b:undo_ftplugin

" first line, start in insert
silent normal gg0i

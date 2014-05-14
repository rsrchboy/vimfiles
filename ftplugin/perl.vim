" Additional setup for perl files

if exists("b:did_perl_ckw_ftplugin")
    finish
endif
let b:did_perl_ckw_ftplugin = 1

" turn on spell-check for POD
set spell
set spelllang=en_us
set spellcapcheck=0
set spellfile+=~/.vim/spell/perl.utf-8.add

" Additional setup for perl files

if exists("b:did_perl_ckw_ftplugin")
    finish
endif
let b:did_perl_ckw_ftplugin = 1

" turn on spell-check for POD
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/perl.utf-8.add

" when working inside a CPAN-style dist, for instance.
let &l:path="lib/,".&l:path

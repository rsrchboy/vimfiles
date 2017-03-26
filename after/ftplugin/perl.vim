" Additional setup for perl files

" when working inside a CPAN-style dist, for instance.
set path<
let &l:path=".,,lib/,".perlpath

if exists('b:ckw_perl_buf_setup')
    " no need to repeat ourselves
    finish
endif

au InsertEnter <buffer> setlocal spell
au InsertLeave <buffer> setlocal nospell

" turn on spell-check for POD / comments
" setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/perl.utf-8.add

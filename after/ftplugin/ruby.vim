" Additional setup for ruby files

if exists("b:did_ruby_ckw_ftplugin")
    finish
endif
let b:did_ruby_ckw_ftplugin = 1

" turn on spell-check for POD
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/ruby.utf-8.add

setlocal tabstop=2 shiftwidth=2

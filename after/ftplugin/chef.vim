" Additional setup for chef files

if exists("b:did_chef_ckw_ftplugin")
    finish
endif
let b:did_chef_ckw_ftplugin = 1

" turn on spell-check for POD
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/chef.utf-8.add

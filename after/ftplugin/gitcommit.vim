" Additional setup for gitcommit syntax

if exists("b:did_gitcommit_local_ftplugin")
    finish
endif
let b:did_gitcommit_local_ftplugin = 1

setlocal nofoldenable
setlocal foldcolumn=0
setlocal textwidth=72

" don't show tabs and the like (under our configuration)
setlocal nolist

setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/gitcommit.utf-8.add

if @% !~# '_EDITMSG$'
    finish
endif

" These commands are only executed if we're in a message edit buffer.

" turn on spell-check
setlocal spell

normal gg0
startinsert

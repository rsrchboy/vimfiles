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

if @% !~# '_EDITMSG$'
    finish
endif

" These commands are only executed if we're in a message edit buffer.

call rsrchboy#buffer#SetSpellOpts('gitcommit')

normal gg0
startinsert

" Additional setup for gitcommit syntax

if exists("b:did_gitcommit_local_ftplugin")
    finish
endif
let b:did_gitcommit_local_ftplugin = 1
let b:undo_ftplugin .= '| unlet b:did_gitcommit_local_ftplugin'

let s:tools = g:rsrchboy#buffer#tools

call rsrchboy#buffer#SetSpellOpts('gitcommit')

setlocal nofoldenable
setlocal foldcolumn=0
setlocal textwidth=72

" don't show tabs and the like (under our configuration)
setlocal nolist

if @% !~# '_EDITMSG$'
    " we are not editing a commit/pullreq message.  Bye!
    finish
endif

" These commands are only executed if we're in a message edit buffer.

normal gg0
startinsert

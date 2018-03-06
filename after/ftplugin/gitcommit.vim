" Additional setup for gitcommit syntax

let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard('gitcommit')

" don't show tabs and the like (under our configuration)
call s:tools.setno('list')

if @% !~# '.*_EDITMSG$'
    finish
endif

" These commands are only executed if we're in a message edit buffer.

call s:tools.spell_for('gitcommit')

normal gg0
startinsert

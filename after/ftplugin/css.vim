let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard()

call s:tools.spell_for('css')
" call s:tools.setl('commentstring', '//\ %s')
call s:tools.setl('softtabstop', '2')
call s:tools.setl('shiftwidth', '2')

setl iskeyword+=-

unlet s:tools

" __END__

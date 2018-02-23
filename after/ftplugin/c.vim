let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard()

call s:tools.spell_for('c')
call s:tools.setl('commentstring', '//\ %s')

unlet s:tools

" __END__

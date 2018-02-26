let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard('epl')

" call s:tools.spell_for('epl')
" call s:tools.setl('commentstring', '//\ %s')
call s:tools.setl('softtabstop', '2')
call s:tools.setl('shiftwidth', '2')

" FIXME need a s:tools function to handle this nicely
setl comments+=b:%#
setl formatoptions+=ro

unlet s:tools

" __END__

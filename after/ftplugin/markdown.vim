" a couple additional settings for markdown type buffers

let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard('epl')

call s:tools.spell_for('markdown')

call s:tools.inoremap('--', '—')

call s:tools.surround('L', "[](\r)")

call s:tools.setl('conceallevel', 2)
call s:tools.setl('softtabstop',  2)
call s:tools.setl('shiftwidth',   2)

unlet s:tools

" __END__

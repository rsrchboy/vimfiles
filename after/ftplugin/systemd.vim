if exists('b:did_ftplugin_rsrchboy')
    finish
endif
" let b:did_ftplugin_rsrchboy = 1
let s:tools = g:rsrchboy#buffer#tools
call s:tools.let('did_ftplugin_rsrchboy', 1)
call s:tools.spell_for('systemd')

" can be dropped when https://github.com/wgwoods/vim-systemd-syntax/pull/1 is
" merged
call s:tools.setl('commentstring', '#\ %s')


unlet s:tools

" __END__

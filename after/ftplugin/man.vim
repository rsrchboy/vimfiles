" a couple additional settings for man type buffers

let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard('man')

" setlocal nonumber
call s:tools.setl('foldcolumn', 0)

nnoremap <buffer> <silent> q :q<CR>

unlet s:tools
" __END__

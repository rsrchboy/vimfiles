" a couple additional settings for man type buffers

let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard('epl')

" setlocal nonumber
call s:tools.setl('foldcolumn', 0)

nnoremap <buffer> <silent> q :q<CR>

" FIXME: not quite.
"highlight clear ExtraWhitespace
"autocmd BufWinEnter * <buffer> highlight clear ExtraWhitespace

unlet s:tools
" __END__

" Additional setup for sh files

let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard('man')

call s:tools.setplus('formatoptions', 'ro')
call s:tools.setl('include', '^\s*source\>')

" local mappings
nnoremap <buffer> <silent> ,;; :Tabularize /;;<CR>

" vim-surround mappings
" D -> [[ ... ]]
" let b:surround_68 = "[[ \r ]]"

call rsrchboy#buffer#shellSurrounds()

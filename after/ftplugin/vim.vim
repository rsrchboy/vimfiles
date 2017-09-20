" Additional setup for vim files
"
if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

let s:tools = g:rsrchboy#buffer#tools

" Section: settings {{{1

call rsrchboy#buffer#SetSpellOpts('vim')

setlocal foldmethod=marker

" oddly, this doesn't seem to be set...
set commentstring=\"%s


let b:undo_ftplugin .= '| setlocal foldmethod< commentstring<'


" Section: mappings {{{1

" local mappings
nnoremap <buffer> <silent> ,l :Tabularize /let<CR>

" TODO FIXME use count vs appended numbers
call s:tools.llnnoremap('fo1', ':s/\s*\({{{\d*\)*\s*$/ {{{1/')
call s:tools.llnnoremap('fo2', ':s/\s*\({{{\d*\)*\s*$/ {{{2/')
call s:tools.llnnoremap('fo3', ':s/\s*\({{{\d*\)*\s*$/ {{{3/')
call s:tools.llnnoremap('fo0', ':s/\s*\({{{\d*\)*\s*$//')
call s:tools.llnnoremap('fc1', ':s/\s*\(}}}\d*\)*\s*$/ }}}1/')
call s:tools.llnnoremap('fc2', ':s/\s*\(}}}\d*\)*\s*$/ }}}2/')
call s:tools.llnnoremap('fc3', ':s/\s*\(}}}\d*\)*\s*$/ }}}3/')
call s:tools.llnnoremap('fc0', ':s/\s*\(}}}\d*\)*\s*$//')

call s:tools.llnnoremap('ax', ':s/\s*[.,;]*\s*$//')

" vim : set foldlevel=10 :

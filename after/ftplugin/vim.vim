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


call s:tools.llnnoremap('fo', ':<C-U>execute ''s/\s*"\?\s*\({{{\d*\)*\s*$/ " {{{''.v:count.''/''')
call s:tools.llnnoremap('fc', ':<C-U>execute ''s/\s*"\?\s*\(}}}\d*\)*\s*$/ " }}}''.v:count.''/''')

call s:tools.llnnoremap('ax', ':s/\s*[.,;]*\s*$//')
call s:tools.llnnoremap('a)', ':s/\s*[.,;]*\s*$/)/')
" call s:tools.llnnoremap('a"', ':s/\s*$/\=printf(&commentstring, '''')/')

call s:tools.surround('q', "''\r''")

" vim : set foldlevel=10 :

" Additional setup for make files

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

call rsrchboy#buffer#SetSpellOpts('make')

let s:tools = g:rsrchboy#buffer#tools


" local mappings -- FIXME this seems awkward
nnoremap <buffer> <silent> ,;; :Tabularize /;;<CR>


call s:tools.llnnoremap('a\\', ':s/\s*[.,;]*\s*$/ \\/')
call s:tools.llnnoremap('ax', ':s/\s*[.,;]*\s*$//')

" vim-surround mappings
" D -> [[ ... ]]
" let b:surround_68 = "[[ \r ]]"
call rsrchboy#buffer#shellSurrounds()


unlet s:tools

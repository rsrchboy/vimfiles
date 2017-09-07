" Additional setup for sh files

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

" local mappings
let b:undo_ftplugin .= ' | nunmap <buffer> ,;;'
nnoremap <buffer> <silent> ,;; :Tabularize /;;<CR>

" vim-surround mappings
" D -> [[ ... ]]
" let b:surround_68 = "[[ \r ]]"

call rsrchboy#buffer#shellSurrounds()

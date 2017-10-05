" Additional setup for Dockerfile files

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= '| unlet b:did_ftplugin_rsrchboy'

" local mappings
nnoremap <buffer> <silent> ,;; :Tabularize /;;<CR>

" vim-surround mappings
" D -> [[ ... ]]
" let b:surround_68 = "[[ \r ]]"

call rsrchboy#buffer#shellSurrounds()

" this should probably be shared with shell
" nnoremap <buffer> <silent> <localleader>a\ :s/\s*[\\]*\s*$/ \\/<cr>

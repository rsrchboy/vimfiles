" Additional setup for sh files

if exists("b:did_sh_ckw_ftplugin")
    finish
endif
let b:did_sh_ckw_ftplugin = 1

" local mappings
nnoremap <buffer> <silent> ,;; :Tabularize /;;<CR>

" vim-surround mappings
" D -> [[ ... ]]
let b:surround_68 = "[[ \r ]]"

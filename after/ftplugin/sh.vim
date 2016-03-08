" Additional setup for sh files

if exists("b:did_sh_ckw_ftplugin")
    finish
endif
let b:did_sh_ckw_ftplugin = 1

" local mappings
nnoremap <buffer> <silent> ,;; :Tabularize /;;<CR>

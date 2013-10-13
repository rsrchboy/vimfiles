
" a couple additional settings for help type buffers

" Only do this when not done yet for this buffer
if exists("b:did_local_help_ftplugin")
    finish
endif
let b:did_local_help_ftplugin = 1

nnoremap <buffer> <silent> q :q<CR>

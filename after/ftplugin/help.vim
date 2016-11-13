" a couple additional settings for help type buffers

" Only do this when not done yet for this buffer
if exists("b:did_local_help_ftplugin")
    finish
endif
let b:did_local_help_ftplugin = 1

" setlocal nonumber
setlocal foldcolumn=0

nnoremap <buffer> <silent> q :q<CR>

" add '|' and '*' to our autoclose pairs
" FIXME adding '*' throws weird errors!
let b:AutoClosePairs = AutoClose#DefaultPairsModified('|', '')

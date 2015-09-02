" a couple additional settings for man type buffers

" Only do this when not done yet for this buffer
if exists("b:did_local_man_ftplugin")
    finish
endif
let b:did_local_man_ftplugin = 1

setlocal nonumber
setlocal foldcolumn=0

nnoremap <buffer> <silent> q :q<CR>

" FIXME: not quite.
"highlight clear ExtraWhitespace
"autocmd BufWinEnter * <buffer> highlight clear ExtraWhitespace

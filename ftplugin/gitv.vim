" Additional setup for gitv files

if exists("b:did_gitv_ckw_ftplugin")
    finish
endif
let b:did_gitv_ckw_ftplugin = 1

"nnoremap <buffer> <silent> F :echo ':Gcommit --fixup ' . gitv#util#line#sha('.')<CR>
nnoremap <buffer> <silent> F :Gcommit --fixup ' . gitv#util#line#sha('.')<CR>

setlocal cursorline
setlocal nohlsearch

" j, k skip between commit lines
nnoremap <buffer> <silent> j :call search('^\(\W\s\)*\*','W')<Bar>.<CR>
nnoremap <buffer> <silent> k :call search('^\(\W\s\)*\*','Wbe')<Bar>.<CR>

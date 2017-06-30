" a couple additional settings for git type buffers

" Only do this when not done yet for this buffer
if exists("b:did_local_git_ftplugin")
    finish
endif
let b:did_local_git_ftplugin = 1

setlocal foldcolumn=0

nmap <buffer> <silent> q :q<CR>
nmap <buffer> <silent> F :Gcommit --no-verify --fixup HEAD <bar> call fugitive#reload_status()<CR>
nmap <buffer> <silent> Q :Gcommit --no-verify --squash HEAD<CR>
"nmap <buffer> <silent> V :Gitv<cr>

" a couple additional settings for git type buffers

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

let s:tools = g:rsrchboy#buffer#tools

let b:undo_ftplugin .= ' | setl foldcolumn<'
setlocal foldcolumn=0

" call s:tools.llnnoremap('a.', ':s/\s*[.,;]*\s*$/./')
nmap <buffer> <silent> q :q<CR>
nmap <buffer> <silent> F :Gcommit --no-verify --fixup HEAD <bar> call fugitive#reload_status()<CR>
nmap <buffer> <silent> Q :Gcommit --no-verify --squash HEAD<CR>
"nmap <buffer> <silent> V :Gitv<cr>

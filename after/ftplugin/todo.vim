" a couple additional settings for todo type buffers

" Only do this when not done yet for this buffer
if exists("b:did_local_todo_ftplugin")
    finish
endif
let b:did_local_todo_ftplugin = 1

setlocal nospell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/todo.utf-8.add

setlocal nonumber
setlocal foldcolumn=0

" " close with a single q
" nnoremap <buffer> <silent> q :q<CR>
" nnoremap <buffer> <silent> F :call RunGitFixup() <bar> call futodoive#reload_status()<CR>
" nnoremap <buffer> <silent> F :Gcommit --fixup HEAD <bar> call futodoive#reload_status()<CR>
" nnoremap <buffer> <silent> Q :Gcommit --squash HEAD<CR>
nnoremap <buffer> <silent> <F1> :h todo-commands<CR>

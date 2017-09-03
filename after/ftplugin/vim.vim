" Additional setup for vim files

if exists('b:did_vim_ckw_ftplugin')
    finish
endif
let b:did_vim_ckw_ftplugin = 1

setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/vim.utf-8.add

setlocal foldmethod=marker

" oddly, this doesn't seem to be set...
set commentstring=\"%s

" local mappings
nnoremap <buffer> <silent> ,l :Tabularize /let<CR>

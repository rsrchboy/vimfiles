" Additional setup for gitv files

if exists("b:did_gitv_ckw_ftplugin")
    finish
endif
let b:did_gitv_ckw_ftplugin = 1

" Buffer Options: {{{1

setlocal cursorline
setlocal nohlsearch

" Mappings: {{{1

" note -- the git aliases are based off my personal gitconfig -- proably ought
" to expand them here
nmap <buffer> <silent> F   :execute 'Gcommit --fixup ' . gitv#util#line#sha('.')<bar>normal u<CR>
nmap <buffer> <silent> ria :Git ria<bar>normal u<CR>
nmap <buffer> <silent> ca  :Git ca<bar>normal u<CR>

nmap <buffer> <silent> h   :help gitv-browser-mappings<CR>

" j, k skip between commit lines
nmap <buffer> <silent> j :call search('^\(\W\s\)*\*','W')<Bar>.<CR>
nmap <buffer> <silent> k :call search('^\(\W\s\)*\*','Wbe')<Bar>.<CR>

" tab just goes to the diff/commit buffer
nmap <buffer> <Tab> <C-W>l

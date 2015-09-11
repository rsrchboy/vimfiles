" Additional setup for gitv files

if exists("b:did_gitv_ckw_ftplugin")
    finish
endif
let b:did_gitv_ckw_ftplugin = 1

" Buffer Options: {{{1

setlocal cursorline
setlocal nohlsearch

" Mappings: {{{1

" TODO for mappings:
" 
" qf  should hook into the qf-post autocmd event to refresh our buffer, as
"     that's when any displayable ref updates will present themselves

" note -- the git aliases are based off my personal gitconfig -- proably ought
" to expand them here
nmap <buffer> <silent> F   :execute 'Gcommit --fixup  ' . gitv#util#line#sha('.')<bar>normal u<CR>
nmap <buffer> <silent> S   :execute 'Gcommit --squash ' . gitv#util#line#sha('.')<bar>normal u<CR>
nmap <buffer> <silent> ria :call dispatch#compile_command(0, fugitive#repo().git_command('ria'), 1)<CR>
nmap <buffer> <silent> ca  :call dispatch#compile_command(0, fugitive#repo().git_command('ca'), 1)<CR>
"nmap <buffer> <silent> gf  :call dispatch#compile_command(0, fugitive#repo().git_command('fetch'), 1)<CR>
nmap <buffer> <silent> gf  :execute 'Dispatch ' . fugitive#repo().git_command('fetch')<CR>

"nmap <buffer> <silent> ria :Git ria<bar>normal u<CR>
"nmap <buffer> <silent> ca  :Git ca<bar>normal u<CR>

nmap <buffer> <silent> h   :help gitv-browser-mappings<CR>

" j, k skip between commit lines
nmap <buffer> <silent> j :call search('^\(\W\s\)*\*','W')<Bar>.<CR>
nmap <buffer> <silent> k :call search('^\(\W\s\)*\*','Wbe')<Bar>.<CR>

" tab just goes to the diff/commit buffer
nmap <buffer> <Tab> <C-W>l

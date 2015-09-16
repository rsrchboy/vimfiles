" Additional setup for gitv files

if exists("b:did_gitv_ckw_ftplugin")
    finish
endif
let b:did_gitv_ckw_ftplugin = 1

" update commit list on :Dispatch finish
" NOTE this does not update the commit in the preview pane
au QuickFixCmdPost <buffer> normal u

" Buffer Options: {{{1

setlocal cursorline
setlocal nohlsearch

" Mappings: {{{1

" TODO for mappings:
"
" C   should cause gitv to auto-update on the closing of the commit buffer

" note -- the git aliases are based off my personal gitconfig -- proably ought
" to expand them here
nmap <buffer> <silent> F   :execute 'Gcommit --fixup  ' . gitv#util#line#sha('.')<bar>normal u<CR>
nmap <buffer> <silent> S   :execute 'Gcommit --squash ' . gitv#util#line#sha('.')<bar>normal u<CR>
nmap <buffer> <silent> C   :Gcommit<CR>
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

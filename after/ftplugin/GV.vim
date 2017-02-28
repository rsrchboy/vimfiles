" " note -- the git aliases are based off my personal gitconfig -- proably ought
" " to expand them here
" nmap <buffer> <silent> F   :execute 'Gcommit --fixup  ' . gitv#util#line#sha('.')<bar>normal u<CR>
" nmap <buffer> <silent> F   :execute 'Gcommit --fixup  ' . gv#sha()<bar>normal u<CR>
nmap <buffer> <silent> F   :execute 'Gcommit --fixup  ' . gv#sha()<CR>
" nmap <buffer> <silent> S   :execute 'Gcommit --squash ' . gitv#util#line#sha('.')<bar>normal u<CR>
nmap <buffer> <silent> C   :Gcommit<CR>
" nmap <buffer> <silent> ria :call dispatch#compile_command(0, fugitive#repo().git_command('ria'), 1)<CR>
" nmap <buffer> <silent> rv  :call dispatch#compile_command(0, fugitive#repo().git_command('revert', '--no-edit', gitv#util#line#sha('.')), 1)<CR>
" nmap <buffer> <silent> ca  :call dispatch#compile_command(0, fugitive#repo().git_command('ca'), 1)<CR>
" nmap <buffer> <silent> gf  :execute 'Dispatch ' . fugitive#repo().git_command('fetch')<CR>

"nmap <buffer> <silent> ria :Git ria<bar>normal u<CR>
"nmap <buffer> <silent> ca  :Git ca<bar>normal u<CR>

" nmap <buffer> <silent> <F1>   :help gitv-browser-mappings<CR>

" " j, k skip between commit lines
" nmap <buffer> <silent> j :call search('^\(\W\s\)*\*','W')<Bar>.<CR>
" nmap <buffer> <silent> k :call search('^\(\W\s\)*\*','Wbe')<Bar>.<CR>

" " tab just goes to the diff/commit buffer
" nmap <buffer> <Tab> <C-W>l

" " note -- the git aliases are based off my personal gitconfig -- probably ought
" " to expand them here
nmap <buffer> <silent> F  :execute 'Gcommit --no-verify --fixup='  . gv#sha()<CR>:close<CR>:GV<CR>
nmap <buffer> <silent> S  :execute 'Gcommit --no-verify --squash=' . gv#sha()<CR>:close<CR>:GV<CR>
nmap <buffer> <silent> C  :Gcommit<CR>

nmap <buffer> <silent> <LocalLeader>gria :call dispatch#compile_command(0, fugitive#repo().git_command('ria'), 1)<CR>:close<CR>:GV<CR>
" nmap <buffer> <silent> ,ria :call dispatch#compile_command(0, fugitive#repo().git_command('ria'), 1)<CR>
" nmap <buffer> <silent> rv  :call dispatch#compile_command(0, fugitive#repo().git_command('revert', '--no-edit', gitv#util#line#sha('.')), 1)<CR>
" nmap <buffer> <silent> ca  :call dispatch#compile_command(0, fugitive#repo().git_command('ca'), 1)<CR>

" " j, k skip between commit lines
" nmap <buffer> <silent> j :call search('^\(\W\s\)*\*','W')<Bar>.<CR>
" nmap <buffer> <silent> k :call search('^\(\W\s\)*\*','Wbe')<Bar>.<CR>


fun! rsrchboy#git#fixup() abort " {{{1

    " nmap <silent> <Leader>gf :Gcommit --no-verify --fixup HEAD --no-verify<CR>
    " nmap <silent> <Leader>gF :echo 'fixed up to: ' . ducttape#git#fixup()<CR>

    try
        let l:id = ducttape#git#fixup()
        echo 'fixed up to: ' . l:id
    catch /^Vim\%((\a\+)\)\=:E117/
        Gcommit --no-verify --fixup HEAD
    endtry

    " these could probably be excised and done from a user autocmd or somesuch
    unlet! b:airline_head_subject
    silent! call airline#update_statusline()

    return
endfun

fun! rsrchboy#git#worktree() abort " {{{1

    if !exists('b:git_dir') | return | endif

    try
        let l:worktree = ducttape#git#workdir()
    catch /^Vim\%((\a\+)\)\=:E117/
        let l:worktree = fugitive#buffer().repo().tree()
    endtry

    return l:worktree
endfun

fun! rsrchboy#git#commondir() abort " {{{1

    try
        let l:commondir = ducttape#git#commondir()
    catch /^Vim\%((\a\+)\)\=:E117/
        let l:commondir = fugitive#buffer().repo().git_chomp('rev-parse','--git-common-dir')
    endtry

    return l:commondir
endfun

fun! rsrchboy#git#wrapper(DFunc, FFunc) abort " {{{1

    if !exists('b:git_dir') | return | endif

    try
        let l:ret = a:DFunc()
    catch /^Vim\%((\a\+)\)\=:E117/
        let l:ret = a:FFunc()
    endtry

    return l:ret
endfun

fun! rsrchboy#git#add_to_index() abort " {{{1
    call rsrchboy#git#wrapper(
                \   { -> ducttape#git#index_add() },
                \   { -> Gwrite }
                \)

    silent! call sy#start()
    return
endfun " }}}1

finish " <=====


fun! rsrchboy#git#fugitive() abort

    let b:git_worktree  = fugitive#buffer().repo().tree()
    let b:git_commondir = fugitive#buffer().repo().git_chomp('rev-parse','--git-common-dir')

    " FIXME Gfixup is a work in progress
    command! -nargs=? Gfixup :Gcommit --no-verify --fixup=HEAD <q-args>

    nmap <silent> <Leader>gs :Gstatus<Enter>
    nmap <silent> <Leader>gD :call Gitv_OpenGitCommand("diff --no-color -- ".expand('%'), 'new')<CR>
    nmap <silent> <Leader>gd :Gdiff<CR>
    nmap <silent> <Leader>gh :Gsplit HEAD^{}<CR>
    nmap <silent> <Leader>ga :Gwrite<bar>call sy#start()<CR>
    nmap <silent> <Leader>gc :Gcommit<Enter>
    nmap <silent> <Leader>gf :call rsrchboy#git#fixup()<CR>
    nmap <silent> <Leader>gS :Gcommit --no-verify --squash HEAD

    " trial -- intent to add
    nmap <silent> <Leader>gI :Git add --intent-to-add %<bar>call sy#start()<CR>

    " nmap <silent> <Leader>gA :execute ':!git -C ' . b:git_worktree . ' add -pi ' . resolve(expand('%')) <bar> call sy#start()<CR>
    nmap <silent> <Leader>gA :execute ':!git -C ' . b:git_worktree . ' add -pi ' . fugitive#buffer().path() <bar> call sy#start()<CR>
    nmap <silent> <Leader>gp :Git push<CR>
    nmap <silent> <Leader>gb :DimInactiveBufferOff<CR>:Gblame -w<CR>

    nmap <silent> <leader>gv :GV<cr>
    nmap <silent> <leader>gV :GV!<cr>



        au User Fugitive     let b:git_worktree  = fugitive#buffer().repo().tree()
        au User FugitiveBoot let b:git_commondir = fugitive#buffer().repo().git_chomp('rev-parse','--git-common-dir')

endfun

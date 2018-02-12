
fun! rsrchboy#git#fixup(...) abort " {{{1

    let l:target = a:0 ? a:1 : 'HEAD'

    try
        let l:id = ducttape#git#fixup(l:target)
        call fugitive#reload_status()
        echo 'fixed up ' . l:target . ' to: ' . l:id
    catch /^Vim\%((\a\+)\)\=:E117/
        execute 'Gcommit --no-verify --fixup --no-gpg-sign ' . l:target
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

fun! s:FuncOrEval(Thing) abort
    if type(a:Thing) == v:t_func
        call a:Thing()
    else
        execute a:Thing
    end
    return
endfun

fun! rsrchboy#git#wrapper(DFunc, FFunc) abort " {{{1

    if !exists('b:git_dir') | return | endif

    try
        call s:FuncOrEval(a:DFunc)
        call fugitive#reload_status()
    catch /^Vim\%((\a\+)\)\=:E117/
        call s:FuncOrEval(a:FFunc)
    endtry

    return
endfun

fun! rsrchboy#git#add_to_index() abort " {{{1
    call rsrchboy#git#wrapper(
                \   { -> ducttape#git#index_add() },
                \   ':Gwrite',
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


fun! rsrchboy#git#fixup(...) abort " {{{1
    return rsrchboy#git#special_commit('fixup', (a:0 ? a:1 : 'HEAD'))
endfun

fun! rsrchboy#git#squash(...) abort " {{{1
    return rsrchboy#git#special_commit('squash', (a:0 ? a:1 : 'HEAD'))
endfun

fun! rsrchboy#git#special_commit(command, ...) abort " {{{1

    let l:target = a:0 ? a:1 : 'HEAD'

    try
        let l:id = ducttape#git#special_commit(a:command, l:target)
        call fugitive#reload_status()
        echo a:command . ' up ' . l:target . ' to: ' . l:id
    catch /^Vim\%((\a\+)\)\=:E117/
        execute 'Gcommit --no-verify --' . a:command . ' --no-gpg-sign ' . l:target
    endtry

    " these could probably be excised and done from a user autocmd or somesuch
    unlet! b:airline_head b:airline_head_subject
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

" __END__

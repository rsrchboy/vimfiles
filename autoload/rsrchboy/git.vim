
fun! rsrchboy#git#fixup() abort

    " nmap <silent> <Leader>gf :Gcommit --no-verify --fixup HEAD --no-verify<CR>
    " nmap <silent> <Leader>gF :echo 'fixed up to: ' . ducttape#git#fixup()<CR>

    try
        let l:id = ducttape#git#fixup()
        echo 'fixed up to: ' . l:id
    catch /^Vim:E117/
        Gcommit --no-verify --fixup HEAD --no-verify
    endtry

    return
endfun

fun! rsrchboy#git#worktree() abort

    try
        let l:worktree = ducttape#git#workdir()
    catch /^Vim:E117/
        let l:worktree = fugitive#buffer().repo().tree()
    endtry

    return l:worktree
endfun

fun! rsrchboy#git#commondir() abort

    try
        let l:commondir = ducttape#git#commondir()
    catch /^Vim:E117/
        let l:commondir = fugitive#buffer().repo().git_chomp('rev-parse','--git-common-dir')
    endtry

    return l:commondir
endfun


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

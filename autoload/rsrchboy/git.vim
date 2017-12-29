
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

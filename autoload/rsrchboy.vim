function! rsrchboy#termtitle()

    " cheat, just rely on fugitive here
    let dir     = getbufvar('%', 'git_dir')
    let has_git = dir != "" ? 1 : 0

    " FIXME will have to rework this to deal with workdirs

    if has_git != ""
        let pretty_dir = '⎇  ' . fnamemodify(dir, ':~:h') . '/'
    else
        let pretty_dir = fnamemodify(expand('%'), ':~')
    endif

    " , fnamemodify('%', ':~'))
    " return getbufvar('%', 'git_dir', fnamemodify('%', ':~'))

    return 'vim: ' . pretty_dir
endfunction

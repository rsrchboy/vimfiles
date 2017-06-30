" returns the value of the buffer variable, if set, or global if not
function! rsrchboy#var(name) abort
    let l:local_name = substitute(a:name, '#', '_', '')
    if exists('b:'.l:local_name)
        return get(b:, l:local_name)
    else
        return get(g:, a:name)
    endif
endfunction

function! rsrchboy#termtitle()

    " cheat, just rely on fugitive here
    let dir     = getbufvar('%', 'git_dir')
    let has_git = dir != "" ? 1 : 0

    " FIXME will have to rework this to deal with workdirs

    if has_git != ""
        " let pretty_dir = '⎇  ' . fnamemodify(dir, ':~:h') . '/'
        let pretty_dir = '⎇  ' . fnamemodify(dir, ':~:h')
    else
        " let pretty_dir = fnamemodify(expand('%'), ':~')
        let pretty_dir = fnamemodify(expand('%'), ':t')
    endif

    " , fnamemodify('%', ':~'))
    " return getbufvar('%', 'git_dir', fnamemodify('%', ':~'))

    return 'vim: ' . pretty_dir
endfunction

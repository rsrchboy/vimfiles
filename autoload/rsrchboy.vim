scriptencoding utf-8

" returns the value of the buffer variable, if set, or global if not
function! rsrchboy#var(name) abort
    let l:local_name = substitute(a:name, '#', '_', '')
    if exists('b:'.l:local_name)
        return get(b:, l:local_name)
    else
        return get(g:, a:name)
    endif
endfunction

function! rsrchboy#termtitle() abort

    " cheat, just rely on fugitive here
    let l:dir     = getbufvar('%', 'git_dir')
    let l:has_git = l:dir !=# '' ? 1 : 0

    " FIXME will have to rework this to deal with workdirs

    if l:has_git !=# ''
        " let pretty_dir = '⎇  ' . fnamemodify(l:dir, ':~:h') . '/'
        let l:pretty_dir = '⎇  ' . fnamemodify(l:dir, ':~:h')
    else
        " let pretty_dir = fnamemodify(expand('%'), ':~')
        let l:pretty_dir = fnamemodify(expand('%'), ':t')
    endif

    " , fnamemodify('%', ':~'))
    " return getbufvar('%', 'git_dir', fnamemodify('%', ':~'))

    return 'vim: ' . l:pretty_dir
endfunction

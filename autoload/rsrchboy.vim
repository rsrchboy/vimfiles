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

function! rsrchboy#sourcedir(dir) abort
    for l:f in split(glob(a:dir.'/*.vim'), '\n')
        exe 'source ' l:f
    endfor
endfunction

function! rsrchboy#sourcecfgdir(dir) abort
    call rsrchboy#sourcedir('~/.config/vim/' . a:dir . '.d')
endfunction

function! rsrchboy#ShowSurroundMappings() abort
    let l:surrounds = filter(copy(b:), { k -> k =~# '^surround_\d\+'})
    for l:key in keys(l:surrounds)
        let l:char = nr2char(substitute(l:key, 'surround_', '', ''))
        let l:surrounds[l:char] = remove(l:surrounds, l:key)
    endfor
    call map(l:surrounds, { k, v -> substitute(v, "\r", '...', '') })

    " sanity.  this shouldn't ever produce anything, but when it does we can
    " tidy this all up
    let l:global_surrounds = filter(copy(g:), { k -> k =~# '^surround_\d\+'})
    call map(l:global_surrounds, { k, v -> substitute(v, "\r", '...', '') })
    call extend(l:surrounds, l:global_surrounds, 'keep')

    if !len(keys(l:surrounds))
        echo 'No special surround mappings defined for this filetype.'
        return
    endif

    echo 'Buffer surround mappings!'
    for l:char in sort(keys(l:surrounds))
        echo l:char . ' -> ' . l:surrounds[l:char]
    endfor

    return
endfunction

function! rsrchboy#ShowBufferMappings() abort
    let l:text = exists('b:rsrchboy_local_mappings') ? b:rsrchboy_local_mappings : []
    echo 'Our buffer local mappings:'
    for l:line in l:text
        echo l:line
    endfor
    return
endfunction

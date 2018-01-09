scriptencoding utf-8


" Section: Functions {{{1

fun! rsrchboy#statuslineRefresh() abort " {{{2
    call rsrchboy#maybedoau('RbAirlineRefreshPre')
    unlet! b:airline_head b:airline_head_subject
    silent! call airline#update_statusline()
    call rsrchboy#maybedoau('RbAirlineRefreshPost')
    return
endfun

function! rsrchboy#maybedoau(event) abort " {{{2
    if exists('#User#' . a:event)
        try
            let [save_mls, &modelines] = [&mls, 0]
            execute 'doautocmd User ' . a:event
        finally
            let &mls = save_mls
        endtry
    endif
endfunction

function! rsrchboy#var(name) abort " {{{2
    " returns the value of the buffer variable, if set, or global if not
    let l:local_name = substitute(a:name, '#', '_', '')
    if exists('b:'.l:local_name)
        return get(b:, l:local_name)
    else
        return get(g:, a:name)
    endif
endfunction

function! rsrchboy#termtitle() abort " {{{2

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

function! rsrchboy#sourcedir(dir) abort " {{{2
    for l:f in split(glob(a:dir.'/*.vim'), '\n')
        exe 'source ' l:f
    endfor
endfunction

function! rsrchboy#sourcecfgdir(dir) abort " {{{2
    call rsrchboy#sourcedir('~/.config/vim/' . a:dir . '.d')
endfunction

function! rsrchboy#ShowSurroundMappings() abort " {{{2
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
        echo 'No special surround mappings defined for this filetype (' . &filetype
        return
    endif

    echo 'Buffer surround mappings!'
    for l:char in sort(keys(l:surrounds))
        " echo l:char . ' -> ' . l:surrounds[l:char]
        echo printf('%12s -> %s', l:char, l:surrounds[l:char])
    endfor

    return
endfunction

" Function: ...#ShowTextobjMappings() {{{2

function! rsrchboy#ShowTextobjMappings() abort

    " e.g.:
    "
    " x  il            <Plug>(textobj-line-i)
    " x  ic            <Plug>(textobj-comment-i)
    " v  <Plug>(textobj-sigil-a) & :<C-U>call g:__textobj_sigil.do_by_function("select-a","-","v")<CR>
    " v  <Plug>(textobj-sigil-i) & :<C-U>call g:__textobj_sigil.do_by_pattern("select","i","v")<CR>
    "
    " SOOOOO....  need to map from x -> <Plug>... -> v
    " right?
    "
    " Maybe shortcut for Right Now.
    redir => l:output
        silent vmap
    redir END

    let l:lines = split(l:output, "\n")
    call filter(l:lines, { k, v -> v =~# "<Plug>(textobj-" })
    let l:vlines = filter(copy(l:lines), { k, v -> v =~# "^v" })
    let l:xlines = filter(copy(l:lines), { k, v -> v =~# "^x" })

    let l:maps = {}
    for l:line in l:xlines
        " echo l:line
        let l:splits = split(l:line)
        " PP l:splits
        let l:maps[l:splits[1]] = l:splits[2]
    endfor

    " return l:maps

    echo "textobj mappings!"
    for l:map in sort(keys(l:maps))
        echo l:map . ' -> ' . l:maps[l:map]
    endfor

    return

    " let l:sid = self.fn_prefix

    " let l:funcs = sort(filter(
    "             \   map(split(l:output, "\n"), { k, v -> matchstr(v, '<SNR>[^(]\+') }),
    "             \   { k, v -> v =~# l:sid }
    "             \))
    " return  l:funcs
endfunction

" Function: ...#ShowBufferMappings() {{{2

function! rsrchboy#ShowBufferMappings() abort " {{{2
    let l:text = exists('b:rsrchboy_local_mappings') ? b:rsrchboy_local_mappings : []
    echo 'Our buffer local mappings:'
    for l:line in l:text
        echo l:line
    endfor
    return
endfunction

" }}}1


" __END__

if exists('g:loaded_op_linkify')
    finish
endif
let g:loaded_op_linkify = 1

map gl <Plug>(operator-linkify)
" will replace func name w/autoload name
call operator#user#define('linkify', 'LinkifyFunc')

fun! LinkifyFunc(motion_wiseness) abort
    let l:reg = operator#user#register()
    let l:v = operator#user#visual_command_from_wise_name(a:motion_wiseness)

    " yank everything into our register and delete it from the buffer
    execute 'normal!' '`[' . l:v . '`]"' . l:reg . 'd'
    let l:text = getreg(l:reg)

    if exists('b:linkify_func')

    else
        " markdown / cpan
        call setreg(l:reg, '[' . l:text . '](https://metacpan.org/pod/' . l:text . ')')
    endif

    execute 'normal!' '"'.l:reg.'P'
    return
endfun

finish

fun! LinkifyFunc(motion_wiseness) abort
    let l:reg = operator#user#register()
    let l:v = operator#user#visual_command_from_wise_name(a:motion_wiseness)

    " yank everything into our register and delete it from the buffer
    execute 'normal!' '`[' . l:v . '`]"' . l:reg . 'd'
    let l:text = getreg(l:reg)

    "echom l:reg . ' ha! ' . l:text
    call setreg(l:reg, '[' . l:text . '](https://metacpan.org/pod/' . l:text . ')')

    execute 'normal!' '"'.l:reg.'P'
    return
endfun

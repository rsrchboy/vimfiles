" finish

fun! WtfTryItAlready() abort

    let l:ret = textobj#function#select_a()

    return [ l:ret[0], l:ret[2], l:ret[1] ]
endfun

" ok, so I'm trying to use this to handle jumping between functions.  Might
" work.  Maybe.
"
" Committing this initial chunk so I have it on different systems.  Pardon the
" mess.

call textobj#user#plugin('functionmotions', {
\   'a': {
\       'move-p': '\pp', 'move-p-function': 'textobj#function#select_a',
\       'move-n': '\nn', 'move-n-function': 'WtfTryItAlready',
\   },
\ })


            " \   'a': {
            " \       'select-a': 'af',
            " \       'select-a-function': 'textobj#function#select_a',
            " \   },
" \   'i': {'select': 'if', 'select-function': 'textobj#function#select_i'},
" \   'A': {'select': 'aF', 'select-function': 'textobj#function#select_A'},
" \   'I': {'select': 'iF', 'select-function': 'textobj#function#select_I'},


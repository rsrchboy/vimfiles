" vim-textobj plugin to handle perly things.

if exists('g:loaded_textobj_perl')
    finish
endif
let g:loaded_textobj_perl = 1

" Works, but the behaviour leaves something to be desired -- namely in that
" start/end rows aren't what we'd prefer.
            " \       'region-type': 'V',
call textobj#user#plugin('perl', {
            \   'pod': {
            \       'pattern': [ '^=', '^=' ],
            \       'select-a': 'aPb',
            \       'select-i': 'iPb',
            \   },
            \   'moose-attribute': {
            \       'region-type': 'V',
            \       'pattern': [ '^\s*has\s', '^);' ],
            \       'select-a': 'aPa',
            \       'select-i': 'iPa',
            \   },
            \})

finish

" second submatch is the token; e.g. 'EOF' or 'SQL'
let s:heredoc_start = '<<\~\?\([''"]\?\)\(\u\+\)\1\?'

function! CurrentLineA()
    return s:FindBlock(0)
endfunction

function! CurrentLineI()
    return s:FindBlock(1)
endfunction

function! s:FindBlock(offset) abort
    let l:current_line = line('.')

    " TODO handle failure modes...?

    let l:start_line = search(s:heredoc_start, 'bcn', 1)
    if !l:start_line
        return 0
    endif

    let l:token = substitute(getline(l:start_line), '^.*'.s:heredoc_start.'.*$', '\=submatch(2)', '')
    echom 'token is: ' . l:token

    " Never select the first line, as it's liable to have a bunch of other
    " gunk on it
    let l:start_line += 1
    let l:end_line    = search('^\s*'.l:token.'$', 'cnW') - a:offset

    return [ 'V', [0, l:start_line, 0], [0, l:end_line, 0] ]
endfunction

" TODO rejigger private functions into the `textobj#heredoc` namespace
" TODO could probably be smart and figure out the start/end id automagically
call textobj#user#plugin('heredocs', {
            \   'sql': {
            \       'select-a-function': 'CurrentLineA',
            \       'select-i-function': 'CurrentLineI',
            \       'select-a': 'aH',
            \       'select-i': 'iH',
            \   },
            \})

" __END__

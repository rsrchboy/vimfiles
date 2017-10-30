" vim-textobj plugin to handle heredocs.
"
" NOTE FIXME this might be somewhat Perl-specific?

if exists('g:loaded_textobj_heredocs')
    finish
endif
let g:loaded_textobj_heredocs = 1

" Works, but the behaviour leaves something to be desired -- namely in that
" start/end rows aren't what we'd prefer.
" call textobj#user#plugin('heredocs', {
            " \   'sql': {
            " \       'pattern': [ '<<\~\?\([''"]\?\)SQL[''"]\?.*$.', '^\s*SQL$' ],
            " \       'region-type': 'V',
            " \       'select-a': 'aH',
            " \       'select-i': 'iH',
            " \   },
            " \})

let s:sql_start = '<<\~\?\([''"]\?\)SQL[''"]\?'
let s:sql_end   = '^\s*SQL$'

function! CurrentLineA()
    return s:FindBlock(0)
endfunction

function! CurrentLineI()
    return s:FindBlock(1)
endfunction

function! s:FindBlock(offset) abort
    let l:current_line = line('.')

    " TODO handle failure modes...?

    " Never select the first line, as it's liable to have a bunch of other
    " gunk on it
    let l:start_line = search(s:sql_start, 'bcn', 1) + 1
    let l:end_line   = search(s:sql_end, 'cnW') - a:offset

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

" A utility thing to help with buffer settings (e.g. via ftplugins)

" Somewhere to keep all our tool/utility functions; this becomes
" g#rsrchboy#buffer#tools at EOF
let s:tools = {}


" Tools: mapping {{{1

" Functions to help with mapping, repeating, and unmapping.

" Function: s:map(...) {{{2
"
" Create a mapping in the given mode; enable repeat, and ensure it's undone if
" the f/t changes

let s:full = { 'n': 'normal', 'v': 'visual' }

function! s:map(no_repeat, cmd, lhs_prefix, style, lhs, rhs) dict abort
    " Force eval in a double-quote context.  This seems a bit magical, but is
    " also necessary to get things like ,a\ working properly.
    let l:lhs = a:lhs_prefix . eval('"'.  a:lhs .'"')

    let l:cmd = a:style . a:cmd . ' <buffer> <silent> ' . l:lhs . ' ' . a:rhs
        \ . (a:no_repeat ? '' : "<bar> call repeat#set('" . l:lhs . "', -1)")
        \ . '<cr>'

    execute l:cmd

    " undo the mapping -- later
    let l:lhs = substitute(l:lhs, '\c<localleader>', g:maplocalleader, '')
    call l:self.undo(a:style . 'unmap <buffer> ' . l:lhs)

    " now, stash it so we can easily list it

    if !exists('b:rsrchboy_local_mappings')
        call l:self.set('rsrchboy_local_mappings', [])
    endif

    let b:rsrchboy_local_mappings += [
        \   get(s:full, a:style, a:style) . ' ' . l:lhs . ' -> ' . a:rhs
        \]
    return
endfunction


" Methods: s:tools.map(), .nomap(), .llmap(), .llnoremap(), etc {{{2
"
" These methods provide handy shortcuts to the different forms of map we may
" wish to invoke, while also providing for their removal via `undo_ftplugin`,
" repeating via vim-repeat, cheat-sheet documentation, and default lhs prefix.
" This is not an exhaustive listing, rather one that will be populated
" on-demand.

" Rather than making life difficult, we'll just curry the heck out of s:map()

let s:tools.map         = function('s:map',  [ 0, 'map',     ''                   ])
let s:tools.noremap     = function('s:map',  [ 0, 'noremap', ''                   ])
let s:tools.nnoremap    = function('s:map',  [ 0, 'noremap', '',              'n' ])
let s:tools.llnmap      = function('s:map',  [ 0, 'map',     '<localleader>', 'n' ])
let s:tools.llnnoremap  = function('s:map',  [ 0, 'noremap', '<localleader>', 'n' ])
let s:tools.nnore2map   = function('s:map',  [ 1, 'noremap', '',              'n' ])
let s:tools.llnnore2map = function('s:map',  [ 1, 'noremap', '<localleader>', 'n' ])

" Function: s:let() {{{2

function! s:let(k, v) abort
    if !has_key(b:, a:k)
        " set this once (or try to anyways)
        if has_key(b:, 'undo_ftplugin')
            let b:undo_ftplugin .= '| unlet b:' . a:k
        else
            let b:undo_ftplugin = 'unlet b:' . a:k
        endif
    endif
    let b:[a:k] = a:v
    return
endfunction


" Function: s:tools.let() {{{2

let s:tools.let = function('s:let')

" FIXME legacy for now
let s:tools.set = function('s:let')


" Function: s:surround() {{{2

function! s:surround(key, surround) abort dict
    let l:var = 'surround_' . char2nr(a:key)
    call l:self.set(l:var, a:surround)
endfunction


" Method: s:tools.surround()

let s:tools.surround = function('s:surround')


" Function: s:undo {{{2

function! s:undo(prefix, suffix, thing) abort dict
    if has_key(b:, 'undo_ftplugin')
        let b:undo_ftplugin .= '| ' . a:prefix . a:thing . a:suffix
    else
        let b:undo_ftplugin = a:prefix . a:thing . a:suffix
    endif
    return
endfunction


" Methods: s:tools.undo(), etc {{{2

let s:tools.undo     = function('s:undo', ['',         '' ])
let s:tools.undo_var = function('s:undo', ['unlet b:', '' ])
let s:tools.undo_set = function('s:undo', ['setl ',    '<'])


" }}}2


" Section: helpers for the humans {{{1

" Function: ShowBufferMappings {{{2

function! s:ShowBufferMappings() abort dict
    let l:text = exists('b:rsrchboy_local_mappings') ? b:rsrchboy_local_mappings : []
    echo 'Our buffer local mappings:'
    for l:line in l:text
        echo l:line
    endfor
    return
endfunction

let s:tools.show_buffer_mappings = function('s:ShowBufferMappings')


" Function: ...#ShowSurroundMappinks() {{{2

function! s:ShowSurroundMappings() abort dict
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

let s:tools.ShowSurroundMappings = function('s:ShowSurroundMappings')

" }}}2


" Section: common setup functions {{{1

" Function: rsrchboy#buffer#SetSpellOpts {{{2
"
" Call to set buffer-specific spell settings
"
function! rsrchboy#buffer#SetSpellOpts(filetype) abort
    let b:undo_ftplugin .= '| setl spell< spellcapcheck< spellfile<'
    setlocal spell
    setlocal spelllang=en_us
    setlocal spellcapcheck=0
    execute 'setlocal spellfile+=~/.vim/spell/' . a:filetype . '.utf-8.add'
endfunction


" Function: rsrchboy#buffer#CommonMappings() {{{2

function! rsrchboy#buffer#CommonMappings() abort

    " FIXME TODO

    " nnoremap <buffer> <silent> <localleader>a. :s/\s*[.,;]*\s*$/./<cr>
    " nnoremap <buffer> <silent> <localleader>a, :s/\s*[.,;]*\s*$/,/<cr>
    " nnoremap <buffer> <silent> <localleader>a; :s/\s*[.,;]*\s*$/;/<cr>

    " works!
    " call s:tools.llnnoremap('aR', ':s/\s*[.,;]*\s*$/;/')

endfunction


" Function: rsrchboy#buffer#shellSurrounds {{{2

""
"
" vim-surround mappings for shell
"
" D -> [[ ... ]]
"
function! rsrchboy#buffer#shellSurrounds() abort

    " let l

    " let b:surround_68 = "[[ \r ]]"
    call s:let('surround_68', "[[ \r ]]")
    call s:let('surround_100', "(( \r ))")
endfunction


" }}}2


" Section: finalize {{{1

let g:rsrchboy#buffer#tools = s:tools

" __END__

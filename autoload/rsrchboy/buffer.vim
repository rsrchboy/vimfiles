"
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

function! s:map(cmd, lhs_prefix, style, lhs, rhs) dict abort
    " Force eval in a double-quote context.  This seems a bit magical, but is
    " also necessary to get things like ,a\ working properly.
    let l:lhs = eval('"'.  a:lhs .'"')
    execute a:style . a:cmd . ' <buffer> <silent> ' . a:lhs_prefix . l:lhs . ' ' . a:rhs
                \ . "<bar> call repeat#set('".a:lhs_prefix.l:lhs."', -1)<cr>"

    " undo the mapping -- later
    let l:lhs = substitute(a:lhs_prefix.l:lhs, '\c<localleader>', g:maplocalleader, 'g')
    let b:undo_ftplugin .= '| ' . a:style . 'unmap <buffer> ' . l:lhs

    " now, stash it so we can easily list it

    if !exists('b:rsrchboy_local_mappings')
        call l:self.set('rsrchboy_local_mappings', [])
    endif

    let b:rsrchboy_local_mappings += [
        \   get(s:full, a:style, a:style) . ' ' . l:lhs . ' -> ' . a:rhs
        \]
    return
endfunction


" Functions: s:tools.map(), .nomap(), .llmap(), .llnoremap(), etc {{{2

" Rather than making life difficult, we'll just curry the heck out of s:map()

let s:tools.map        = function('s:map',  [ 'map',     '' ])
let s:tools.noremap    = function('s:map',  [ 'noremap', '' ])
let s:tools.nnoremap   = function('s:map',  [ 'noremap', '',              'n' ])
let s:tools.llnmap     = function('s:map',  [ 'map',     '<localleader>', 'n' ])
let s:tools.llnnoremap = function('s:map',  [ 'noremap', '<localleader>', 'n' ])


" Function: s:set() {{{2

function! s:set(k, v) abort
    if !has_key(b:, a:k)
        " set this once (or try to anyways)
        let b:undo_ftplugin .= '| unlet b:' . a:k
    endif
    let b:[a:k] = a:v
    return
endfunction


" Function: s:tools.set() {{{2

let s:tools.set = function('s:set')

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


" }}}2

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
    call s:set('surround_68', "[[ \r ]]")
endfunction


" }}}2


" Section: finalize {{{1

let g:rsrchboy#buffer#tools = s:tools

" __END__

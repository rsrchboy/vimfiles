
""
"
" Somewhere to keep all our tool/utility functions; this becomes
" g#rsrchboy#buffer#tools at EOF
let s:tools = {}

""
"
" Call to set buffer-specific spell settings
function! rsrchboy#buffer#SetSpellOpts(filetype) abort
    let b:undo_ftplugin .= ' | setl spell< spellcapcheck< spellfile<'
    setlocal spell
    setlocal spelllang=en_us
    setlocal spellcapcheck=0
    execute 'setlocal spellfile+=~/.vim/spell/' . a:filetype . '.utf-8.add'
endfunction


" Tools: mapping {{{1

" Functions to help with mapping, repeating, and unmapping.

" Function: s:map(...) {{{2

""
"
" Create a mapping in the given mode; enable repeat, and ensure it's undone if
" the f/t changes
function! s:map(cmd, lhs_prefix, style, lhs, rhs) abort
    let l:lhs = a:lhs_prefix . a:lhs
    execute a:style . a:cmd . ' <buffer> <silent> ' . l:lhs . ' ' . a:rhs
                \ . '<bar> call repeat#set("'.l:lhs.'", -1)<cr>'
                " \ . '<bar> call repeat#set("'.a:lhs.'", v:count)<cr>'
    let b:undo_ftplugin .= '| ' . a:style . 'unmap <buffer> ' . l:lhs
endfunction


" Functions: s:tools.map(), .nomap(), .llmap(), .llnoremap() {{{2

" Rather than making life difficult, we'll just curry the heck out of s:map()

" let s:tools.llnnoremap = function('s:map', ['noremap', '<localleader>', 'n'])
let s:tools.map        = function('s:map',         ['map'])
let s:tools.noremap    = function('s:map',         ['noremap'])
let s:tools.llnmap     = function(s:tools.map,     ['<localleader>', 'n'])
let s:tools.llnnoremap = function(s:tools.noremap, ['<localleader>', 'n'])

" }}}2


" Section: mappings {{{1

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


" Tools: setting buffer-local vars {{{1

" Function: s:set() {{{2

function! s:set(k, v) abort
    let b:[a:k] = a:v
    let b:undo_ftplugin .= ' | unlet b:' . a:k
    return
endfunction


" Function: s:tools.set() {{{2

let s:tools.set = function('s:set')

" }}}2


""
"
" vim-surround mappings for shell
"
" D -> [[ ... ]]
"
function! rsrchboy#buffer#shellSurrounds() abort

    " let b:surround_68 = "[[ \r ]]"
    call s:set('surround_68', "[[ \r ]]")
endfunction

let g:rsrchboy#buffer#tools = s:tools

" __END__

" Vim syntax file
" Language:      Additional VIM syntax highlighting
" Maintainer:    Chris Weyl <cweyl@alumni.drew.edu>


" Section: variables {{{1

" The fact that in something like
"
"   call foo(s:bar, g:baz)
"
" Neither s:bar nor g:baz where being highlighted as variables was kinda
" bugging me.  I'm not sure this is intentional, and I haven't hunted down
" where to submit a PR.
syn cluster vimOperGroup add=vimFBVar


" Section: stuff for plugins! {{{1

" junegunn/vim-plug
syn keyword vimCommand Plug


" Section: functions and methods {{{1
"
" Properly highlight functions and methods.

syn match vimVar        "\<[bwglstav]:\h[a-zA-Z0-9#_]*\>" contained containedin=vimUserFunc

hi link vimFunction Function
hi link vimUserFunc Function


" Section: dictionaries {{{1
"
" Allow things like this to look as one would expect:
"
"   let s:tools.map = function('s:map', [ 'map', '' ])

syn match vimDictKey  "\<\h\w\+\>" contained
syn match vimDictOper "\." contained nextgroup=vimDictKey
syn match vimVar        "\<\h[a-zA-Z0-9#_]*\>" contained nextgroup=vimDictOper
syn match vimVar        "\<[bwglstav]:\h[a-zA-Z0-9#_]*\>" nextgroup=vimDictOper

hi link vimDictOper Operator
hi link vimDictKey  Identifier


" }}}1


" __END__

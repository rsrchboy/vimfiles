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

hi link vimFunction Function
hi link vimUserFunc Function

" syn match vimFunc     "\%(\%([sSgGbBwWtTlL]:\|<[sS][iI][dD]>\)\=\%([a-zA-Z0-9_]\+\.\)*\I[a-zA-Z0-9_.]*\)\ze\s*("      contains=vimFuncName,vimUserFunc,vimExecute
" syn match vimUserFunc contained   "\%(\%([sSgGbBwWtTlL]:\|<[sS][iI][dD]>\)\=\%([a-zA-Z0-9_]\+\.\)*\I[a-zA-Z0-9_.]*\)\|\<\u[a-zA-Z0-9.]*\>\|\<if\>"    contains=vimNotation
" FIXME
syn match vimUserFunc contained "\<\w\+#\w\+\>"  contains=vimNotation
" syn match vimNotFunc  "\<if\>\|\<el\%[seif]\>\|\<return\>\|\<while\>"

syn cluster vimAugroupList add=vimUserFunc

" Section: dictionaries {{{1
"
" Allow things like this to look as one would expect:
"
"   let s:tools.map = function('s:map', [ 'map', '' ])

syn match vimDictKey  "\<\h\w\+\>" contained nextgroup=vimDictOper
" syn match vimDictMethod  "\<\h\w[\w#]*\w\>(.*)" contained nextgroup=vimDictOper contains=vimOperParen,vimOperGroup
syn match vimDictMethod  "\<\h\w[\w#]*\w\>([^)]*)" contained nextgroup=vimDictOper contains=vimOperParen,vimOperGroup
syn match vimDictOper "\." contained nextgroup=vimDictMethod,vimDictKey
syn match vimVar        "\<\h[a-zA-Z0-9#_]*\>" contained nextgroup=vimDictOper
syn match vimVar        "\<[bwglstav]:\h[a-zA-Z0-9#_]*\>" contained containedin=vimUserFunc,vimFunc nextgroup=vimDictOper

hi link vimDictOper   Operator
hi link vimDictKey    Identifier
hi link vimDictMethod Function


" }}}1


" __END__

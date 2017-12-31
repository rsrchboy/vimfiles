" Vim syntax overrides + additions file
" Language:      Additional VIM syntax highlighting
" Maintainer:    Chris Weyl <cweyl@alumni.drew.edu>

" Plugins: syntax changes related to plugins {{{1

" Plugin: junegunn/vim-plug {{{2

syn keyword vimCommand Plug

" }}}2

" Core:  syntax/vim.vim overrides and extensions {{{1

" Subject: fold markers {{{2

" make these a little easier for the eyeball to skip

syn match vimFoldMarkerOpen    /\(" \)\?{{{\(\d\+\)\?/ contained containedin=vimLineComment
syn match vimFoldMarkerOpen          /" {{{\(\d\+\)\?/ contained containedin=vimComment
syn match vimFoldMarkerClose   /\(" \)\?}}}\(\d\+\)\?/ contained containedin=vimLineComment
syn match vimFoldMarkerClose         /" }}}\(\d\+\)\?/ contained containedin=vimComment

hi link vimFoldMarkerOpen  Ignore
hi link vimFoldMarkerClose Ignore

" Subject: embedded Perl blocks {{{2

let s:syn = b:current_syntax
unlet b:current_syntax
syntax include @PERL syntax/perl.vim
let b:current_syntax = s:syn
unlet s:syn
" syntax region vimHereDocPerl start=+<<EOP+ matchgroup=perlStringStartEnd end=+^\(PERL\|EOP\)$+ contains=@PERL
syntax region vimHereDocPerl matchgroup=perStringStartEnd start=+<<EOP\s*$+ end=/^EOP/ keepend contains=@PERL

" Subject: TODO/FIXME etc {{{2

" FIXME this needs to be contained
syn match vimTodo /\<\(NOTES\?\|TBD\|FIXME\|XXX\|PLAN\)[:]\?/

" Subject: g: / s: highlighting {{{2
"
" The fact that in something like
"
"   call foo(s:bar, g:baz)
"
" Neither s:bar nor g:baz where being highlighted as variables was kinda
" bugging me.  I'm not sure this is intentional, and I haven't hunted down
" where to submit a PR.

syn cluster vimOperGroup add=vimFBVar

" Subject: 'finish' {{{2

syn keyword vimCommandFinish finish contained containedin=vimIsCommand
hi link vimCommandFinish Error

" Subject: highlight linked groups as that group {{{2

" groups listing snagged from syntax/vim.vim
" syn keyword vimGroup contained	Comment Constant String Character Number Boolean Float Identifier Function Statement Conditional Repeat Label Operator Keyword Exception PreProc Include Define Macro PreCondit Type StorageClass Structure Typedef Special SpecialChar Tag Delimiter SpecialComment Debug Underlined Ignore Error Todo 

" FIXME TODO buffer-vs-global
if exists('b:syntax_highlight_as_group') && b:syntax_highlight_as_group

    " This will cause our vimGroup* groups to be used rather than vimGroup.  I'm
    " reasonably sure this won't cause issues, but...
    syn keyword vimGroupError Error contained containedin=vimHiLink
    hi link vimGroupError Error
    syn keyword vimGroupTodo Todo contained containedin=vimHiLink
    hi link vimGroupTodo Todo
    syn keyword vimGroupSpecial Special contained containedin=vimHiLink
    hi link vimGroupSpecial Special
    syn keyword vimGroupIgnore Ignore contained containedin=vimHiLink
    hi link vimGroupIgnore Ignore

endif " }}}2

" Section: General overrides {{{1

" Section: functions and methods {{{2
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


" Section: dictionaries {{{2
"
" Allow things like this to look as one would expect:
"
"   let s:tools.map = function('s:map', [ 'map', '' ])

syn match vimDictKey  "\<\h\w\+\>" contained nextgroup=vimDictOper
" syn match vimDictMethod  "\<\h\w[\w#]*\w\>(.*)" contained nextgroup=vimDictOper contains=vimOperParen,vimOperGroup
syn match vimDictMethod  "\<\h\w[\w#]*\w\>([^)]*)" contained nextgroup=vimDictOper contains=vimOperParen,vimOperGroup
syn match vimDictOper "\." contained nextgroup=vimDictMethod,vimDictKey
" syn match vimVar        "\<\h[a-zA-Z0-9#_]*\>" contained nextgroup=vimDictOper
syn match vimVar        "\<\h[a-zA-Z0-9#_]*\>" nextgroup=vimDictOper
syn match vimVar        "\<[bwglstav]:\h[a-zA-Z0-9#_]*\>" nextgroup=vimDictOper
syn match vimVar        "\<[bwglstav]:\h[a-zA-Z0-9#_]*\>" contained containedin=vimUserFunc,vimFunc nextgroup=vimDictOper

hi link vimDictOper   Operator
hi link vimDictKey    Identifier
hi link vimDictMethod Function

" }}}1

" __END__

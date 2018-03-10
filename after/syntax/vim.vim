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

let [s:syn, s:fm] = [b:current_syntax, &foldmethod]
unlet b:current_syntax
syntax include @PERL syntax/perl.vim
let [b:current_syntax, &l:foldmethod] = [s:syn, s:fm]
unlet s:syn s:fm

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

" Section: General overrides {{{1

" Section: functions and methods {{{2
"
" Properly highlight functions and methods.

hi link vimFunction Function
hi link vimUserFunc Function

" syn cluster vimAugroupList add=vimUserFunc


" Section: file-specific overrides " {{{

if @% =~# 'vim-fugitive/plugin/fugitive.vim$' " {{{2
    setl foldmarker=function!,endfunction
endif

" __END__

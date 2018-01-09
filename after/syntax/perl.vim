" Vim syntax file
" Language:      Perl 5 syntax extensions (Moose, Try::Tiny, etc)
" Maintainer:    Chris Weyl <cweyl@alumni.drew.edu>
" Last Change:   ...check GitHub :)


" no reason to repeat ourselves
if !has_key(g:, 'mm_loaded')
    let s:syn = b:current_syntax
    unlet b:current_syntax
    syntax include @SQL syntax/sql.vim
    let b:current_syntax = s:syn
    unlet s:syn
    syntax region perlHereDocSQL start=+<<['"]SQL['"].*;\s*$+ matchgroup=perlStringStartEnd end=+^SQL$+ contains=@SQL
    " indented!  req v5.26
    syntax region perlHereDocSQL start=/<<\~['"]SQL['"].*;\s*$/ matchgroup=perlStringStartEnd end=/^\s*SQL$/ contains=@SQL

    " Helps the heredoc be recognized regardless of where it's initiated
    syn cluster perlExpr add=perlHereDocSQL
endif

" I like to do shift->this->that->[1]->{...} sometimes.
"
" ok, all the time.
"
" OK, FINE, CONSTANTLY I LIKE TO DO IT CONSTANTLY ALRIGHT?!
syn match  perlVarPlain "shift" nextgroup=perlVarMember,perlVarSimpleMember,perlMethod,perlPostDeref extend

" Method Chains: you know you like them

" original:
" syn match  perlMethod   "->\$*\I\i*" contained nextgroup=perlVarSimpleMember,perlVarMember,perlMethod,perlPostDeref
"
" Crude, also matches parameters
" syn match  perlMethod   "->\$*\I\i*(.*)" contained nextgroup=perlVarSimpleMember,perlVarMember,perlMethod,perlPostDeref
" syn match  perlMethod   ")->\$*\I\i*" contained nextgroup=perlVarSimpleMember,perlVarMember,perlMethod,perlPostDeref

syn match  perlMethod   "->\$*\I\i*"        contained nextgroup=perlVarSimpleMember,perlVarMember,perlMethod,perlPostDeref,perlMethodArgs
syn match  perlMethod   ")->\$*\I\i*"ms=s+1           nextgroup=perlVarSimpleMember,perlVarMember,perlMethod,perlPostDeref,perlMethodArgs
syn match  perlMethod   "^\s*->\$*\I\i*"              nextgroup=perlVarSimpleMember,perlVarMember,perlMethod,perlPostDeref,perlMethodArgs
" FIXME the oneline is a kludge to keep this from never terminating
syn region perlMethodArgs matchgroup=perlMethod start="(" end=")" contained contains=@perlExpr nextgroup=perlVarSimpleMember,perlVarMember,perlMethod,perlPostDeref oneline


" $+ isn't picked up by perlVarPlain otherwise -- '+' is (correctly) not in
" isident or iskeyword
syn match  perlVarPlain "\$+" contains=perlPackageRef nextgroup=perlVarMember,perlVarSimpleMember,perlMethod,perlPostDeref

" some more map-like things I'd like highlighted that way...
syn match perlStatementList "\<\%(apply\)\>"

" Moose: {{{1
syn match perlOperator           "\<\%(blessed\)\>"

" AttributeShortcuts: {{{2
syn match perlStatementProc '\<\%(isa_instance_of\|constraint\)\>'

" MooseX::Role::Parameterized -- for now {{{2
syn match perlFunction      /\<\%(role\)\>/
syn match perlMooseAttribute /\<parameter\>\_s*/ nextgroup=perlMooseAttributeName
syn match perlMooseAttribute /\<\%(before\|method\|around\|after\)\>\_s*/ nextgroup=perlMooseAttributeName

syn match perlMooseAttribute     /\<has\>\_s*/ nextgroup=perlMooseAttributeName
syn match perlMooseAttributeName /\<(\i*\>/    nextgroup=perlFatComma contained
syn match perlFatComma           /=>/          contained

hi def link perlMooseAttribute perlFunction
hi def link perlMooseAttributeName perlSubName

" }}}1

" "normal"
syn match   perlTodo /\<\(NOTES\?\|TBD\|FIXME\|XXX\|PLAN\)[:]\?/ contained contains=NONE,@NoSpell

" dzil-specific highlights dzil
syn match perlPodWeaverSpecialComment "^# [A-Z0-9]\+: " contained containedin=perlComment

hi def link perlPodWeaverSpecialCommentKeywords Todo

" TODO highlight smart comments differently!
" We don't really do much with this right now, but it'd be nice to have smart
" syntax matching to tell me where I've messed up...
syn region perlSmartComment start="###\+ " end="$" transparent contains=perlTodo,@Spell contained containedin=perlComment

" set transparent, above.
" hi def link perlSmartComment perlComment

" syn match perlOperator containedin=@TOP /[!:?]/
syn match   perlOperator    containedin=@TOP /[!]/
" syn match   perlConditional containedin=@TOP /[:?]/
syn match   perlConditional containedin=@TOP /[?]/
syn match   perlConditional /[^:]:[^:]/ms=s+1,me=e-1 containedin=@TOP
syn keyword perlUndef       undef containedin=@TOP

hi link perlUndef Special
" hi link perlUndef Constant


" Perl Critic And Tidy:
syn match perlCriticOverride /## \?\(no\|use\) critic.*$/ containedin=perlComment contained conceal
syn match perlTidyOverride   /#\(<<<\|>>>\)$/ containedin=perlComment contained

" Delimiter, Special, and Ignore all seem appropriate, depending on what one
" wants.  I just want them to go away, so...
hi link perlCriticOverride Ignore
hi link perlTidyOverride   Ignore


" syn match   perlPackageName "\<use\s\+\%(\h\|::\)\%(\w\|::\)*" contains=perlStatementUse

" syn match   perlStatementInclude "\<use\s\+\%(\h\|::\)\%(\w\|::\)*" contains=perlStatementUse
syn match   perlStatementInclude "\<use\s\+[A-Z]\%(\w\|::\)*\>" contains=perlStatementUse
syn keyword perlStatementUse     use contained
" \s\+\l\(\i\|:\)\+

" hi link perlStatementUse perlStatement
" hi link perlStatementInclude Include

" hi link perlStatementUse Include
" hi link perlStatementInclude Type

hi link perlStatementUse Include
" hi link perlStatementInclude StorageClass
" hi link perlStatementInclude Structure
hi link perlStatementInclude perlString


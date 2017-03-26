" Vim syntax file
" Language:      Perl 5 syntax extensions (Moose, Try::Tiny, etc)
" Maintainer:    Chris Weyl <cweyl@alumni.drew.edu>
" Last Change:   ...check GitHub :)

" I like to do shift->this->that->[1]->{...} sometimes.
"
" ok, all the time.
"
" OK, FINE, CONSTANTLY I LIKE TO DO IT CONSTANTLY ALRIGHT?!
syn match  perlVarPlain "shift" nextgroup=perlVarMember,perlVarSimpleMember,perlMethod,perlPostDeref extend

" Moose: {{{1
syn match perlOperator           "\<\%(blessed\)\>"

" AttributeShortcuts: {{{2
syn match perlStatementProc '\<\%(isa_instance_of\|constraint\)\>'

" MooseX::Role::Parameterized -- for now {{{2
syn match perlFunction      "\<\%(role\)\>"
syn match perlMooseAttribute +\<parameter\>\_s*+ nextgroup=perlMooseAttributeName
syn match perlMooseAttribute +\<\%(before\|method\|around\|after\)\>\_s*+ nextgroup=perlMooseAttributeName

syn match perlMooseAttribute     +\<has\>\_s*+ nextgroup=perlMooseAttributeName
syn match perlMooseAttributeName +\<(\i*\>+    nextgroup=perlFatComma contained
syn match perlFatComma           +=>+          contained

hi def link perlMooseAttribute perlFunction
hi def link perlMooseAttributeName perlSubName

" "normal"
syn match   perlTodo /\<\(NOTE\|TBD\|FIXME\|XXX\|PLAN\)[:]\?/ contained contains=NONE,@NoSpell

" dzil-specific highlights dzil
syn keyword perlTodo PODNAME: ABSTRACT: contained
syn keyword perlPodWeaverSpecialCommentKeywords ABSTRACT: PACKAGE: nextgroup=perlPodWeaverSpecialCommentRemainder contained
syn match perlPodWeaverSpecialCommentRemainder ".*" contained contains=@Spell
syn match perlPodWeaverSpecialComment "^# .*:" contains=perlPodWeaverSpecialCommentKeywords

" Should probably be something a little nicer :)
hi def link perlPodWeaverSpecialCommentKeywords Todo

" TODO highlight smart comments differently!
syn match  perlComment "###* " contains=perlTodo,@Spell extend

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
syn match perlPodWeaverSpecialComment "^# [A-Z0-9]\+:" contained containedin=perlComment

hi def link perlPodWeaverSpecialCommentKeywords Todo

" TODO highlight smart comments differently!
" We don't really do much with this right now, but it'd be nice to have smart
" syntax matching to tell me where I've messed up...
syn region perlSmartComment start="###\+ " end="$" transparent contains=perlTodo,@Spell contained containedin=perlComment

" set transparent, above.
" hi def link perlSmartComment perlComment


" PerlCritic And PerlTidy:
syn match perlCritic /## \?\(no\|use\) critic.*$/ containedin=perlComment contained
syn match perlTidy   /#\(<<<\|>>>\)$/ containedin=perlComment contained

" Delimiter, Special, and Ignore all seem appropriate, depending on what one
" wants.  I just want them to go away, so...
hi link perlCritic Ignore
hi link perlTidy   Ignore

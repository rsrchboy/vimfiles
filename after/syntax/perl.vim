" Vim syntax file
" Language:      Perl 5 syntax extensions (Moose, Try::Tiny, etc)
" Maintainer:    Chris Weyl <cweyl@alumni.drew.edu>
" Last Change:   ...check GitHub :)
"
" This extends the vim-perl syntax package to handle:
"
"   * Moose * MooseX::Role::Parameterized * Try::Tiny
"
" ...kinda.

exe 'source ' . g:plug_home . '/vim-perl/contrib/carp.vim'
exe 'source ' . g:plug_home . '/vim-perl/contrib/moose.vim'
exe 'source ' . g:plug_home . '/vim-perl/contrib/try-tiny.vim'

" I like to do shift->this->that->[1]->{...} sometimes.
"
" ok, all the time.
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

if !exists("perl_include_pod") || perl_include_pod == 1
  " Include a while extra syntax file
  syn include @Pod syntax/pod.vim
  unlet b:current_syntax
  if exists("perl_fold")
    syn region perlPOD start="^=[a-z]" end="^=cut" contains=@Pod,@Spell,perlTodo keepend fold extend
    syn region perlPOD start="^=cut" end="^=cut" contains=perlTodo keepend fold extend
  else
    syn region perlPOD start="^=[a-z]" end="^=cut" contains=@Pod,@Spell,perlTodo keepend
    syn region perlPOD start="^=cut" end="^=cut" contains=perlTodo keepend
  endif
else
  " Use only the bare minimum of rules
  if exists("perl_fold")
    syn region perlPOD start="^=[a-z]" end="^=cut" contains=@Spell keepend fold
  else
    syn region perlPOD start="^=[a-z]" end="^=cut" contains=@Spell keepend
  endif
endif

" add-on to the perl/pod syntax to include our custom podweaver pod
" commands as bonafide pod.

"syn include @Pod <sfile>:p:h/pod.vim syn region myPOD start="^=pod"
"start="^=head" start="^=func" end="^=cut" keepend contained contains=@Pod syn
"sync match perlSyncPOD	grouphere perlPOD "^=func"

" dzil-specific highlights dzil
syn keyword perlTodo PODNAME: ABSTRACT: contained
syn keyword perlPodWeaverSpecialCommentKeywords ABSTRACT: PACKAGE: nextgroup=perlPodWeaverSpecialCommentRemainder contained
syn match perlPodWeaverSpecialCommentRemainder ".*" contained
syn match perlPodWeaverSpecialComment "^# .*:" contains=perlPodWeaverSpecialCommentKeywords,@Spell

" Should probably be something a little nicer :)
hi def link perlPodWeaverSpecialCommentKeywords Todo

" TODO highlight smart comments differently!
syn match  perlComment "#.*" contains=perlTodo,@Spell extend

" sure spell-checking is turned on
syn region perlPOD start="^=[a-z]" end="^=cut" contains=@Spell fold

if exists("perl_include_pod") && perl_include_pod == 1
    syn   match   podCommand   "^=func"     nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=method"   nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=attr"     nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=lazyatt"  nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=reqatt"   nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=genatt"   nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=type"     nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=test"     nextgroup=podCmdText   contains=@Spell
endif

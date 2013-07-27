" Vim syntax file
" Language:      Perl 5 syntax extensions (Moose, Try::Tiny, etc)
" Maintainer:    Chris Weyl <cweyl@alumni.drew.edu>
" Last Change:   ...check GitHub :)
"
" This extends the vim-perl syntax package to handle:
"
"   * Moose
"   * MooseX::Role::Parameterized
"   * Try::Tiny
"
" Please download most recent version first before mailing
" any comments.

" Moose
syn match perlOperator           "\<\%(blessed\)"   
syn match perlStatementMisc      "\<\%(confess\)"   
syn match perlStatementInclude   "\<\%(extends\|with\)\>"
syn match perlFunction           "\<\%(before\|after\|around\|augment\|override\)\>"
syn match perlStatementStorage   "\<\%(has\)\>"
" need -- super, inner

" MooseX::Role::Parameterized -- for now
syn match perlStatementMisc      "\<\%(role\|parameter\)"   

" Try::Tiny
"
" This should be a region, but for now...
syn match perlStatementMisc      "\<\%(try\|catch\|finally\)"

syn keyword perlTodo ABSTRACT: TODO TODO: TBD TBD: FIXME FIXME: XXX XXX: NOTE NOTE: contained

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

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

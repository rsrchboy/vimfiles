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

" add-on to the perl/pod syntax to include our custom podweaver pod
" commands as bonafide pod.

"syn include @Pod <sfile>:p:h/pod.vim
"syn region myPOD start="^=pod" start="^=head" start="^=func" end="^=cut" keepend contained contains=@Pod
"syn sync match perlSyncPOD	grouphere perlPOD "^=func"

" dzil-specific highlights
syn keyword perlPodWeaverSpecialCommentKeywords ABSTRACT: PACKAGE: nextgroup=perlPodWeaverSpecialCommentRemainder contained
"syn match perlPodWeaverSpecialComment "^ *#+ *" contains=perlPodWeaverSpecialCommentKeywords,@Spell nextgroup=perlPodWeaverSpecialCommentKeywords
syn match perlPodWeaverSpecialCommentRemainder ".*" contained
syn match perlPodWeaverSpecialComment "^# .*:" contains=perlPodWeaverSpecialCommentKeywords,@Spell

" Should probably be something a little nicer :)
hi def link perlPodWeaverSpecialCommentKeywords Todo

"syn region perlPodWeaverSpecialComment matchgroup=perlPodWeaverSpecialComment contains=perlPodWeaverSpecialCommentKeys,@Spell start="^ *# " end="$"

" @110
" ABSTRACT and PACKAGE being dzil things
"syn keyword perlTodo	ABSTRACT: PACKAGE: TODO TODO: TBD TBD: FIXME FIXME: XXX XXX: NOTE NOTE: contained

" TODO highlight smart comments differently!
syn match  perlComment		"#.*" contains=perlTodo,@Spell extend

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

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
" ...kinda.

source ~/.vim/bundle/vim-perl/contrib/carp.vim
source ~/.vim/bundle/vim-perl/contrib/moose.vim
source ~/.vim/bundle/vim-perl/contrib/try-tiny.vim

" Moose: {{{1
syn match perlOperator           "\<\%(blessed\)\>"

" AttributeShortcuts: {{{2
syn match perlStatementProc '\<\%(isa_instance_of\|constraint\)\>'

" MooseX::Role::Parameterized -- for now {{{2
syn match perlFunction      "\<\%(role\)\>"
syn match perlMooseAttribute +\<parameter\>\_s*+ nextgroup=perlMooseAttributeName
syn match perlMooseAttribute +\<\%(before\|method\|around\|after\)\>\_s*+ nextgroup=perlMooseAttributeName

syn match perlMooseAttribute +\<has\>\_s*+ nextgroup=perlMooseAttributeName
"syn match perlMooseAttributeName "\<\%(\)\>" contained
syn match perlMooseAttributeName +\%(\h*\)+  contained nextgroup=perlFatComma

syn match  perlFatComma "\%(\s*=>\)" contained

hi def link perlMooseAttribute perlFunction
hi def link perlMooseAttributeName perlSubName


syn keyword perlTodo PODNAME: ABSTRACT: TODO TODO: TBD TBD: FIXME FIXME: XXX XXX: NOTE NOTE: contained

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

" highlight markers for Data::Section::Simple in __DATA__
"
" NOTE: the master Perl syntax file does not distinguish between __DATA__ and
" __END__ at the moment, so we'll get highlighting for this under __END__ as
" well...  where Data::Section::Simple will be unable to read from.  *le sigh*
"
"   @@ template/name
syn region perlDATASectionDecl matchgroup=perlDATASectionStatementMarker start=/^@@ / end=/$/ oneline contained containedin=perlDATA

hi def link perlDATASectionDecl            perlTodo
hi def link perlDATASectionStatementMarker Keyword

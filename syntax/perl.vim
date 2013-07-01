" small add-on to the perl/pod syntax to include our custom podweaver pod
" commands as bonafide pod.
"
" Chris Weyl <cweyl@alumni.drew.edu> 2012
"
"syn include @Pod <sfile>:p:h/pod.vim
"syn region myPOD start="^=pod" start="^=head" start="^=func" end="^=cut" keepend contained contains=@Pod
"syn sync match perlSyncPOD	grouphere perlPOD "^=func"

" dzil-specific highlights
syn keyword perlPodWeaverSpecialCommentKeywords ABSTRACT: PACKAGE: nextgroup=perlPodWeaverSpecialCommentRemainder contained
"syn match perlPodWeaverSpecialComment "^ *#+ *" contains=perlPodWeaverSpecialCommentKeywords,@Spell nextgroup=perlPodWeaverSpecialCommentKeywords
syn match perlPodWeaverSpecialCommentRemainder ".*" contained
syn match perlPodWeaverSpecialComment "^# .*:" contains=perlPodWeaverSpecialCommentKeywords,@Spell 



hi def link perlPodWeaverSpecialCommentKeywords Todo

"syn region perlPodWeaverSpecialComment matchgroup=perlPodWeaverSpecialComment contains=perlPodWeaverSpecialCommentKeys,@Spell start="^ *# " end="$"

" @110
" ABSTRACT and PACKAGE being dzil things
"syn keyword perlTodo	ABSTRACT: PACKAGE: TODO TODO: TBD TBD: FIXME FIXME: XXX XXX: NOTE NOTE: contained

" TODO highlight smart comments differently!
syn match  perlComment		"#.*" contains=perlTodo,@Spell extend

" sure spell-checking is turned on
syn region perlPOD start="^=[a-z]" end="^=cut" contains=@Spell fold

if !exists("perl_include_pod") || perl_include_pod == 1
    syn   match   podCommand   "^=func"     nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=method"   nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=attr"     nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=lazyatt"  nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=reqatt"   nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=genatt"   nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=type"     nextgroup=podCmdText   contains=@Spell
    syn   match   podCommand   "^=test"     nextgroup=podCmdText   contains=@Spell
endif

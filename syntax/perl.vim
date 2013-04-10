" small add-on to the perl/pod syntax to include our custom podweaver pod
" commands as bonafide pod.
"
" Chris Weyl <cweyl@alumni.drew.edu> 2012
"
"syn include @Pod <sfile>:p:h/pod.vim
"syn region myPOD start="^=pod" start="^=head" start="^=func" end="^=cut" keepend contained contains=@Pod
"syn sync match perlSyncPOD	grouphere perlPOD "^=func"
"
syn   match   podCommand   "^=func"     nextgroup=podCmdText   contains=@NoSpell
syn   match   podCommand   "^=method"   nextgroup=podCmdText   contains=@NoSpell
syn   match   podCommand   "^=attr"     nextgroup=podCmdText   contains=@NoSpell
syn   match   podCommand   "^=lazyatt"  nextgroup=podCmdText   contains=@NoSpell
syn   match   podCommand   "^=reqatt"   nextgroup=podCmdText   contains=@NoSpell
syn   match   podCommand   "^=genatt"   nextgroup=podCmdText   contains=@NoSpell
syn   match   podCommand   "^=type"     nextgroup=podCmdText   contains=@NoSpell
syn   match   podCommand   "^=test"     nextgroup=podCmdText   contains=@NoSpell


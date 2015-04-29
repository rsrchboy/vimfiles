" minor gitcommit syntax tweaks to highlight... things I find worth
" highlighting.  like [skip ci] :)
"
" Chris Weyl <cweyl@alumni.drew.edu> 2015

" Make the Travis "skip ci" tokens very visible
syn match    gitcommitTravisToken  "\[skip ci\]"
hi def link  gitcommitTravisToken  Error

" When someone (e.g. @RsrchBoy) is mentioned, highlight that.
syn match    gitcommitAtUser       "@\w*"
"hi def link  gitcommitAtUser       Keyword
hi def link  gitcommitAtUser       Constant

syn match gitcommitIssueNumber "[#][1-9][0-9]*" contained containedin=gitcommitGitHubClose
syn match gitcommitRepoID      "\(\w\+/\w\+\)" contained containedin=gitcommitGitHubClose
syn match gitcommitGitHubClose "\(close[sd]\?\|fix\(\|es\|ed\)\|resolve[sd]\?\) \(\w\+/\w\+\)\?[#][1-9][0-9]*"

hi def link gitcommitGitHubClose Keyword
hi def link gitcommitGitHubIssue Keyword
hi def link gitcommitIssueNumber Constant
hi def link gitcommitRepoID      gitcommitType

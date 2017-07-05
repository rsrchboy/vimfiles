" Vim syntax file
" Language:      Additional VIM syntax highlighting
" Maintainer:    Chris Weyl <cweyl@alumni.drew.edu>

" The fact that in something like
"
"   call foo(s:bar, g:baz)
"
" Neither s:bar nor g:baz where being highlighted as variables was kinda
" bugging me.  I'm not sure this is intentional, and I haven't hunted down
" where to submit a PR.
syn cluster vimOperGroup add=vimFBVar

" junegunn/vim-plug
syn keyword vimCommand Plug

" fin...

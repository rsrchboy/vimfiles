" Vim syntax file
" Language:      gitconfig syntax extensions
" Maintainer:    Chris Weyl <cweyl@alumni.drew.edu>
" Last Change:   ...check GitHub :)

" be sensitive.
syn case match

syn match gitconfigTodo /\<\(NOTE\|TBD\|FIXME\|XXX\)[:]\?/ contained containedin=gitconfigComment contains=NONE,@NoSpell

syn match gitconfigCommentHeader /[a-z-]\+ aliases$/ contained containedin=gitconfigComment fold
syn match gitconfigCommentHeader /^;;.\+$/           contained containedin=gitconfigComment fold

" so insensitive!
syn case ignore

hi   def   link   gitconfigTodo            Todo
hi   def   link   gitconfigCommentHeader   Label
" hi   def   link   gitconfigCommentHeader   SpecialComment

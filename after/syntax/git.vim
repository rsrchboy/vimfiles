" git syntax tweaks

" highlight headers for non-default notes refs
" syn match  gitNotesHeader /^Notes (.*):\ze\n/
syn match  gitNotesHeader /^Notes (.*):$/

" hi link gitKeyword Label
" hi link gitHash    Function

" hi link gitKeyword         Function
" hi link gitIdentityKeyword Function
" hi link gitIdentityKeyword Label
" hi link gitKeyword         Label
hi link gitIdentityKeyword Type
hi link gitKeyword         Type

" " hi link gitDate            Include
" hi link gitDate            Number
" " hi link gitHash            Exception
" hi link gitHash            Identifier

"  README.md | 28 ++++++++++++++++++++++------  {{{1

" " Identical to the following paragraph, but feels... slightly off compared
" " to it
" syn match gitDiffStatFile      /^ \zs\f\+/ contained skipwhite nextgroup=gitDiffStatRHS
" syn region gitDiffStatRHS
"             \ matchgroup=gitDiffStatDelimiter
"             \ start=/|/
"             \ end=/$/
"             \ contains=gitDiffStatTally,gitDiffStatMinus,gitDiffStatPlus
"             \ oneline
" syn match gitDiffStatTally     /\d\+/  contained
" syn match gitDiffStatPlus      /+\+/  contained
" syn match gitDiffStatMinus     /-\+/  contained

syn match gitDiffStatFile      /^ \zs\f\+/  contained skipwhite nextgroup=gitDiffStatDelimiter
syn match gitDiffStatDelimiter /|/          contained skipwhite nextgroup=gitDiffStatTally
syn match gitDiffStatTally     /\d\+/       contained skipwhite nextgroup=gitDiffStatPlus,gitDiffStatMinus
syn match gitDiffStatPlus      /+\+/        contained skipwhite nextgroup=gitDiffStatMinus
syn match gitDiffStatMinus     /-\+/        contained

syn match gitDiffStatLine /^ \f\+ | \d\+ +*-*$/ contains=gitDiffStatFile

hi link gitDiffStatDelimiter Delimiter
hi link gitDiffStatFile      diffFile
hi link gitDiffStatMinus     diffRemoved
hi link gitDiffStatPlus      diffAdded
hi link gitDiffStatTally     Number

" 1 file changed, 3 insertions(+)

syn match gitDiffStatSummationLine /^ \d\+ files\= changed, .*$/
hi link gitDiffStatSummationLine Statement

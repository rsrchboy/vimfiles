" Vim syntax file
" Language:      Perl 5 syntax extensions (Moose, Try::Tiny, etc)
" Maintainer:    Chris Weyl <cweyl@alumni.drew.edu>
" Last Change:   ...check GitHub :)

if !has_key(g:, 'perl_no_sql') " {{{
    let s:syn = b:current_syntax
    unlet b:current_syntax
    syntax include @SQL syntax/sql.vim
    let b:current_syntax = s:syn
    unlet s:syn
    syntax region perlHereDocSQL start=+<<['"]SQL['"].*;\s*$+ matchgroup=perlStringStartEnd end=+^SQL$+ contains=@SQL

    " indented!  req v5.26
    syntax region perlHereDocSQL start=/<<\~['"]SQL['"].*;\s*$/ matchgroup=perlStringStartEnd end=/^\s*SQL$/ contains=@SQL

    " Helps the heredoc be recognized regardless of where it's initiated
    syn cluster perlExpr add=perlHereDocSQL
endif " }}}

" $+ isn't picked up by perlVarPlain otherwise -- '+' is (correctly) not in
" isident or iskeyword
syn match  perlVarPlain "\$+" nextgroup=perlVarMember,perlVarSimpleMember,perlMethod,perlPostDeref

" some more map-like things I'd like highlighted that way...
syn match perlStatementList "\<\%(apply\)\>"

" FIXME include code?
syn match perlDeref     /\\\ze[$@%]/      nextgroup=perlVarPlain
syn match perlOperator           +\(=>\|//=\=\)+

" allow lines starting with ')->' to be matched, but don't match the ')'
syn match perlDerefOrInvoke     /)\=\_s*\zs->/
            \ nextgroup=perlFuncName,perlVarAsMethod,perlHashSlot,perlPostDeref,perlArraySlot
            \ skipwhite
syn match perlFuncName          +\_s*\zs\%(\h\|::\|'\w\)\%(\w\|::\|'\w\)*\_s*\|+
            \ contained
            \ contains=perlPackageRef,perlPackageDelimError
            \ nextgroup=perlMethodArgs
            \ skipwhite
syn match perlPkgOrFunc         +\%(\h\|::\|'\w\)\%(\w\|::\|'\w\)*\ze\_s*->+
            \ contains=perlPackageRef,perlPackageDelimError
            \ nextgroup=perlOperator
syn match perlVarAsMethod       /\$\w\+/
            \ contained
            \ nextgroup=perlMethodArgs
syn match perlPackageDelimError /'/
            \ contained

" NOTE these bits will only really work if we have g:perl_no_extended_vars
" set, as we're basically replacing it here.

syn match perl__ /__\%(FILE\|LINE\)__/

syntax region perlDATA matchgroup=PreProc start="^__DATA__$" skip="." end="." contains=@perlDATA

if get(g:, 'perl_no_extended_vars', 1)

    syn cluster perlExpr contains=perlStatementScalar,
        \perlStatementRegexp,perlStatementNumeric,perlStatementList,
        \perlStatementHash,perlStatementFiles,perlStatementTime,
        \perlStatementMisc,perlVarPlain,perlVarPlain2,perlVarNotInMatches,
        \perlVarSlash,perlVarBlock,perlVarBlock2,perlShellCommand,perlFloat,
        \perlNumber,perlStringUnexpanded,perlString,perlQQ,perlArrow,
        \perlBraces,perlDeref

    syn region perlHashSlot matchgroup=Delimiter start="{" skip="\\}" end="}" contained contains=@perlExpr nextgroup=perlVarMember,perlVarSimpleMember,perlPostDeref,perlDerefOrInvoke extend
    syn match  perlHashSlot "{\s*\I\i*\s*}" nextgroup=perlVarMember,
        \perlVarSimpleMember,perlPostDeref,perlDerefOrInvoke,perlHashSlot
        \ contains=perlVarSimpleMemberName,perlHashSlotDelimiters
        \ contained extend
    " syn region perlArraySlot matchgroup=Delimiter start=/\[/ end=/\]/ contained
    syn match perlArraySlot /\[\d\+\]/ contained contains=perlDelimiters,perlNumber

    syn match  perlHashSlotDelimiters /[{}]/ contained
    syn match  perlVarSimpleMemberName  "\I\i*" contained

    syn match perlBlockDerefOps /[@$%]/ contained
    syn match perlBlockDeref    /[@$%]{/ contains=perlBlockDerefOps

    syn match  perlDelimiters /[{}[\]()]/

    syn match perlPackageConst  "__PACKAGE__" nextgroup=perlPostDeref,perlDerefOrInvoke
    syn match perlSubConst      "__SUB__" nextgroup=perlPostDeref,perlDerefOrInvoke
    syn match perlPostDeref     "\%($#\|[$@%&*]\)\*" contained
    syn region  perlPostDeref   start="\%($#\|[$@%&*]\)\[" skip="\\]" end="]" contained contains=@perlExpr nextgroup=perlVarSimpleMember,perlVarMember,perlPostDeref
    " syn region  perlPostDeref matchgroup=perlPostDeref start="\%($#\|[$@%&*]\){" skip="\\}" end="}" contained contains=@perlExpr nextgroup=perlVarSimpleMember,perlVarMember,perlPostDeref
endif

hi link perlBlockDeref         Delimiter
hi link perlBlockDerefOps      perlOperator
hi link perlDelimiters         Delimiter
hi link perlDeref              Operator
hi link perlDerefOrInvoke      Operator
hi link perlFuncName           Function
hi link perlHashSlotDelimiters Delimiter
hi link perlPackageConst       Macro
hi link perlPackageDelimError  Error
hi link perlPkgOrFunc          Function
hi link perlPostDeref          Operator
hi link perlSubConst           Macro
hi link perlVarAsMethod        Identifier
hi link perl__                 Macro

syn match perlLineDelimiter /;$/
hi link perlLineDelimiter Delimiter

if !get(g:, 'perl_use_region', 0) " {{{

    " syn keyword perlIncludeUse    nextgroup=perlIncludeUsedPkg containedin= use
    syn keyword perlUse         skipwhite nextgroup=perlUsedPkg,perlUsedPerlVer use
    syn match   perlUsedPkg     +\%(\h\|::\|'\w\)\%(\w\|::\|'\w\)*\ze\%(;$\|\_s\+\)+       contained contains=perlPackageDelimError
    syn match   perlUsedPerlVer /\%(v5.\d\d\=\|5.\d\d\d\)/      contained

    " syn region perlUseConstant start=/\<use\s+constant/ end=/=>/

    hi link perlUse         Include
    hi link perlUsedPkg     perlType
    hi link perlUsedPerlVer PreCondit

else " {{{

    " this is experimental, unfinished, and more of itch-scratching, really.
    syn region perlUseRegion matchgroup=perlStatementUse start=/^\s*use\>/ matchgroup=Delimiter end=/;/

    hi link perlStatementUse Include
endif " }}}1

syn match perlOperator           "\<\%(blessed\)\>"

" syn match   perlVarScalar  +$\%(\h\|::\|'\w\)\%(\w\|::\|'\w\)*\_s*\|+ contained

syn region perlAttribute       matchgroup=Statement start='^\s*has\>' matchgroup=perlOperator end='=>'
syn region perlMethodModifier  matchgroup=perlStatementMethodModifier start='^\s*\<\%(before\|after\|around\|override\|augment\)\>' matchgroup=perlOperator end=/=>\s*/ nextgroup=perlFunction,perlVarScalar,perlSubRef,perlMMError
" matches if (sub or \& or $\k+ matches) doesn't match
syn match perlMMError /\(sub\&\|\\&\&\|$\k\+\&\)\@!.*/ contained

syn match perlSubRef   /\\&\h\k\+/ contains=perlOperator
syn match perlOperator /\\&/ nextgroup=perlFuncName

hi link perlStatementMethodModifier perlStatement
hi link perlMethodModifier          perlSubName
hi link perlAttribute               perlSubName
hi link perlSubRef                  perlSubName
hi link perlMMError                 Error

" "normal"
syn match   perlTodo /\<\(NOTES\?\|TBD\|FIXME\|XXX\|PLAN\)[:]\?/ contained contains=NONE,@NoSpell

syn match perlPodWeaverSpecialComment "\C^# \zs[A-Z0-9]\+: " contained containedin=perlComment
syn match perlCriticOverride          /## \?\(no\|use\) critic.*$/ containedin=perlComment contained
syn match perlTidyOverride            /#\(<<<\|>>>\)$/ containedin=perlComment contained

hi link perlCriticOverride          Ignore
hi link perlTidyOverride            Ignore
hi link perlPodWeaverSpecialComment SpecialComment

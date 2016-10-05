" highlight markers for Data::Section::Simple in __DATA__
"
" NOTE: the master Perl syntax file does not distinguish between __DATA__ and
" __END__ at the moment, so we'll get highlighting for this under __END__ as
" well...  where Data::Section::Simple will be unable to read from.  *le sigh*
"
"   @@ template/name
syn region perlDATASimpleSectionDecl matchgroup=perlDATASimpleSectionStatementMarker start=/^@@ / end=/$/ oneline contained containedin=perlDATA

hi def link perlDATASimpleSectionDecl            perlTodo
hi def link perlDATASimpleSectionStatementMarker Keyword

" Default Section:
"
" Match this, just to enable folding -- and fiddle with the color.
"
" Right now, we'll only match sections not matched by other regions by virtue
" of going first.  We may want to refactor things a bit such that other
" regions are actually contained by this one.
syn region perlDATASectionSimpleSection start=/^@@ .\{1,}$/ end=/^@@ /me=e-3 keepend contains=perlDATASimpleSectionDecl containedin=perlDATA fold

syn include @TT2 syntax/tt2.vim
syn region perlDATASectionSimpleTT2Section start=/^@@ .\{1,}\.tt2\?$/ end=/^@@ /me=e-3 keepend contains=@TT2,perlDATASimpleSectionDecl containedin=perlDATA fold

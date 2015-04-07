" Tweaks because the handling of colons in changelog entries was driving me
" *nuts* for Perl/CPAN changelogs.
"
" master changelog.vim this is based off of:
"   /usr/share/vim/vim74/syntax/changelog.vim

" OVERRIDES

"syn region	changelogFiles	start="^\s\+[+*]\s" end=":" end="^$" contains=changelogBullet,changelogColon,changelogFuncs,changelogError keepend
"syn region	changelogFiles	start="^\s\+[([]" end=":" end="^$" contains=changelogBullet,changelogColon,changelogFuncs,changelogError keepend

syn region changelogFiles start="^\s\+[+*]\s" end="^$" contains=changelogBullet,changelogFuncs,changelogError keepend
syn region changelogFiles start="^\s\+[([]"   end="^$" contains=changelogBullet,changelogFuncs,changelogError keepend

" ORIGINAL

" make our dzil placeholder look... correct.
syn match changelogNumber contained "{{\$NEXT}}"

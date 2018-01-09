

" syn match cpanIndexPkg /^\(\(\a\|\d\)*\| \|::\)/
" syn match cpanIndexPkg /^\(\(\a\|\d\)*\( \|::\)\)*/
" syn keyword cpanIndexFile File

" syn match cpanIndexPkg /^\(\(\a\|\d\|_\)\+\(::\|\)\)\+\(\a\|\d\) /me=e-1
syn match cpanIndexPkg /^\(\(\a\|\d\|_\)\+\(::\|\)\)\+\(\a\|\d\) /me=e-1 nextgroup=cpanIndexPkgVer


" hi link cpanIndexPkg Error
hi link cpanIndexPkg Type
hi link cpanIndexPkgVer Error


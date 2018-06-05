" Stolen^WLiberated from
" https://github.com/vim-scripts/imaps.vim/blob/master/plugin/imaps.vim

"-------------------------------------%<-------------------------------------
" this puts a the string "--------%<---------" above and below the visually
" selected block of lines. the length of the 'tearoff' string depends on the
" maximum string length in the selected range. this is an aesthetically more
" pleasing alternative instead of hardcoding a length.
"-------------------------------------%<-------------------------------------
function! rsrchboy#snip#Snip() range
	let i = a:firstline
	let maxlen = -2
	" find out the maximum virtual length of each line.
	while i <= a:lastline
		exe i
		let length = virtcol('$')
		let maxlen = (length > maxlen ? length : maxlen)
		let i = i + 1
	endwhile
	let maxlen = (maxlen > &tw && &tw != 0 ? &tw : maxlen)
	let half = repeat('-', maxlen/2-1)
	let line = printf(&cms, half.'%<'.half)
	call append(a:lastline, line)
	call append(a:firstline-1, line)
endfunction

fun! rsrchboy#snip#perlPkg() abort
    let l:pkg = substitute(expand("%:p:r"), '/', '::', 'g')

    " if it's a standard lib/ or site_perl/
    let l:pkg = substitute(l:pkg, '^.*::\(lib\|site_perl\)::', '', '')

    " if it's a ducttape symbiont, handle that as well
    let l:pkg = substitute(l:pkg, '^.*::autoload::', 'VIMx::autoload::', '')

    return l:pkg
endfun

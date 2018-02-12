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

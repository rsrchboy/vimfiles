if exists('b:did_gitrebase_after_ftplugin')
    finish
endif
let b:did_gitrebase_after_ftplugin = 1

" FIXME probably a better way to do this
let b:fugitive_rebase_commands='^(pick|reword|edit|squash|fixup|exec|drop)'

function! s:Swizzle(key, verb)
  silent! call repeat#set(','.a:key,-1)
  execute "normal :s/\\v\<c-r>=b:fugitive_rebase_commands\<cr>/".a:verb."/\<cr>:nohlsearch\<cr>"
endfunction

nnoremap <buffer> <localleader>d :call <SID>Swizzle('d',"drop")<cr>
nnoremap <buffer> <localleader>p :call <SID>Swizzle('p',"pick")<cr>
nnoremap <buffer> <localleader>r :call <SID>Swizzle('r',"reword")<cr>
nnoremap <buffer> <localleader>e :call <SID>Swizzle('e',"edit")<cr>
nnoremap <buffer> <localleader>s :call <SID>Swizzle('s',"squash")<cr>
nnoremap <buffer> <localleader>f :call <SID>Swizzle('f',"fixup")<cr>
nnoremap <buffer> <localleader>x :call <SID>Swizzle('x',"exec")<cr>

" nnoremap <buffer> <localleader>q :wq<cr>

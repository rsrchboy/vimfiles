if exists('b:did_gitrebase_after_ftplugin')
    finish
endif
let b:did_gitrebase_after_ftplugin = 1

" FIXME probably a better way to do this
let b:fugitive_rebase_commands='^(pick|reword|edit|squash|fixup|exec|drop)'

function! s:Swizzle(key, verb)
  silent! call repeat#set(a:key,-1)
  execute "normal :s/\\v\<c-r>=b:fugitive_rebase_commands\<cr>/".a:verb."/\<cr>:nohlsearch\<cr>"
endfunction

nnoremap <buffer> D :call <SID>Swizzle('D',"drop")<cr>
nnoremap <buffer> P :call <SID>Swizzle('P',"pick")<cr>
nnoremap <buffer> R :call <SID>Swizzle('R',"reword")<cr>
nnoremap <buffer> E :call <SID>Swizzle('E',"edit")<cr>
nnoremap <buffer> S :call <SID>Swizzle('S',"squash")<cr>
nnoremap <buffer> F :call <SID>Swizzle('F',"fixup")<cr>
nnoremap <buffer> X :call <SID>Swizzle('X',"exec")<cr>


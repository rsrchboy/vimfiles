" Write bufexplorer's t:bufexp_buf_list to the sessionfile!  (or try to)


" ooooorrrr.... use fugitive??


function! s:SaveTabInfo() abort


    " no point if we're not in a session
    if !len(v:this_session) || exists('SessionLoad') | return | endif

    let l:lines = []

    for l:page in gettabinfo()
        " PP gettabvar(s:page, 'bufexp_buf_list', [])
        " let l:x = s:pageinfo
        " PP l:x
        " PP s:pageinfo

        if has_key(l:page.variables, 'bufexp_buf_list')

            let l:bufs = '[' . join(l:page.variables.bufexp_buf_list, ',') . ']'

            let l:lines += [ 'call settabvar('. l:page.tabnr . ', ' . "'bufexp_buf_list', " . l:bufs . ')' ]
        endif
    endfor

    " bail if there's nothing to write
    if !len(l:lines) | return | endif

    " let l:body = readfile(g:this_obsession)
    " call insert(body, 'let g:this_session = v:this_session', -3)
    " call insert(body, 'let g:this_obsession = v:this_session', -3)
    " call insert(body, 'let g:this_obsession_status = 2', -3)
    " call writefile(body, g:this_obsession)

    let l:file = substitute(v:this_session, '\.vim$', 'x.vim', '')
    call writefile(l:lines, l:file)

    return
endfunction

function! Buf2Tab() abort
    let g:workdir2tab = {}
    " tabdo silent! g:workdir2tab{t:git_workdir} = tabpagenr() <bar> if !has_key(t:, 'bufexp_buf_list') <bar> let t:bufexp_buf_list = [] <bar> endif
    tabdo silent! g:workdir2tab{t:git_workdir} = tabpagenr() <bar> let t:bufexp_buf_list = []
    bufdo silent! let gettabinfo(g:workdir2tab[b:git_workdir]).variables.bufexp_buf_list += [ bufnr('') ]
endfunction

augroup buf2tab
  autocmd!

  " autocmd BufEnter,VimLeavePre * exe s:SaveTabInfo()
augroup END

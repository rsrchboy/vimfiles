" Write bufexplorer's t:bufexp_buf_list to the sessionfile!  (or try to)

fun! s:BufferTabList() abort
    " ... might not need this
endfun

function! s:SaveTabInfo() abort

    " no point if we're not in a session
    if !len(v:this_session) || exists('SessionLoad') | return | endif

    let l:lines = []

    for l:page in gettabinfo()

        if has_key(l:page.variables, 'bufexp_buf_list')

            let l:buf_names = copy(l:page.variables.bufexp_buf_list)
            call filter(l:buf_names, { k, v -> getbufvar(v, '&buftype') !=# 'nofile' })
            call filter(l:buf_names, { k, v -> buflisted(v)                          })
            call    map(l:buf_names, { k, v -> bufname(v)                            })
            call filter(l:buf_names, { k, v -> v !=# '[BufExplorer]'                 })

            let l:bufs = '[' . join(l:page.variables.bufexp_buf_list, ',') . ']'

                " \   'call settabvar('. l:page.tabnr . ', ' . "'bufexp_buf_list', " . l:bufs . ')',
                " \   'call settabvar('. l:page.tabnr . ', ' . "'RESTORED_bufexp_buf_list', " . l:bufs . ')',
                " \   'call settabvar('. l:page.tabnr . ', ' . "'RESTORED_bufexp_buf_names', ['" . join(l:buf_names, "', '") . "'])",
            let l:lines += [
                \   'call settabvar('. l:page.tabnr . ', ' . "'buf2tab_buf_names', ['" . join(l:buf_names, "', '") . "'])",
                \]

        endif
    endfor

    " bail if there's nothing to write
    if !len(l:lines) | return | endif

    " Store these away in a `Sessionx.vim` file
    let l:file = substitute(v:this_session, '\.vim$', 'x.vim', '')
    call writefile(l:lines, l:file)

    return
endfunction

function! MyRestoreTabBuffers() abort

    " we only want to do this once
    if has_key(g:, 'buf2tab_buffers_restored')
        return
    endif

    for l:page in gettabinfo()

        if !has_key(l:page.variables, 'buf2tab_buf_names') | continue | endif

        let l:names = copy(l:page.variables.buf2tab_buf_names)
        let l:bufs = []
        for l:name in l:names
            let l:bufs += [ bufnr(l:name) ]
        endfor

        let l:page.variables.bufexp_buf_list = l:bufs
    endfor

    let g:buf2tab_buffers_restored = 1
    return
endfunction

fun! s:SaveTabBuffers() abort

endfun

augroup buf2tab
  autocmd!

  " TODO should we have a User/Fugitive autocommand here to catch when buffers
  " are opened in tabs to which their git repos do not belong?  We'd probably
  " want to ignore anything not in a repo, which would not be an issue, and
  " to shift those buffers to a (new?) window inside the tab owning their
  " repo/worktree or creating a new tab.

  au TabLeave * silent! let g:buf2tab_previous_tabs_buffers = t:bufexp_buf_list

  autocmd User Obsession call s:SaveTabInfo()

  " this will be called against every loaded buffer -- but the function is a
  " no-op after the first call
  autocmd SessionLoadPost * call MyRestoreTabBuffers()
augroup END

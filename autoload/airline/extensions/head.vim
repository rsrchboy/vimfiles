" Title:  Airline extension to display HEAD's subject line
" Author: Chris Weyl <cweyl@alumni.drew.edu>

" parts cribbed heavily from airline's extensions/example.vim

" Due to some potential rendering issues, the use of the `space` variable is
" recommended.
let s:spc = g:airline_symbols.space

" First we define an init function that will be invoked from extensions.vim
function! airline#extensions#head#init(ext)

    " Here we define a new part for the plugin.  This allows users to place this
    " extension in arbitrary locations.
    call airline#parts#define_raw('head', '%{airline#extensions#head#get_head()}')

    " Next up we add a funcref so that we can run some code prior to the
    " statusline getting modifed.
    call a:ext.add_statusline_func('airline#extensions#head#apply')

    " You can also add a funcref for inactive statuslines.
    " call a:ext.add_inactive_statusline_func('airline#extensions#head#unapply')

    return
endfunction

" This function will be invoked just prior to the statusline getting modified.
function! airline#extensions#head#apply(...)
    " Let's say we want to append to section_c, first we check if there's
    " already a window-local override, and if not, create it off of the global
    " section_c.
    let w:airline_section_c = get(w:, 'airline_section_c', g:airline_section_c)

    " FIXME no separator needed if we don't have a status
    " Then we just append this extenion to it, optionally using separators.
    let w:airline_section_c .= g:airline_left_alt_sep.s:spc.'%{airline#extensions#head#status()}'

    " au's to force a re-read of the subject
    augroup airline#extensions#head
        au!

        autocmd CursorHold,FileChangedShellPost,ShellCmdPost,CmdwinLeave * unlet! b:airline_head_subject
        autocmd User FugitiveCommitFinishPre unlet! b:airline_head_subject
    augroup END
endfunction

" Finally, this function will be invoked from the statusline.
function! airline#extensions#head#status()

    if exists('b:airline_head_subject') | return b:airline_head_subject | endif

    if exists('b:git_dir')
        try
            let b:airline_head_subject = '{' . ducttape#git#head#subject() . '}'
        catch /^Vim\%((\a\+)\)\=:E117/
            let b:airline_head_subject = '{' . fugitive#repo().git_chomp('log', '-1', '--pretty=%s', '--no-show-signature') . '}'
        endtry
        return b:airline_head_subject
    else
        let b:airline_head_subject = ''
    endif

    return b:airline_head_subject
endfunction

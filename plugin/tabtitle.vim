scriptencoding utf-8

" function! MyTabLine()
"     let l:s = ''
"     let l:s .= '%#TabLine#'

"     let l:s .= '%<'
"     let l:s .= '%(%{fnamemodify(getcwd(), ":~")} %)'
"     if (exists('*fugitive#buffer'))
"         let l:s .= '%(⌥ %{exists("b:git_dir")?fugitive#head(7):""} %)'
"     endif
"     let l:s .= '%='
"     let l:s .= '%([%{tabpagenr("$") > 1 ? tabpagenr()."/".tabpagenr("$") : ""}]%)'

"     return l:s
" endfunction



function! MyTabLabel(n)

    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
    return fnamemodify(bufname(l:buflist[l:winnr - 1]), ':~')

    " let l:buflist = tabpagebuflist(a:n)
    " let l:winnr = tabpagewinnr(a:n)
    " return bufname(l:buflist[l:winnr - 1])

endfunction

function! MyTabLine()
    let l:s = ''
    for l:i in range(tabpagenr('$'))
        " select the highlighting
        let l:page = l:i + 1
        if l:page == tabpagenr()
            let l:s .= '%#TabLineSel#'
        else
            let l:s .= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let l:s .= '%' . l:page . 'T'

        " the label is made by MyTabLabel()
        let l:s .= ' %{gettabvar('.l:page.',"tab_page_title",MyTabLabel(' . l:page . '))} '
        " let l:s .= '%(%{fnamemodify(getcwd(), ":~")} %)'
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let l:s .= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let l:s .= '%=%#TabLine#%999Xclose'
    endif

    return l:s
endfunction

set tabline=%!MyTabLine()

function! TabPageTitle(git_dir)

    " let l:title = fnamemodify('

endfunction

function! MyPickTabPageTitleGit()
    if exists('t:git_dir')
        return
    endif

    let t:git_dir = b:git_dir
    let t:git_workdir = fugitive#repo().tree()
    let t:tab_page_title = '± ' . fnamemodify(b:git_dir, ':h:t')

    " echom "t:git_workdir == '" . t:git_workdir . "'"
    " echom "tweaked ==       '" . fnamemodify(t:git_dir, ':h') . "'"
    if t:git_workdir !=# fnamemodify(t:git_dir, ':h')
        let t:tab_page_title .= '('.fnamemodify(t:git_workdir, ':t').')'
    endif

endfunction

" transition
augroup hmmm
    au!
augroup END

augroup tabtitle
   au User Fugitive call MyPickTabPageTitleGit()
   au TabEnter * if !exists('t:tab_page_title') | let t:tab_page_title = 'No repository!' | endif
   au TabNew * if !exists('t:tab_page_title') | let t:tab_page_title = 'No repository!' | endif
   " au BufAdd *
augroup END

command! TabTitleReset silent! unlet t:git_dir | call MyPickTabPageTitleGit()

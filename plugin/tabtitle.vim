scriptencoding utf-8

if exists('g:loaded_tabtitle')
    finish
endif
let g:loaded_tabtitle = 1

fun! MyTabLabel(n) abort
    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
    return fnamemodify(bufname(l:buflist[l:winnr - 1]), ':~')

    " let l:buflist = tabpagebuflist(a:n)
    " let l:winnr = tabpagewinnr(a:n)
    " return bufname(l:buflist[l:winnr - 1])

endfun

fun! MyTabLine() abort
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
endfun

set tabline=%!MyTabLine()
set guitablabel=%!t:tab_page_title

fun! TabPageTitle(git_dir)

    " let l:title = fnamemodify('

endfun

fun! MyPickTabPageTitleGit()
    if exists('t:git_dir')
        return
    endif

    let t:git_dir = b:git_dir
    let t:git_commondir = b:git_commondir
    let t:git_workdir = fugitive#repo().tree()
    let t:tab_page_title = '± ' . fnamemodify(t:git_commondir, ':h:t')

    if has_key(t:, 'tab_page_subtitle')
        let t:tab_page_title .= '[' . t:tab_page_subtitle . ']'
    endif

    " echom "t:git_workdir == '" . t:git_workdir . "'"
    " echom "tweaked ==       '" . fnamemodify(t:git_dir, ':h') . "'"
    if t:git_workdir !=# fnamemodify(t:git_dir, ':h')
        let t:tab_page_title .= '('.fnamemodify(t:git_workdir, ':t').')'
    endif

    return
endfun

fun! MyResetTabTitle() abort
    silent! unlet t:tab_page_title t:git_dir t:git_commondir t:git_workdir
    call MyPickTabPageTitleGit()
    return
endfun

augroup tabtitle
    au!

    au User     Fugitive silent! call MyPickTabPageTitleGit()
    au TabEnter *        if !exists('t:tab_page_title') | let t:tab_page_title = 'No repository!' | endif
    au TabNew   *        if !exists('t:tab_page_title') | let t:tab_page_title = 'No repository!' | endif
    " au BufAdd * something magic that moves buffer to tab based on git workdir
augroup END

command! TabTitleReset silent! call MyResetTabTitle()

" __END__

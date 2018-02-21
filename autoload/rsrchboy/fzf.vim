" Functions supporting our use of fzf

fun! rsrchboy#fzf#FindOrOpenTab(work_dir) abort " {{{2

    " strictly speaking, this isn't really fzf-specific -- but it can live
    " here until we actually use it somewhere else
    "
    " Loop over our tabs, looking for one with a t:git_workdir matching our
    " a:workdir; if found, change tab; if not create a new one and attempt to
    " set the tab title correctly.

    for l:tab in (gettabinfo())
        if get(l:tab.variables, 'git_workdir', '') ==# a:work_dir
            exe 'tabn ' . l:tab.tabnr
            return
        endif
    endfor

    " try to find a suitable file for initial editing
    for l:wildcard in [ 'vimrc', 'dist.ini', 'README*', 'plugin/*.vim', 'lib/**/*.pm' ]
        let l:list = glob(a:work_dir . '/' . l:wildcard, 0, 1)
        for l:file in l:list
            if !filereadable(l:file) | continue | endif
            exe 'tabe ' . l:file
            redraw
            GFiles
            return
        endfor
    endfor

    " ...else just open up netrw
    exe 'tabe ' . a:work_dir
    exe 'lcd ' . a:work_dir
    let t:git_workdir = a:work_dir
    let t:git_dir = ducttape#git#path()
    let t:git_commondir = ducttape#git#commondir()
    " let b:git_workdir = a:work_dir
    " let b:git_dir = t:git_dir
    " let b:git_commondir = t:git_commondir
    unlet! t:tab_page_title
    call MyPickTabPageTitleGit()
    redraw
    GFiles
    return
endfun

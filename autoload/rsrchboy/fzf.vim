" Functions supporting our use of fzf

if has('perl')
    for s:eval in ducttape#symbiont#autoload(expand('<sfile>'))
        execute s:eval
    endfor
endif

fun! rsrchboy#fzf#FindOrOpenTab(work_dir) abort " {{{2

    " strictly speaking, this isn't really fzf-specific -- but it can live
    " here until we actually use it somewhere else
    "
    " loop over our tabs, looking for one with a t:git_workdir matching our
    " a:workdir; if found, change tab; if not fire up fzf again to find a file
    " to open in the new tab

    for l:tab in (gettabinfo())
        if get(l:tab.variables, 'git_workdir', '') ==# a:work_dir
            exe 'tabn ' . l:tab.tabnr
            return
        endif
    endfor

    call fzf#run(fzf#wrap('other-repo-git-ls', {
        \   'source': 'git ls-files',
        \   'dir': a:work_dir,
        \   'options': '--prompt "GitFiles in ' . a:work_dir . '> "',
        \   'sink': 'tabe ',
        \}, 0))

    " oddly, this seems necessary
    Glcd

    return
endfun

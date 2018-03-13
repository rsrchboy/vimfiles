" Functions supporting our use of fzf

for s:eval in ducttape#symbiont#autoload(expand('<sfile>'))
    execute s:eval
endfor

let g:rsrchboy#fzf#project_dirs = get(g:, 'rsrchboy#fzf#project_dirs',
\ '~/work ~/.vim ~/.tmux ~/.stow-dotfiles')

fun! rsrchboy#fzf#Projects(include_remote) abort

    let l:source = 'find ' . g:rsrchboy#fzf#project_dirs
    \ . ' -name .git -maxdepth 3 -printf "%h\n"'

    " e.g. :Projects!
    if a:include_remote
        let l:source = 'sh -c ''(' . l:source . '; cat ~/.vim/repos.txt)'''
    endif

    echom l:source
    call fzf#run(fzf#wrap('projects', {
    \   'source': l:source,
    \   'sink': function('rsrchboy#fzf#FindOrOpenTab'),
    \   'options': '-m --prompt "Projects> "',
    \}))

    return
endfun

fun! rsrchboy#fzf#FindOrOpenTab(work_dir) abort " {{{2

    " strictly speaking, this isn't really fzf-specific -- but it can live
    " here until we actually use it somewhere else
    "
    " loop over our tabs, looking for one with a t:git_workdir matching our
    " a:workdir; if found, change tab; if not fire up fzf again to find a file
    " to open in the new tab

    " TODO check to see if we've been handed a url to clone.
    "
    " ...or better yet, just make a different command?
    " ...or a ! variant?

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
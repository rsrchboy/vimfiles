" Functions supporting our use of fzf

for s:eval in ducttape#symbiont#autoload(expand('<sfile>'))
    execute s:eval
endfor

let g:rsrchboy#fzf#project_dirs = get(g:, 'rsrchboy#fzf#project_dirs',
\ '~/work ~/.vim ~/.tmux ~/.stow-dotfiles')

fun! rsrchboy#fzf#Projects(include_remote) abort " {{{1

    let l:source = 'find ' . g:rsrchboy#fzf#project_dirs
    \ . ' -name .git -maxdepth 3 -printf "%h\n"'
    let l:sink = 'rsrchboy#fzf#FindOrOpenTab'

    " e.g. :Projects!
    if a:include_remote
        let l:source = 'sh -c ''(' . l:source . '; cat ~/.vim/repos.txt)'''
        let l:sink = 'rsrchboy#fzf#MaybeClone'
    endif

    call fzf#run(fzf#wrap('projects', {
    \   'source': l:source,
    \   'sink': function(l:sink),
    \   'options': '-m --prompt "Projects> "',
    \}))

    return
endfun

fun! rsrchboy#fzf#MaybeClone(thing) abort " {{{1
    " ...
    if a:thing !~# '^https://.*'
        return rsrchboy#fzf#FindOrOpenTab(a:thing)
    endif

    let l:project = substitute(
                \ substitute(a:thing, '^.*/', '', ''),
                \ '\.git$', '', '',
                \)

    let l:target = $HOME . '/work/' . l:project

    echo 'Hang on, cloning ' . a:thing . ' to ' . l:target
    let l:out = system('git clone ' . a:thing . ' ' . l:target)

    call fzf#run(fzf#wrap('other-repo-git-ls', {
        \   'source': 'git ls-files',
        \   'dir': l:target,
        \   'options': '--prompt "GitFiles in ' . l:target . '> "',
        \   'sink': 'tabe ',
        \}, 0))

    return
endfun

fun! rsrchboy#fzf#FindOrOpenTab(work_dir) abort " {{{1

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
        \   'source': 'git ls-files --others --exclude-standard --cached',
        \   'dir': a:work_dir,
        \   'options': '--prompt "GitFiles in ' . a:work_dir . '> "',
        \   'sink': 'tabe ',
        \}, 0))

    " oddly, this seems necessary
    Glcd

    return
endfun

fun! rsrchboy#fzf#Tabs(bang) abort " {{{1
    let l:tabs_list = []

    for l:tab in (gettabinfo())
        let l:line = '[' . l:tab.tabnr . '] '
            \   . get(l:tab.variables, 'tab_page_title', '')
        let l:tabs_list += [ l:line ]
    endfor

    call fzf#run(fzf#wrap('tabs', {
        \   'source': l:tabs_list,
        \   'options': '--prompt "Tabs> "',
        \   'dir': '.',
        \   'sink': function('rsrchboy#fzf#HandleTabs'),
        \}, 0))

    return
endfun

fun! rsrchboy#fzf#HandleTabs(line) abort " {{{1

  let l:tabnr = matchstr(a:line, '\[\zs[0-9]*\ze\]')
  exe 'tabn ' . l:tabnr

  return
endfun

fun! rsrchboy#fzf#Issues() abort " {{{1

    call fzf#run(fzf#wrap('issues', {
        \   'source': 'hub -c color.ui=always -c color.interactive=always issues',
        \   'options': '--ansi --prompt "Issues> "',
        \   'dir': '.',
        \   'sink': function('rsrchboy#fzf#HandleTabs'),
        \}, 0))

    return
endfun

" vim: foldlevel=0 foldmethod=marker :

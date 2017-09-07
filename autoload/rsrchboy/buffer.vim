
""
"
" Call to set buffer-specific spell settings
function! rsrchboy#buffer#SetSpellOpts(filetype) abort
    let b:undo_ftplugin .= ' | setl spell< spellcapcheck< spellfile<'
    setlocal spell
    setlocal spelllang=en_us
    setlocal spellcapcheck=0
    execute 'setlocal spellfile+=~/.vim/spell/' . a:filetype . '.utf-8.add'
endfunction

function! s:set(k, v) abort
    let b:[a:k] = a:v
    let b:undo_ftplugin .= ' | unlet b:' . a:k
    return
endfunction


""
"
" vim-surround mappings for shell
"
" D -> [[ ... ]]

function! rsrchboy#buffer#shellSurrounds() abort

    " let b:surround_68 = "[[ \r ]]"
    call s:set('surround_68', "[[ \r ]]")
endfunction

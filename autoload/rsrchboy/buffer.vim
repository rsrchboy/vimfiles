
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


if !exists('b:undo_ftplugin')
    let b:undo_ftplugin = 'unlet b:undo_ftplugin'
endif

" Commands: {{{1
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin . ' | ' : '')
            \ . 'delc PerlTidy'
command! -buffer -range -nargs=* PerlTidy <line1>,<line2>!perltidy --profile=perltidyrc

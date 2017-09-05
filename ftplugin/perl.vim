" Perl Settings: we're OK with being overridden

" Commands: {{{1
let b:undo_ftplugin .= ' | delc PerlTidy MXRCize'
command! -buffer -range -nargs=* PerlTidy <line1>,<line2>! perltidy
command! -buffer -range -nargs=* MXRCize <line1>,<line2>perldo perldo return unless /$NS/; s/$NS([A-Za-z0-9:]+)/\$self->\l$1_class/; s/::(.)/__\l$1/g; s/([A-Z])/_\l$1/g


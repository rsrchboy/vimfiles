
let s:reminders = [
    \   '[ CTRL-D: Jump to the first definition (e.g. the sub foo for when on foo)',
    \   'Classes: w/W word (b/B, e/E), f/F char, t/T till',
    \   '\\w -> easy-motion: word (also: easymotion-default-mappings)',
    \   '\\W -> easy-motion: Word (...et al)',
    \   'gA -> align',
    \   'gX -> replace',
    \   'gs -> sort',
    \   'gS -> split (structures)',
    \   'gJ -> join (structures)',
    \   'gc -> comment',
    \   'ys, cs, ds -> add, change, delete surround (normal mode)',
    \   'S  -> surround (visual)',
    \   'cs -> change surround',
    \   'ds -> delete surround',
    \]

fun! rsrchboy#cheats#mappings() abort
    for l:line in s:reminders
        echo l:line
    endfor
endfun

" __END__


let s:reminders = [
            \   'gA -> align',
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

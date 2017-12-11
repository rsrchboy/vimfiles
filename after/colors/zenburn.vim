" Add signify coloring support
"
" Chris Weyl <cweyl@alumni.drew.edu> 2014

" zenburn: https://github.com/jnurmine/Zenburn
" signify: https://github.com/mhinz/vim-signify

" base changes
hi DiffAdd         cterm=bold ctermbg=none ctermfg=119 term=NONE guibg=Black guifg=LightGreen
hi DiffDelete      cterm=bold ctermbg=none ctermfg=167 term=NONE guibg=Black guifg=LightRed
hi DiffChange      cterm=bold ctermbg=none ctermfg=227 term=NONE guibg=Black guifg=Orange
hi diffAdded       cterm=none ctermbg=none ctermfg=119 term=NONE guibg=Black guifg=LightGreen
hi diffRemoved     cterm=none ctermbg=none ctermfg=167 term=NONE guibg=Black guifg=LightRed
" hi DiffChange      cterm=bold ctermbg=none ctermfg=227 gui=NONE guibg=Black guifg=Orange
hi Ignore                                                                   guifg=#303030
" hi NonText          term=bold ctermfg=238 gui=bold guifg=#404040
" hi NonText          guibg=Black
" au Syntax      * :hi SpecialKey ctermfg=darkgrey
hi SpecialKey        guibg=Black guifg=DarkGrey

" impacts the qf-style windows
hi Directory guifg=LightBlue

" vim-signify
hi SignifySignAdd    term=NONE cterm=NONE ctermfg=119 gui=NONE guibg=Black guifg=LightGreen
hi SignifySignDelete term=NONE cterm=NONE ctermfg=167 gui=NONE guibg=Black guifg=LightRed
hi SignifySignChange term=NONE cterm=NONE ctermfg=227 gui=NONE guibg=Black guifg=Orange

" vim-diminactive
hi ColorColumn guibg=#555555

hi Normal               guibg=Black ctermbg=none
hi SignColumn           guibg=Black ctermbg=none
hi LineNr               guibg=Black ctermbg=none
hi CursorLineNr         guibg=Black ctermbg=none
hi FoldColumn           guibg=Black ctermbg=none
hi Folded               guibg=Black ctermbg=none
hi TabLineFill          guibg=Black ctermbg=none guifg=Black
hi TabLine              guibg=Black ctermbg=none
hi TabLineSel           guibg=Black ctermbg=none

" __END__

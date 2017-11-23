" Add signify coloring support
"
" Chris Weyl <cweyl@alumni.drew.edu> 2014

" zenburn: https://github.com/jnurmine/Zenburn
" signify: https://github.com/mhinz/vim-signify

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
hi TabLineFill          guibg=Black ctermbg=none gitfg=Black
hi TabLine              guibg=Black ctermbg=none
hi TabLineSel           guibg=Black ctermbg=none

" __END__

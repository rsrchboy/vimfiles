" Add signify coloring support
"
" Chris Weyl <cweyl@alumni.drew.edu> 2014

" zenburn: https://github.com/jnurmine/Zenburn
" signify: https://github.com/mhinz/vim-signify

" TODO: submit as a PR/patch to Zenburn

hi SignColumn        ctermbg=233
hi SignifySignAdd    ctermbg=233   cterm=bold ctermfg=119
hi SignifySignDelete ctermbg=233   cterm=bold ctermfg=167
hi SignifySignChange ctermbg=233   cterm=bold ctermfg=227

if exists("g:zenburn_transparent") && g:zenburn_transparent

    " our tweaks, plus transparent overrides
    hi SignColumn        ctermbg=NONE
    hi SignifySignAdd    ctermbg=NONE
    hi SignifySignDelete ctermbg=NONE
    hi SignifySignChange ctermbg=NONE

    hi Normal     ctermbg=NONE
    hi FoldColumn ctermbg=NONE
    hi Folded     ctermbg=NONE
end

hi diffAdded   cterm=bold ctermfg=106
hi diffRemoved cterm=bold ctermfg=160

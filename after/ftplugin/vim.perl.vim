" a couple additional settings for vim.perl type buffers

" Only do this when not done yet for this buffer
if exists("b:did_local_vim_perl_ftplugin")
    finish
endif
let b:did_local_vim_perl_ftplugin = 1

" source these suckers.  This is pretty crude at the moment (FIXME), as
" they'll invoke *every* file w/a vim filetype, but...

neobundle#source('update_perl_line_directives')
neobundle#source('syntax_check_embedded_perl')

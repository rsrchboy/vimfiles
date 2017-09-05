" Additional setup for Perl files

" FIXME ...
" when working inside a CPAN-style dist, for instance.
set path<
let &l:path='.,,lib/,t/lib/,'.g:perlpath

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'


" Settings: {{{1

let b:undo_ftplugin .= ' | setlocal foldmethod< spell< spellcapcheck< spellfile<'
setlocal foldmethod=marker
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/perl.utf-8.add


" Plugins: Ale {{{1

augroup ftplugin#perl
    au!

    " au User Fugitive if &ft == 'perl' | let b:ale_perl_perl_options = '-I ' . fugitive#repo().tree() . '/lib'
    "         \       . ' -I ' . fugitive#repo().tree() . '/t/lib'
    "         \   | endif
augroup END

if exists('b:git_dir')
    let b:ale_perl_perl_options =
        \      '-I ' . fugitive#repo().tree() . '/lib'
        \   . ' -I ' . fugitive#repo().tree() . '/t/lib'
endif

" vim-pipe config
let b:undo_ftplugin .= ' | unlet b:vimpipe_filetype b:vimpipe_command'
let b:vimpipe_filetype = 'tapVerboseOutput'
let b:vimpipe_command  = 'source ~/perl5/perlbrew/etc/bashrc ; perl -I lib/ -'


" Plugins: Surround Mappings {{{1

" select current word to EOL (but not the newline), surround w/C
nmap <buffer> <localleader>sc :normal viW$hSC<CR>

" not really surround, but related...ish
nnoremap <buffer> <silent> <localleader>a. :s/\s*[.,;]*\s*$/./<cr>
nnoremap <buffer> <silent> <localleader>a, :s/\s*[.,;]*\s*$/,/<cr>
nnoremap <buffer> <silent> <localleader>a; :s/\s*[.,;]*\s*$/;/<cr>

" q ->     q{...}
" Q ->    qq{...}
" w ->   qw{ ... }
" W -> [ qw{ ... } ]
" , ->      '...',
" l ->     L<...>
" c ->     C<...>
" C ->   C<< ... >>
" b ->     B<...>
" # ->   #<<<...#>>>       <-- perltidy skip notation
" Y -> sub { ... };
" U ->   use ...;
let b:surround_113 = "q{\r}"
let b:surround_81  = "qq{\r}"
let b:surround_119 = "qw{ \r }"
let b:surround_87  = "[ qw{ \r } ]"
let b:surround_44  = "'\r',"
let b:surround_108 = "L<\r>"
let b:surround_98  = "B<\r>"
let b:surround_99  = "C<\r>"
let b:surround_67  = "C<< \r >>"
let b:surround_35  = "#<<<\r#>>>"
let b:surround_89  = "sub { \r };"
let b:surround_85  = "use \r;"

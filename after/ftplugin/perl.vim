" Additional setup for Perl files

" FIXME ...
" when working inside a CPAN-style dist, for instance.
setl path<
let &l:path='.,,lib/,t/lib/,'.g:perlpath

if exists('b:did_ftplugin_rsrchboy')
    finish
endif
let b:did_ftplugin_rsrchboy = 1
let b:undo_ftplugin .= ' | unlet b:did_ftplugin_rsrchboy'

let s:tools = g:rsrchboy#buffer#tools

" Settings: {{{1

call rsrchboy#buffer#SetSpellOpts('perl')

" Scratchpad for perhaps better settings(?)
"
" Search for defined 'macros' as functions or attributes; also look in roles.
"
setl define=^\\s*\\\(sub\\\|has\\\)\\>
setlocal include=^\\<\\\(use\\\|require\\\|with\\\|extends\\\)\\>

" setlocal includeexpr=substitute(substitute(substitute(v:fname,'::','/','g'),'->\*','',''),'$','.pm','')
" setlocal includeexpr=substitute(substitute(substitute(v:fname,'::','/','g'),'->\*','',''),'$','.pm','')
" setlocal includeexpr=substitute(substitute(substitute(substitute(v:fname,'::','/','g'),'->\*','',''),'$','.pm',''), "'", '', 'g')
" setlocal includeexpr=substitute(substitute(substitute(substitute(v:fname,'::','/','g'),'->\*','',''),'$','.pm',''), "'", '', 'g')


setlocal foldmethod=marker
let b:undo_ftplugin .= ' | setlocal foldmethod<'


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
let b:undo_ftplugin .= '| silent! unlet b:vimpipe_filetype b:vimpipe_command'
let b:vimpipe_filetype = 'tapVerboseOutput'
let b:vimpipe_command  = 'source ~/perl5/perlbrew/etc/bashrc ; perl -I lib/ -'


" Plugins: Surround Mappings {{{1


" Note below that the ':silent' postfix is necessary rather than a ':normal '
" prefix... because.
"
" select current word to EOL (but not the newline), surround w/C
" nmap <buffer> <localleader>sc :normal viW$hSC<CR>
call g:rsrchboy#buffer#tools.llnmap('sc', 'viW$hSC:silent ')

" not really surround, but related...ish
" call g:rsrchboy#buffer#tools.llnnoremap('a.', ':s/\s*[.,;]*\s*$/./')
call s:tools.llnnoremap('a.', ':s/\s*[.,;]*\s*$/./')
call s:tools.llnnoremap('a,', ':s/\s*[.,;]*\s*$/,/')
call s:tools.llnnoremap('a;', ':s/\s*[.,;]*\s*$/;/')
call s:tools.llnnoremap('ax', ':s/\s*[.,;]*\s*$//')

" append a ` ();`, a la 'NO IMPORTS PLZ'
call s:tools.llnnoremap('aX', ':s/\s*[.,;]*\s*$/ ();/')

call rsrchboy#buffer#CommonMappings()

" r ->    qr/.../
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
let b:surround_114 = "qr/\r/"
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

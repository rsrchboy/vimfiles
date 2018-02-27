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

call s:tools.setl('foldmethod', 'syntax')
call s:tools.setminus('fo', 'w')

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


" Formatting:

setl formatprg=perltidy

" Plugins: Ale {{{1

augroup ftplugin#perl " {{{2
    au!

    " au User Fugitive if &ft == 'perl' | let b:ale_perl_perl_options = '-I ' . fugitive#repo().tree() . '/lib'
    "         \       . ' -I ' . fugitive#repo().tree() . '/t/lib'
    "         \   | endif
augroup END

if exists('b:git_dir') " {{{2
    let b:ale_perl_perl_options =
        \      '-I ' . fugitive#repo().tree() . '/lib'
        \   . ' -I ' . fugitive#repo().tree() . '/t/lib'
endif

" vim-pipe config " {{{2
let b:undo_ftplugin .= '| silent! unlet b:vimpipe_filetype b:vimpipe_command'
let b:vimpipe_filetype = 'tapVerboseOutput'
let b:vimpipe_command  = 'source ~/perl5/perlbrew/etc/bashrc ; perl -I lib/ -'


" Section: tagbar {{{2

" " default
" let g:tagbar_type_perl = {
"     \ 'kinds' : [
"         \ 'p:packages:1:0',
"         \ 'u:uses:1:0',
"         \ 'A:aliases:0:0',
"         \ 'q:requires:1:0',
"         \ 'c:constants:0:0',
"         \ 'o:package globals:0:0',
"         \ 'R:readonly:0:0',
"         \ 'f:formats:0:0',
"         \ 'e:extends',
"         \ 'r:roles:1:0',
"         \ 'a:attributes',
"         \ 's:subroutines',
"         \ 'l:labels',
"         \ 'P:POD',
"         \ '?:unknown',
"     \ ],
" \ }

" " for comparison
" let g:tagbar_type_cpp = {
"     \ 'kinds' : [
"         \ 'd:macros:1:0',
"         \ 'p:prototypes:1:0',
"         \ 'g:enums',
"         \ 'e:enumerators:0:0',
"         \ 't:typedefs:0:0',
"         \ 'n:namespaces',
"         \ 'c:classes',
"         \ 's:structs',
"         \ 'u:unions',
"         \ 'f:functions',
"         \ 'm:members:0:0',
"         \ 'v:variables:0:0',
"         \ '?:unknown',
"     \ ],
" \ }

"    \ 'ctagsbin': 'perl-tags',
"    \ 'ctagsargs': '--outfile -',
        " \ 'p' : 'packages',
let b:tagbar_type = {
    \ 'sort' : 1,
    \ 'deffile' : '$HOME/.vim/ctags/perl',
    \ 'kinds' : [
        \ 'p:packages:1:0',
        \ 'u:uses:1:0',
        \ 'A:aliases:0:0',
        \ 'q:requires:1:0',
        \ 'c:constants:0:0',
        \ 'o:package globals:0:0',
        \ 'R:readonly:0:0',
        \ 'f:formats:0:0',
        \ 'e:extends',
        \ 'r:roles:1:0',
        \ 'a:attributes',
        \ 's:subroutines',
        \ 'm:Methods',
        \ 'l:labels',
        \ 'P:POD',
    \ ],
    \ 'sro' : '',
    \ 'kind2scope' : {
        \ 'p' : 'class',
    \ },
    \ 'scope2kind' : {
        \ 'packages' : 'p',
        \ 'subroutines' : 's',
    \ },
\ }

let b:undo_ftplugin .= ' | unlet b:tagbar_type'

" }}}2

" Plugins: Surround Mappings {{{1

" Surrounds: kinda {{{2

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

" Surrounds: {{{2

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
" @ ->    @{ ... }
" % ->    %{ ... }
" $ ->    ${ ... }
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
let b:surround_64  = "@{ \r }"
let b:surround_37  = "%{ \r }"
let b:surround_36  = "${ \r }"

" Plugin: endwise pairs {{{2

" Initial hackey things.  Close an if brace with a '}', close a bare brace
" with '},'.  Just playing around with this, for the moment.

let b:endwise_addition = '\=submatch(0)=="if" ? "}" : "},"'
" let b:endwise_addition = '\=submatch(0)=="{" ? "}," : "}"'
" let b:endwise_addition = '}'
let b:endwise_words = 'if,elsif,} elsif,else,{'
" let b:endwise_syngroups= 'perlConditional'
let b:endwise_syngroups= 'perlConditional,perlBraces'

" }}}2

" }}}1

" __END__

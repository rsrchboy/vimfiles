" Additional setup for perl files

" when working inside a CPAN-style dist, for instance.
set path<
let &l:path='.,,lib/,t/lib/,'.g:perlpath

if exists('b:ckw_perl_buf_setup')
    " no need to repeat ourselves
    finish
endif

" turn on spell-check for POD / comments
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/perl.utf-8.add

" vim-pipe config
let b:vimpipe_filetype = 'tapVerboseOutput'
let b:vimpipe_command  = 'source ~/perl5/perlbrew/etc/bashrc ; perl -I lib/ -'

" Surround Mappings:
"
" q ->     q{...}
" Q ->    qq{...}
" w ->   qw{ ... }
" W -> [ qw{ ... } ]
" , ->      '...',
" l ->     L<...>
" c ->     C<...>
" b ->     B<...>
let b:surround_113 = "q{\r}"
let b:surround_81  = "qq{\r}"
let b:surround_119 = "qw{ \r }"
let b:surround_87  = "[ qw{ \r } ]"
let b:surround_44  = "'\r',"
let b:surround_108 = "L<\r>"
let b:surround_98  = "B<\r>"
let b:surround_99  = "C<\r>"

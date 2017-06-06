" Additional setup for perl files

" when working inside a CPAN-style dist, for instance.
set path<
let &l:path=".,,lib/,t/lib/,".perlpath

if exists('b:ckw_perl_buf_setup')
    " no need to repeat ourselves
    finish
endif

au InsertEnter <buffer> setlocal spell
au InsertLeave <buffer> setlocal nospell

" turn on spell-check for POD / comments
" setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/perl.utf-8.add

" vim-pipe config
let b:vimpipe_filetype = "tapVerboseOutput"
let b:vimpipe_command  = "source ~/perl5/perlbrew/etc/bashrc ; perl -I lib/ -"

" vim-surround mappings

" q -> q{.}
" Q -> qq{.}
let b:surround_113 = "q{\r}"
let b:surround_81  = "qq{\r}"
" w -> qw{ . }
" W -> [ qw{ . } ]
let b:surround_119 = "qw{ \r }"
let b:surround_87  = "[ qw{ \r } ]"
" c -> '...',
" C -> "...",
let b:surround_99 = "'\r',"
let b:surround_67 = '"\r",'
" L -> L<...>
" etc
let b:surround_76 = 'L<\r>'
let b:surround_66 = 'B<\r>'
let b:surround_67 = 'C<\r>'

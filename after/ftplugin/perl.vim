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

" Ale Config:

" au User Fugitive if exists('b:git_dir') && &ft == 'perl' | let b:ale_perl_perl_options = '-I ' . fugitive#repo().tree() . '/lib'
"         \       . ' -I ' . fugitive#repo().tree() . '/t/lib'
"         \   | endif

if exists('b:git_dir')
    let b:ale_perl_perl_options =
        \      '-I ' . fugitive#repo().tree() . '/lib'
        \   . ' -I ' . fugitive#repo().tree() . '/t/lib'
endif

" select current word to EOL (but not the newline), surround w/C
nmap <buffer> <localleader>sc :normal viW$hSC<CR>

" vim-pipe config
let b:vimpipe_filetype = 'tapVerboseOutput'
let b:vimpipe_command  = 'source ~/perl5/perlbrew/etc/bashrc ; perl -I lib/ -'

" Surround Mappings:

" not really surround, but related
nnoremap <buffer> <localleader>ac :s/\s*$/,/<cr>
nnoremap <buffer> <localleader>as :s/\s*$/;/<cr>
nnoremap <buffer> <localleader>a, :s/\s*;\?\s*$/,/<cr>
nnoremap <buffer> <localleader>a; :s/\s*$/;/<cr>

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

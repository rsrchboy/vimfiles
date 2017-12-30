" drop external perlbrew from @INC and set our own
"
" Author:      Chris Weyl <cweyl@alumni.drew.edu>
" Maintainer:  Chris Weyl <cweyl@alumni.drew.edu>
" License:     LGPLv2.1+

if has('g:perlinc_loaded')
    finish
endif
let g:perlinc_loaded = 1

if !has('perl')
    finish
endif

perl <<EOP
# line 18 "~/.vim/plugin/00-perl-inc-correct.vim"

use v5.10;
use utf8;
use strict;
use warnings;

# be prepared to bootstrap w/our own local::lib in case one isn't installed
# on the system already
use lib "$ENV{HOME}/.vim/bootstrap/perl5/lib";
use local::lib "$ENV{HOME}/.vim/perl5";

BEGIN { @INC = grep { ! /perlbrew/ } @INC }

EOP

" vim: set ft=vim.perl :

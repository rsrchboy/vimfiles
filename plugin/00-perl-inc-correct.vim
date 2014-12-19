" drop external perlbrew from @INC and set our own
"
" Author:      Chris Weyl <cweyl@alumni.drew.edu>
" Maintainer:  Chris Weyl <cweyl@alumni.drew.edu>
" License:     LGPLv2.1+

" something arcane happens here.
let s:save_cpo = &cpo
set cpo&vim


if has('perl')

perl << EOP
# line 15 "~/.vim/plugin/00-perl-inc-correct.vim"

use v5.10;
use utf8;
use strict;
use warnings;

# be prepared to bootstrap w/our own local::lib in case one isn't installed
# on the system already
use lib "$ENV{HOME}/.vim/bootstrap/perl5/lib";
use local::lib "$ENV{HOME}/.vim/perl5";

BEGIN {
    delete $ENV{PERL5LIB};
    @INC = grep { ! /perlbrew/ } @INC;
}

EOP
endif

" something arcane happens here.
let &cpo = s:save_cpo

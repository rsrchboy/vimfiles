" Vim experimental plugin to see how Perl's fork() interacts with vim
"
" Author:      Chris Weyl <cweyl@alumni.drew.edu>
" Maintainer:  Chris Weyl <cweyl@alumni.drew.edu>
" License:     LGPLv2.1+

" something arcane happens here.
let s:save_cpo = &cpo
set cpo&vim

function! RunGitFixup()
  perl ForkAndGitFixup::do_fixup
endfunction

" Forking: implementation {{{1
if has('perl')
perl <<EOP
# line 19 "~/.vim/plugin/perl_fork.vim"

package ForkAndGitFixup;

use utf8;
use strict;
use warnings FATAL => 'all';
no warnings 'redefine';

use POSIX ':sys_wait_h';

sub do_fixup {

    local $SIG{CHLD} = 'IGNORE';

    if (my $pid = fork()) {
        VIM::Msg("forked to $pid to run 'git fixup'");
    }
    else {
        POSIX::setsid();
        exec  q{sh -c '(git fixup 2>&1 >/tmp/foo-x ; notify-send --icon emblem-ok-symbolic "git fixup" "`cat /tmp/foo-x`")'};
    }

    return;
}

EOP

else
  throw "Error: perl_fork.vim requires perl support to be compiled into vim!"
  finish
endif

" something arcane happens here.
let &cpo = s:save_cpo

" /* vim: set foldmethod=marker : */

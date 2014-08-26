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

use v5.10;

use utf8;
use strict;
use warnings FATAL => 'all';
no warnings 'redefine';

use POSIX ':sys_wait_h';

# TODO: use a real temp file
# TODO: use configurable icons
# TODO: use configurable gntp host/port

sub do_fixup {

    local $SIG{CHLD} = 'IGNORE';

    # TODO: embed these
    state $ok  = '/usr/share/icons/Neu/scalable/actions/gtk-add.svg';
    state $nok = '/usr/share/icons/Neu/scalable/actions/gtk-no.svg';

    if (my $pid = fork()) {
        VIM::Msg("forked to $pid to run 'git fixup'");
    }
    else {
        POSIX::setsid();
        #exec  q{sh -c '(_ico="error"; git fixup 2>&1 >/tmp/foo-x && _ico="dialog-ok" ;  notify-send --icon=$_ico "git fixup" "`cat /tmp/foo-x`")'};
        exec  qq{sh -c '(_ico="$nok"; git fixup 2>&1 >/tmp/foo-x && _ico="$ok" ; gntp-send -s 127.0.0.1:23053 "git fixup" "`cat /tmp/foo-x`" \$_ico)'};
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

" /* vim: set foldmethod=marker foldlevel=1 : */

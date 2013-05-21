" Vim experimental plugin to see how fork() interacts with vim
" Last Change: 2013
" Maintainer:  Chris Weyl <cweyl@alumni.drew.edu>
" License:     LGPLv2.1+

" vim:foldmethod=marker

" Starting Vim Module Boilerplate {{{1

" something arcane happens here.
let s:save_cpo = &cpo
set cpo&vim

" Implementation {{{1

function! RunGitFixup() "{{{2
  perl ForkAndGitFixup::do_fixup
endfunction

if has('perl')
perl <<EOP
# line 23 "~/.vim/plugin/perl_fork.vim"

package ForkAndGitFixup;

use strict;
use warnings FATAL => 'all';
use warnings NONFATAL => 'redefine';

sub do_fixup {

    if (my $pid = fork()) {
        VIM::Msg("forked to $pid to run 'git fixup'");
        return;
    }
    else {
        exec 'git fixup >/dev/null';
        #exec 'git fixup 2>&1 1>&x || notify-send "git fixup error" "`cat x | grep -v \'^\#\'`"';
    }

    return;
}

EOP

else
  throw "Error: perl_fork.vim requires perl support to be compiled into vim!"
  finish
endif

" Ending vim Module Boilerplate {{{1
let &cpo = s:save_cpo

" Remove any l perlbrew @INC entries not matching the system perl, and
" add our own extlib
"
" Maintainer: Chris Weyl <cweyl@alumni.drew.edu>

perl << EOF
    my $start = @INC;
    @INC = grep { ! /perlbrew/ } @INC;
    my $end = @INC;

    VIM::Msg("Started with $start, ended with $end \@INC entries");

    # add locallib
    eval qq{use local::lib "$ENV{HOME}/.vim/perl5"};

    VIM::Msg("added '$ENV{HOME}/.vim/perl5' via local::lib");
EOF

"function! EnsurePerlModule()
    "" check out scopes for function-scoped variables
    "perl << EOF
        "VIM::Msg("called with: @_");
"EOF
"endfunction


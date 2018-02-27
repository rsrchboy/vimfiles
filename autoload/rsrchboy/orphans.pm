package VIMx::autoload::rsrchboy::orphans;

use v5.10;
use strict;
use warnings;

use VIMx::Symbiont;

# debugging...
use Smart::Comments '###';

function args => q{}, print_orphan_buffers => sub {

    my %owned_buffers =
        map { $_ => 1 }
        map { @{ $_ // [] } }
        map { $_->vars->{bufexp_buf_list} }
        @TABS
        ;

    ### %owned_buffers
    # my @orphans = grep { not exists $owned_buffers{$_} } sort keys %BUFFERS;
    my @orphans = grep { not $owned_buffers{0+$_} } values %BUFFERS;

    ### @orphans
    print "$BUFFERS{$_}" for @orphans;

    return;
};

!!42;
__END__

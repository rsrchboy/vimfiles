package rsrchboy::www;

use v5.10;
use strict;
use warnings;

# debugging...
use Smart::Comments '###';

# use Vim::X 1.3.0_02;
# use VimX::Symbiont;
use VIMx::Symbiont;
use HTTP::Tiny;
# use JSON::Tiny qw{ decode_json encode_json };

# sub SimpleFetch :Vim(autoload args json) {
function SimpleFetch => sub {
    ### @_
    # my ($url, $json_args) = @_;
    # my $args = decode_json($json_args // '{}');
    my ($url, $args) = @_;

    my $ua = HTTP::Tiny->new(
        agent      => 'VimFetch ',
        verify_SSL => 1,
        %{ $args->{ua_opts} // {} },
    );

    # say $url;
    my $ret = $ua->get($url, $args->{req_opts} // {});

    # convenience: if we've been sent JSON, decode it
    do { $ret->{content} = decode_json($ret->{content}) }
        if $ret->{headers}->{'content-type'} =~ m!application/json!;

    # return encode_json($ret);
    return $ret;
};
# }

function HiThere => sub {

    print "Hi!";
    return;
};

!!42;
__END__

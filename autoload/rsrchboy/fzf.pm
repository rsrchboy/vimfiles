package VIMx::autoload::rsrchboy::fzf;

use v5.10;
use strict;
use warnings;

use VIMx::Symbiont;

use Data::Section::Simple 'get_data_section';
use HTTP::Tiny;
use Template::Tiny;

# debugging...
use Smart::Comments '###';

function args => q{}, get_repos_list => sub {
    ### @_
    # my ($method, $url, $args) = @_;

    my $ua = HTTP::Tiny->new(
        agent      => 'VimFetch ',
        verify_SSL => 1,
        # %{ $args->{ua_opts} // {} },
    );

    my $query = encode_json({ query => get_data_section('repos.gql') });

    ### $query
    my $ret = $ua->post('https://api.github.com/graphql' => {
        headers => {
            Authorization => "bearer $g{github_token}",
        },
        content => $query,
    });

    # convenience: if we've been sent JSON, decode it
    do { $ret->{content} = decode_json($ret->{content}) }
        if $ret->{headers}->{'content-type'} =~ m!application/json!;

    ### $ret
    return $ret;

};


!!42;
__DATA__
@@ repos.gql
query GetInterestingRepos {
  rateLimit {
    limit
    cost
    remaining
    resetAt
  }
  viewer {
    repositories(first: 2) {
      totalCount
      edges {
        node {
          id
          nameWithOwner
          url
          description
        }
        cursor
      }
      pageInfo {
        endCursor
        hasNextPage
      }
    }
    starredRepositories(first: 10) {
      totalCount
      edges {
        node {
          id
          nameWithOwner
          url
          description
        }
      }
    }
  }
}


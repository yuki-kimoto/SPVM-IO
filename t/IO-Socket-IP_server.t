use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::IP';
use SPVM 'TestUtil';

unless ($] >= 5.032000) {
  plan skip_all => 'This test is skipped because it needs Perl v.5.32.0+';
}

require Test::TCP;
require HTTP::Tiny;

require Mojolicious::Command::daemon;

my $server_ipv4 = Test::TCP->new(
  code => sub {
    my $port = shift;
    
    SPVM::TestUtil->run_echo_server($port);
    
    exit 0;
  },
);

# IPv4
{
  my $port = $server_ipv4->port;
  
  ok(1);
  
  # ok(SPVM::TestCase::IO::Socket::IP->server_ipv4_basic($port));
}

done_testing;

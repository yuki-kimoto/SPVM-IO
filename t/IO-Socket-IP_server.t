use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::IP';
use SPVM 'TestUtil';

use Test::TCP;
use HTTP::Tiny;

use Mojolicious::Command::daemon;

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
  
  ok(SPVM::TestCase::IO::Socket::IP->server_ipv4_basic($port));
}

done_testing;

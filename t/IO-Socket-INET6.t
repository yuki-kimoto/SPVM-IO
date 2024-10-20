use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::INET6';
use SPVM 'IO::Socket::INET6';

my $api = SPVM::api();

use Test::SPVM::Sys::Socket::ServerManager::IP;
use Test::SPVM::Sys::Socket::Server;

use SPVM 'Int';

{
  eval {
    my $socket = SPVM::IO::Socket::INET6->new(
      $api->new_options({
        LocalAddr => $api->new_string('::1'),
        Listen => SPVM::Int->new(1)
      })
    );
  };
  
  if ($api->get_exception) {
    plan skip_all => "IPv6 not available"
  }
}

my $server_manager = Test::SPVM::Sys::Socket::ServerManager::IP->new(
  code => sub {
    my ($server_manager) = @_;
    
    my $port = $server_manager->port;
    
    my $server = Test::SPVM::Sys::Socket::Server->new_echo_server_ipv6_tcp(port => $port);
    
    $server->start;
    
    exit 0;
  },
  host => '::1'
);

{
  my $port = $server_manager->port;
  ok(SPVM::TestCase::IO::Socket::INET6->basic($port));
}

done_testing;

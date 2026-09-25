use Test::More;

use strict;
use warnings;
use lib 't/lib';

use SPVM 'TestCase::IO::Socket::INET6';
use SPVM 'IO::Socket::INET6';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

use Test::SPVM::Sys::Socket::ServerManager::IP;
use Test::SPVM::Sys::Socket::Server;

use SPVM 'Int';

{
  my $socket = IO::Socket::IP->new(
    LocalAddr => '::1',
    Listen => 1
  );
  
  unless ($socket) {
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

$api->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

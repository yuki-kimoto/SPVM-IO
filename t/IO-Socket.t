use Test::More;

use strict;
use warnings;
use lib 't/lib';

use SPVM 'TestCase::IO::Socket';

use Test::SPVM::Sys::Socket::ServerManager::IP;
use Test::SPVM::Sys::Socket::Server;

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

my $server_manager = Test::SPVM::Sys::Socket::ServerManager::IP->new(
  code => sub {
    my ($server_manager) = @_;
    
    my $port = $server_manager->port;
    
    my $server = Test::SPVM::Sys::Socket::Server->new_echo_server_ipv4_tcp(port => $port);
    
    $server->start;
    
    exit 0;
  },
);

{
  my $port = $server_manager->port;
  
  ok(SPVM::TestCase::IO::Socket->set_blocking);
  
  ok(SPVM::TestCase::IO::Socket->fileno);
  
  ok(SPVM::TestCase::IO::Socket->shutdown);
  
  ok(SPVM::TestCase::IO::Socket->close);
  
  ok(SPVM::TestCase::IO::Socket->send_recv);
  
  ok(SPVM::TestCase::IO::Socket->extra);
  
  ok(SPVM::TestCase::IO::Socket->timeout);
  
  ok(SPVM::TestCase::IO::Socket->set_timeout);
  
  ok(SPVM::TestCase::IO::Socket->connected);
  
  ok(SPVM::TestCase::IO::Socket->atmark);
}

$api->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;


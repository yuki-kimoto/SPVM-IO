use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'Fn';
use SPVM 'TestCase::IO::Select';

use Test::SPVM::Sys::Socket::ServerManager::IP;
use Test::SPVM::Sys::Socket::Server;

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

my $server = Test::SPVM::Sys::Socket::ServerManager::IP->new(
  code => sub {
    my ($server_manager) = @_;
    
    my $port = $server_manager->port;
    
    my $server = Test::SPVM::Sys::Socket::Server->new_echo_server_ipv4_tcp(port => $port);
    
    $server->start;
    
    exit 0;
  },
);

{
  my $port = $server->port;
  
  ok(SPVM::TestCase::IO::Select->select_with_server($port));
}

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

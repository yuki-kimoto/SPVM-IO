use Test::More;

use strict;
use warnings;
use lib 't/lib';

use SPVM 'TestCase::IO::Socket::UNIX';

use Test::SPVM::Sys::Socket::ServerManager::IP;

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

my $port = Test::SPVM::Sys::Socket::Util::get_available_port();

use File::Temp ();
my $tmp_dir = File::Temp->newdir;
my $sock_path = "$tmp_dir/test.sock";

ok(SPVM::TestCase::IO::Socket::UNIX->new($sock_path));

ok(SPVM::TestCase::IO::Socket::UNIX->accept($sock_path));

$api->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

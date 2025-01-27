use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'Fn';
use SPVM 'TestCase::IO::Socket::UNIX';
use SPVM 'TestUtil';

use Test::SPVM::Sys::Socket::ServerManager::IP;

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

my $port = Test::SPVM::Sys::Socket::Util::get_available_port();

# my $sock_path = "$FindBin::Bin/test_files/test.sock";

use File::Temp ();
my $tmp_dir = File::Temp->newdir;
my $sock_path = "$tmp_dir/test.sock";

ok(SPVM::TestCase::IO::Socket::UNIX->new($sock_path));

ok(SPVM::TestCase::IO::Socket::UNIX->accept($sock_path));

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

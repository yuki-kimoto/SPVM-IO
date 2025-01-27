use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'Fn';
use SPVM 'TestCase::IO::Socket::IP';
use SPVM 'TestUtil';

use Test::SPVM::Sys::Socket::ServerManager::IP;

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

my $port = Test::SPVM::Sys::Socket::Util::get_available_port();

ok(SPVM::TestCase::IO::Socket::IP->accept($port));

ok(SPVM::TestCase::IO::Socket::IP->accept_timeout_only_field_value($port));

ok(SPVM::TestCase::IO::Socket::IP->accept_parallel($port));

ok(SPVM::TestCase::IO::Socket::IP->read_timeout($port));

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build" };

use SPVM 'Fn';
use SPVM 'TestCase::IO::Dir';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

ok(SPVM::TestCase::IO::Dir->new);

ok(SPVM::TestCase::IO::Dir->open);

ok(SPVM::TestCase::IO::Dir->read);

ok(SPVM::TestCase::IO::Dir->seek);

ok(SPVM::TestCase::IO::Dir->tell);

ok(SPVM::TestCase::IO::Dir->rewind);

ok(SPVM::TestCase::IO::Dir->close);

ok(SPVM::TestCase::IO::Dir->opened);

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

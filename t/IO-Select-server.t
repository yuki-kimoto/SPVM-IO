use Test::More;

use strict;
use warnings;
use lib 't/lib';

use SPVM 'TestCase::IO::Select';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

{
  ok(SPVM::TestCase::IO::Select->select_with_server);
}

$api->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

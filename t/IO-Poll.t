use Test::More;

use strict;
use warnings;
use lib 't/lib';

use SPVM 'TestCase::IO::Poll';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

ok(SPVM::TestCase::IO::Poll->new);
ok(SPVM::TestCase::IO::Poll->set_mask);
ok(SPVM::TestCase::IO::Poll->mask);
ok(SPVM::TestCase::IO::Poll->fds);
ok(SPVM::TestCase::IO::Poll->remove);

if ($^O ne 'MSWin32') {
  ok(SPVM::TestCase::IO::Poll->poll);
  ok(SPVM::TestCase::IO::Poll->events);
}

$api->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

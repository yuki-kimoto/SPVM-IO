use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build" };

use SPVM 'Fn';
use SPVM 'TestCase::IO::Select';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;


# Select
{
  ok(SPVM::TestCase::IO::Select->add);
  ok(SPVM::TestCase::IO::Select->remove);
  ok(SPVM::TestCase::IO::Select->exists);
  ok(SPVM::TestCase::IO::Select->add);
  ok(SPVM::TestCase::IO::Select->fds);
  ok(SPVM::TestCase::IO::Select->count);
  if ($^O ne 'MSWin32') {
    
    # TODO - failed
    # ok(SPVM::TestCase::IO::Select->can_read);
    
    ok(SPVM::TestCase::IO::Select->can_write);
    ok(SPVM::TestCase::IO::Select->has_exception);
  }
}

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

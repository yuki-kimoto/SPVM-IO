use Test::More;

use strict;
use warnings;
use lib 't/lib';

use SPVM 'TestCase::IO::Socket';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

{
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


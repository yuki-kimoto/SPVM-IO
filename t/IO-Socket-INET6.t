use Test::More;

use strict;
use warnings;
use lib 't/lib';

use IO::Socket::IP;

use SPVM 'TestCase::IO::Socket::INET6';
use SPVM 'IO::Socket::INET6';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

use SPVM 'Int';

{
  my $socket = IO::Socket::IP->new(
    LocalAddr => '::1',
    Listen => 1
  );
  
  unless ($socket) {
    plan skip_all => "IPv6 not available"
  }
}

{
  ok(SPVM::TestCase::IO::Socket::INET6->basic);
}

$api->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

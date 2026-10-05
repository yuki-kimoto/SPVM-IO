use Test::More;

use strict;
use warnings;
use lib 't/lib';

use IO::Socket::IP;

use SPVM 'TestCase::IO::Socket::INET6';
use SPVM 'TestCase::IO::Socket::IP';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

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
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_new);
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_peerport);
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_sockport);
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_peerhost);
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_sockhost);
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_peeraddr);
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_sockaddr);
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_extra);
  
}

$api->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;


use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::INET6';
use SPVM 'TestCase::IO::Socket::IP';

use Test::SPVM::Sys::Socket::ServerManager::IP;
use Test::SPVM::Sys::Socket::Server;

my $api = SPVM::api();

{
  my $socket = IO::Socket::IP->new(
    LocalAddr => '::1',
    Listen => 1
  );
  
  unless ($socket) {
    plan skip_all => "IPv6 not available"
  }
}

my $server_manager = Test::SPVM::Sys::Socket::ServerManager::IP->new(
  code => sub {
    my ($server_manager) = @_;
    
    my $port = $server_manager->port;
    
    my $server = Test::SPVM::Sys::Socket::Server->new_echo_server_ipv6_tcp(port => $port);
    
    $server->start;
    
    exit 0;
  },
  host => '::1'
);

{
  my $port = $server_manager->port;
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_new($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_peerport($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_sockport($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_peerhost($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_sockhost($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_peeraddr($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_sockaddr($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv6_extra($port));
  
}

done_testing;


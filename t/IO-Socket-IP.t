use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::IP';

use Test::SPVM::Sys::Socket::ServerManager::IP;
use Test::SPVM::Sys::Socket::Server;

my $server_manager = Test::SPVM::Sys::Socket::ServerManager::IP->new(
  code => sub {
    my ($server_manager) = @_;
    
    my $port = $server_manager->port;
    
    my $server = Test::SPVM::Sys::Socket::Server->new_echo_server_ipv4_tcp(port => $port);
    
    $server->start;
    
    exit 0;
  },
);

# IPv4
{
  my $port = $server_manager->port;
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_basic($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_goroutine($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_fileno($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_peerport($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_sockport($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_peerhost($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_sockhost($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_sockaddr($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_peeraddr($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_sockaddr($port));
}

done_testing;


use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket';

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

{
  my $port = $server_manager->port;
  
  ok(SPVM::TestCase::IO::Socket->set_blocking($port));
  
  ok(SPVM::TestCase::IO::Socket->fileno($port));
  
  ok(SPVM::TestCase::IO::Socket->shutdown($port));
  
  ok(SPVM::TestCase::IO::Socket->close($port));
  
  ok(SPVM::TestCase::IO::Socket->send_recv($port));
  
  ok(SPVM::TestCase::IO::Socket->goroutine($port));
  
  ok(SPVM::TestCase::IO::Socket->extra($port));
  
  ok(SPVM::TestCase::IO::Socket->timeout($port));
  
  ok(SPVM::TestCase::IO::Socket->set_timeout($port));
  
}

done_testing;


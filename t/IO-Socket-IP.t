use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::IP';

use Test::SPVM::Sys::Socket::ServerManager::IP;

use HTTP::Tiny;

use Mojolicious::Command::daemon;

my $server_ipv4 = Test::SPVM::Sys::Socket::ServerManager::IP->new(
  code => sub {
    my ($server_manager) = @_;
    
    my $port = $server_manager->port;
    
    my $app = Mojo::Server->new->load_app('t/webapp/basic.pl');
    
    my $daemon_command = Mojolicious::Command::daemon->new(app => $app);
    
    my @args = ("--listen", "http://*:$port");
    $daemon_command->run(@args);
    
    exit 0;
  },
);

# IPv4
{
  my $port = $server_ipv4->port;
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_basic($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_set_blocking($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_fileno($port));
  
  ok(SPVM::TestCase::IO::Socket::IP->ipv4_goroutine($port));
}

done_testing;


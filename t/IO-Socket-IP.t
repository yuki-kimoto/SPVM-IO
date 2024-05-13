use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::IP';

unless ($] >= 5.032000) {
  plan skip_all => 'This test is skipped because it needs Perl v.5.32.0+';
}

require Test::TCP;
require HTTP::Tiny;

require Mojolicious::Command::daemon;

my $server_ipv4 = Test::TCP->new(
  code => sub {
    my $port = shift;
    
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

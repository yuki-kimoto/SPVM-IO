use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Poll';

use Test::TCP;
use HTTP::Tiny;

use Mojolicious::Command::daemon;

my $server = Test::TCP->new(
  code => sub {
    my $port = shift;
    
    my $app = Mojo::Server->new->load_app('t/webapp/basic.pl');
    
    my $daemon_command = Mojolicious::Command::daemon->new(app => $app);
    
    my @args = ("--listen", "http://*:$port");
    $daemon_command->run(@args);
    
    exit 0;
  },
);

{
  my $port = $server->port;
  
  ok(SPVM::TestCase::IO::Poll->poll_with_server($port));
}

done_testing;

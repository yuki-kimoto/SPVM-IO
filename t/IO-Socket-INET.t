use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::INET';

unless ($] >= 5.032000) {
  plan skip_all => 'This test is skipped because it needs Perl v.5.32.0+';
}

require Test::TCP;
require HTTP::Tiny;

require Mojolicious::Command::daemon;

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

my $port = $server->port;

ok(SPVM::TestCase::IO::Socket::INET->basic($port));

ok(SPVM::TestCase::IO::Socket::INET->set_blocking($port));

ok(SPVM::TestCase::IO::Socket::INET->fileno($port));

ok(SPVM::TestCase::IO::Socket::INET->goroutine($port));

done_testing;
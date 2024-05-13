use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::INET6';

unless ($] >= 5.032000) {
  plan skip_all => 'This test is skipped because it needs Perl v.5.32.0+';
}

require Net::EmptyPort;
require Test::TCP;

unless (Net::EmptyPort::can_bind('::1')) {
  plan skip_all => "IPv6 not available"
}

require HTTP::Tiny;

require Mojolicious::Command::daemon;

my $server = Test::TCP->new(
  code => sub {
    my $port = shift;
    
    my $app = Mojo::Server->new->load_app('t/webapp/basic.pl');
    
    my $daemon_command = Mojolicious::Command::daemon->new(app => $app);
    
    my @args = ("--listen", "http://[::1]:$port");
    $daemon_command->run(@args);
    
    exit 0;
  },
  host => '::1',
);

my $port = $server->port;

ok(SPVM::TestCase::IO::Socket::INET6->basic($port));

ok(SPVM::TestCase::IO::Socket::INET6->set_blocking($port));

ok(SPVM::TestCase::IO::Socket::INET6->fileno($port));

ok(SPVM::TestCase::IO::Socket::INET6->goroutine($port));

done_testing;

use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'IO::Socket';

unless ($] >= 5.032000) {
  plan skip_all => 'This test is skipped because it needs Perl v.5.32.0+';
}

use Test::SPVM::Sys::Socket::ServerManager::IP;
require HTTP::Tiny;

require Mojolicious::Command::daemon;

my $server = Test::SPVM::Sys::Socket::ServerManager::IP->new(
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

my $http = HTTP::Tiny->new;

my $port = $server->port;

my $res = $http->get("http://127.0.0.1:$port/hello");

like($res->{content}, qr|Hello|);

done_testing;

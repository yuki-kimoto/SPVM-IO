use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use Test::TCP;
use HTTP::Tiny;

my $server = Test::TCP->new(
  code => sub {
    my $port = shift;
    
    # Throw way stdout and stderr
    # If not, "make test" (Test::Harness->runtests) waits forever,
    my $cmd = "$^X t/webapp/basic.pl daemon --listen http://*:$port >/dev/null 2>&1";
    
    warn "[Test Output]Server port:$port";
    
    exec($cmd);
    
    die "exec failed.";
  },
);


my $http = HTTP::Tiny->new;

my $port = $server->port;

my $res = $http->get("http://localhost:$port/hello");

like($res->{content}, qr|Hello|);

done_testing;

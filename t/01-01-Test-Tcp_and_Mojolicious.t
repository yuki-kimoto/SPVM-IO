use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

unless ($] >= 5.032000) {
  plan skip_all => 'This test is skipped because it needs Perl v.5.32.0+';
}

require Test::TCP;
require HTTP::Tiny;

my $server = Test::TCP->new(
  code => sub {
    my $port = shift;
    
    # Throw way stdout and stderr
    # If not, "make test" (Test::Harness->runtests) waits forever.
    my $devnull = File::Spec::Win32->devnull();
    
    my $cmd = "$^X t/webapp/basic.pl daemon --listen http://*:$port >$devnull 2>&1";
    
    warn "[Test Output]Server Running Command:$cmd";
    
    system($cmd) == 0
      or die "The command \"$cmd\" failed.";
  },
);


my $http = HTTP::Tiny->new;

my $port = $server->port;

my $res = $http->get("http://localhost:$port/hello");

like($res->{content}, qr|Hello|);

done_testing;

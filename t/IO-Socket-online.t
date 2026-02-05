use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'Fn';
use SPVM 'TestCase::IO::Socket::Online';

my $api = SPVM::api();

# Check network connectivity to httpbin.org using Perl's HTTP::Tiny
use HTTP::Tiny;
my $res = HTTP::Tiny->new(timeout => 5)->get("http://httpbin.org/get");
unless ($res->{success}) {
  plan skip_all => "No internet connection or httpbin.org is down (verified by Perl's HTTP::Tiny)";
}

my $start_memory_blocks_count = $api->get_memory_blocks_count;

subtest 'Standard I/O tests' => sub {
    ok(SPVM::TestCase::IO::Socket::Online->inet, "inet");
    ok(SPVM::TestCase::IO::Socket::Online->basic, "basic");
    ok(SPVM::TestCase::IO::Socket::Online->basic_interface, "basic_interface");
    ok(SPVM::TestCase::IO::Socket::Online->basic_auto_close, "basic_auto_close");
};

subtest 'Socket features' => sub {
    ok(SPVM::TestCase::IO::Socket::Online->blocking, "blocking / non-blocking toggle");
    ok(SPVM::TestCase::IO::Socket::Online->fileno, "fileno validation");
};

subtest 'Concurrency' => sub {
    ok(SPVM::TestCase::IO::Socket::Online->goroutine, "goroutine with concurrent I/O");
};

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

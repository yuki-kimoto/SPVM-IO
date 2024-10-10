use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::IO::Socket::IP';
use SPVM 'TestUtil';

use Test::SPVM::Sys::Socket::ServerManager::IP;

my $port = Test::SPVM::Sys::Socket::Util::get_available_port();

ok(SPVM::TestCase::IO::Socket::IP->accept($port));

done_testing;

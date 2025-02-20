use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build" };

use SPVM 'Fn';
use SPVM::IO;
use SPVM 'IO';

use SPVM 'TestCase::IO';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

# Version
{
  is($SPVM::IO::VERSION, SPVM::Fn->get_version_string('IO'));
}

my $test_dir = "$FindBin::Bin";

# open
{
  ok(SPVM::TestCase::IO->open("$test_dir/test_files_tmp/fread.txt"));
}

# opendir
{
  ok(SPVM::TestCase::IO->opendir);
}

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

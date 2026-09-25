use Test::More;

use strict;
use warnings;
use lib 't/lib';

use SPVM::IO;
use SPVM 'IO';

use SPVM 'TestCase::IO';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

{
  is($SPVM::IO::VERSION, $api->get_version_string('IO'));
}

ok(SPVM::TestCase::IO->open("t/.tmp/test_files_tmp/fread.txt"));
ok(SPVM::TestCase::IO->opendir);

$api->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

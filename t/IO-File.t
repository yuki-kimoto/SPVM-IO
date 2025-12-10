use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build" };

use SPVM 'Fn';
use SPVM 'TestCase::IO::File';

use TestFile;

sub slurp_binmode {
  my ($output_file) = @_;
  
  open my $fh, '<', $output_file
    or die "Can't open file $output_file:$!";
  
  binmode $fh;
  
  my $output = do { local $/; <$fh> };
  
  return $output;
}

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

# Copy test_files to test_files_tmp with replacing os newline
TestFile::copy_test_files_tmp();

my $test_dir = "$FindBin::Bin";

my $TEST_TMP_DIR = "$test_dir/test_files_tmp";

SPVM::TestCase::IO::File->SET_TEST_DIR($test_dir);

SPVM::TestCase::IO::File->SET_TEST_TMP_DIR($TEST_TMP_DIR);

ok(SPVM::TestCase::IO::File->flush);
ok(SPVM::TestCase::IO::File->close);

# print
{
  ok(SPVM::TestCase::IO::File->print);
  ok(SPVM::TestCase::IO::File->print_newline);
  ok(SPVM::TestCase::IO::File->print_long_lines);
}

ok(SPVM::TestCase::IO::File->syswrite);
ok(SPVM::TestCase::IO::File->say);
ok(SPVM::TestCase::IO::File->printf);
ok(SPVM::TestCase::IO::File->autoflush);
ok(SPVM::TestCase::IO::File->write);
{
  ok(SPVM::TestCase::IO::File->open);
  ok(SPVM::TestCase::IO::File->open_with_int_mode);
}

ok(SPVM::TestCase::IO::File->read);
ok(SPVM::TestCase::IO::File->sysread);

# getline
{
  ok(SPVM::TestCase::IO::File->getline);
  ok(SPVM::TestCase::IO::File->getline_while);
  ok(SPVM::TestCase::IO::File->getline_eof);
  ok(SPVM::TestCase::IO::File->getline_long_line);
}

# getline and chompr
{
  ok(SPVM::TestCase::IO::File->getline_chompr);
  ok(SPVM::TestCase::IO::File->getline_chompr_while);
  ok(SPVM::TestCase::IO::File->getline_chompr_eof);
  ok(SPVM::TestCase::IO::File->getline_chompr_long_line);
}

ok(SPVM::TestCase::IO::File->getlines);
ok(SPVM::TestCase::IO::File->read_and_seek);

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

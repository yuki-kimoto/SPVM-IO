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

# flush
{
  ok(SPVM::TestCase::IO::File->flush);
}

# close
{
  {
    ok(SPVM::TestCase::IO::File->close);
  }
}

# print
{
  {
    ok(SPVM::TestCase::IO::File->print);
  }

  {
    ok(SPVM::TestCase::IO::File->print_newline);
  }

  {
    my $file = "$TEST_TMP_DIR/io_file_test_print_long_lines.txt";
    ok(SPVM::TestCase::IO::File->print_long_lines($file));
    my $output = slurp_binmode($file);
    is($output, "AAAAAAAAAAAAA\x0ABBBBBBBBBBBBBBBBBBB\x0ACCCCCCCCCCCCCCCCCCCCCCCCCCC\x0ADDDDDDDDDDDDDDDDDDDDDDDDD\x0AEEEEEEEEEEEEEEEEEEEEEE\x0AFFFFFFFFFFFFFF\x0A");
  }
}

# autoflush
{
  {
    my $file = "$TEST_TMP_DIR/io_file_test_print.txt";
    ok(SPVM::TestCase::IO::File->autoflush($file));
    my $output = slurp_binmode($file);
    is($output, 'Hello');
  }
}

# write
{
  {
    my $file = "$TEST_TMP_DIR/io_file_test_write.txt";
    ok(SPVM::TestCase::IO::File->write($file));
    my $output = slurp_binmode($file);
    is($output, 'Hello');
  }
}

# open
{
  my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/fread.txt");
  ok(SPVM::TestCase::IO::File->open($sp_file));
}

# read
{
  my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/fread.txt");
  ok(SPVM::TestCase::IO::File->read($sp_file));
}

# getline
{
  {
    my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/fread.txt");
    ok(SPVM::TestCase::IO::File->getline($sp_file));
  }
  {
    my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/fread.txt");
    ok(SPVM::TestCase::IO::File->getline_while($sp_file));
  }
  {
    my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/file_eof.txt");
    ok(SPVM::TestCase::IO::File->getline_eof($sp_file));
  }
  {
    my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/long_line.txt");
    ok(SPVM::TestCase::IO::File->getline_long_line($sp_file));
  }
}

# getline and chompr
{
  {
    my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/fread.txt");
    ok(SPVM::TestCase::IO::File->getline_chompr($sp_file));
  }
  {
    my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/fread.txt");
    ok(SPVM::TestCase::IO::File->getline_chompr_while($sp_file));
  }
  {
    my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/file_eof.txt");
    ok(SPVM::TestCase::IO::File->getline_chompr_eof($sp_file));
  }
  {
    my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/long_line.txt");
    ok(SPVM::TestCase::IO::File->getline_chompr_long_line($sp_file));
  }
}

# getlines
{
  my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/fread.txt");
  ok(SPVM::TestCase::IO::File->getlines($sp_file));
}

# read,seek
{
  my $sp_file = SPVM::api->new_string("$TEST_TMP_DIR/fread.txt");
  ok(SPVM::TestCase::IO::File->read_and_seek($sp_file));
}

SPVM::Fn->destroy_runtime_permanent_vars;

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;

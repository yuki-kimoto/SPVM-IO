package SPVM::IO::File;

1;

=head1 Name

SPVM::IO::File - File Input/Output

=head1 Usage
  
  use IO::File;
  
  my $io_file = IO::File->new("foo.txt", ">");
  $io_file->print("Hello");>

=head1 Description

IO::File class has methods for File IO.

=head1 Super Class

L<IO::Handle|SPVM::IO::Handle>.

=head1 Fields

=head2 FileStream

C<has FileStream : Sys::IO::FileStream;>

A file stream associated with the file descriptoer L<FD|SPVM::IO::Handle/"FD">.

=head2 InputLineNumber

C<has InputLineNumber : long;>

The current line number. This value is incremented by L</"getline"> method.

=head1 Class Methods

=head2 new

C<static method new : IO::File ($file_name : string = undef, $open_mode : string = undef);>

=head2 new_from_fd

C<static method new_from_fd : IO::Handle ($fd : int, $open_mode : string);>

=head2 open

C<method open : void ($file_name : string, $open_mode : string);>

=head2 fdopen

C<method fdopen : void ($fd : int, $open_mode : string);>

=head1 Instance Methods

=head2 input_line_number

C<method input_line_number : long ();>

Returns the value of L</"InputLineNumber> field.

=head2 set_input_line_number

C<method set_input_line_number : void ($input_line_number : long);>

Sets L</"InputLineNumber> field to $input_line_number.

=head2 close

C<method close : void;>

Closes the file stream L</"FileStream">, and sets L<FD|SPVM::IO::Handle/"FD"> to -1.

=head2 read

C<method read : int ($string : mutable string, $length : int = -1, $offset : int = 0);>

=head2 write

C<method write : int ($string : string, $length : int = -1, $offset : int = 0);>

=head2 getline

C<method getline : string ();>

Reads a line from the file stream L</"FileStream">, incrementes the input line number L</"InputLineNumber"> by 1, and returns it.

=head2 getlines

C<method getlines : string ();>

Reads all lines from the file stream L</"FileStream">, joins them to a string, and returns it.

This method calls L</"getline"> method repeatedly.

=head2 getc

C<method getc : int ();>

=head2 print

C<method print : int ($string : string);>

=head2 printflush

C<method printflush : void ($string : string);>

=head2 clearerr

C<method clearerr : void ();>

=head2 error

C<method error : int ();>

=head2 flush

C<method flush : void ();>

=head2 ungetc

C<method ungetc : int ($c : int);>

=head2 eof

C<method eof : int ();>

If the file stream L</"FileStream"> reaches the end of file, returns 1. Otherwise, returns 0.

This method calls L<Sys::IO#feof|SPVM::Sys::IO/"feof"> method with the file stream L</"FileStream">.

=head2 error

C<method error : int ();>

If the file stream L</"FileStream"> has a error status, returns 1. Otherwise, returns 0.

This method calls L<Sys::IO#ferror|SPVM::Sys::IO/"ferror"> method with the file stream L</"FileStream">.

=head2 clearerr

C<method clearerr : void ();>

Clears the error satus of the file stream L</"FileStream">.

This method calls L<Sys::IO#clearerr|SPVM::Sys::IO/"clearerr"> method with the file stream L</"FileStream">.

=head2 getc

C<method getc : int ();>

Reads a character from the file stream L</"FileStream">, and returns it.

This method calls L<Sys#getc|SPVM::Sys/"getc"> method with the file stream L</"FileStream">.

=head2 sync

C<method sync : void ();>

Syncs the stream associated with the file descriptoer L<FD|SPVM::IO::Handle/"FD">.

This method calls L<Sys#fsync|SPVM::Sys/"fsync"> method with the file descriptor L<FD|SPVM::IO::Handle/"FD">.

=head2 truncate

C<method truncate : void ($legnth : long);>

Trancates the stream associated with the file descriptoer L<FD|SPVM::IO::Handle/"FD">.

This method calls L<Sys#ftruncate|SPVM::Sys/"ftruncate"> method with the file descriptor L<FD|SPVM::IO::Handle/"FD">.

=head1 See Also

=head2 Perl's IO::File

C<IO::File> is a Perl's L<IO::File|IO::File> porting to L<SPVM>.

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


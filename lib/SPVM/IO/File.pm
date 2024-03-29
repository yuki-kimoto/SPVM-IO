package SPVM::IO::File;

1;

=head1 Name

SPVM::IO::File - File Input/Output

=head1 Usage
  
  use IO::File;
   
  my $io_file = IO::File->new("file", "r");
  $io_file->print("Hello");

=head1 Description

L<SPVM::IO::File> provides File Input/Output.

=head1 Parent Class

L<IO::Handle|SPVM::IO::Handle>.

=head1 Fields

=head2 stream

  has stream : Sys::IO::FileStream;

=head2 input_line_number

  has input_line_number : long;

=head1 Class Methods

=head2 new

  static method new : IO::File ($file_name : string = undef, $open_mode : string = undef);

=head2 new_from_fd

  static method new_from_fd : IO::Handle ($fd : int, $open_mode : string = undef);

=head1 Instance Methods

=head2 input_line_number

  method input_line_number : long ();

Gets L</"input_line_number> field.

=head2 set_input_line_number

  method set_input_line_number : void ($input_line_number : long);

Sets L</"input_line_number> field.

=head2 open

  method open : void ($file_name : string, $open_mode : string);

=head2 fdopen

  method fdopen : void ($fd : int, $open_mode : string);

=head2 init

  protected method init : void ();

=head2 DESTROY

  method DESTROY : void ();

=head2 getline

  method getline : string ();

=head2 getlines

  method getlines : string ();

=head2 close

  method close : int ();

=head2 eof

  method eof : int ();

=head2 fileno

  method fileno : int ();

Gets the file descriptor of L</"stream"> field.

=head2 getc

  method getc : int ();

=head2 print

  method print : int ($string : string);

=head2 clearerr

  method clearerr : void ();

=head2 error

  method error : int ();

=head2 flush

  method flush : void ();

=head2 ungetc

  method ungetc : int ($c : int);

=head2 write

  method write : int ($string : string, $length : int = -1, $offset : int = 0);

=head2 read

  method read : int ($string : mutable string, $length : int = -1, $offset : int = 0);

=head2 printflush

  method printflush : void ($string : string);

=head2 getline

  method getline : string ();

=head2 getlines

  method getlines : string ();

=head2 ungetc

  method ungetc : int ($c : int);

=head2 clearerr

  method clearerr : void ();

=head2 error

  method error : int ();

=head2 getc

  method getc : int ();

=head2 eof

  method eof : int ();

=head1 See Also

=head2 Perl's IO::File

C<IO::File> is a Perl's L<IO::File|IO::File> porting to L<SPVM>.

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


package SPVM::IO::Handle;

1;

=head1 NAME

SPVM::IO::Handle - I/O Handling

=head1 Description

IO::Handle class in L<SPVM> has methods to handle file handles.

=head1 Usage
  
  use IO::Handle;
  my $handle = IO::Handle->new;
  $handle->set_autoflush(1);

=head1 Instance Methods

=head1 Fields

=head2 FD

  has FD : protected int;

A file descriptor.

=head2 AutoFlush

  has AutoFlush : protected byte;

=head2 Blocking

  has Blocking : protected byte;
  
=head1 Class methods

=head2 new

  static method new : IO::Handle ($options : object[]);

=head1 Instance Methods

=head2 init

  method init : void ($options : object[] = undef);

=head2 autoflush

  method autoflush : int ();

=head2 set_autoflush

  method set_autoflush : void ($autoflush : int);
  
=head2 opened

  method opened : int ();

If the return value of L</"fileno"> is greater than or equal to 0, returns 1. Otherwise returns 0.

=head2 fileno

  method fileno : int ();

Gets L</"FD"> field.

=head2 print

  method print : void ($string : string);

=head2 printf

  method printf : void ($format : string, $args : object[]...);

=head2 say

  method say : void ($string : string);

=head2 truncate

  method truncate : void ($legnth : long);

Truncates to a size of precisely length bytes.

This method is planed to be implemented in a child class.

This method always throws an exception.

=head2 ioctl

  static method ioctl : int ($fd : int, $request : int, $request_arg_ref : object of byte[]|short[]|int[]|long[]|float[]|double[]|object = undef);

=head2 sync

  method sync : void ();

=head2 stat

  method stat : Sys::IO::Stat ();

=head2 fcntl

  method fcntl : int ($command : int, $command_arg : object = undef of Int|Sys::IO::Flock|object);

=head2 set_blocking

  method set_blocking : void ($blocking : int);

=head2 syswrite

  method syswrite : int ($string : string, $length : int = -1, $offset : int = 0) {

=head2 sysread

  method sysread : int ($string : mutable string, $length : int = -1, $offset : int = 0) {

=head2 write

  method write : int ($string : string, $length : int = -1, $offset : int = 0);

Exceptions:

Not implemented.

=head2 read

  method read : int ($string : mutable string, $length : int = -1, $offset : int = 0);

Exceptions:

Not implemented.

=head2 close

  method close : int ();

Exceptions:

Not implemented.

=head1 Well Known Child Classes

=head2 IO::File

L<IO::File|SPVM::IO::File>

=head2 IO::Socket

L<IO::Socket|SPVM::IO::Socket>

=head2 IO::Socket::INET

L<IO::Socket::INET|SPVM::IO::Socket::INET>

=head1 See Also

=head2 IO::Handle

C<SPVM::IO::Handle> is the Perl's L<IO::Handle> porting to L<SPVM>.

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


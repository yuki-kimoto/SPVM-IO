package SPVM::IO::Handle;

1;

=head1 NAME

SPVM::IO::Handle - I/O Handling

=head1 Description

IO::Handle class in L<SPVM> has methods to handle file handles.

=head1 Usage
  
  use IO::Handle;
  my $handle = IO::Handle->new;

=head1 Details

This class is a Perl's L<IO::Handle> porting.

=head1 Instance Methods

=head1 Fields

=head2 FD

  has FD : protected int;

A file descriptor.

=head2 AutoFlush

  has AutoFlush : protected byte;

=head2 Blocking

  has Blocking : protected byte;

=head1 Class Methods

=head2 new

C<static method new : IO::Handle ($options : object[]);>

Options:

=over 2

=item * FD : Int

L</"FD"> field is set to this value.

=item * AutoFlush : Int

L</"AutoFlush"> field is set to this value.

=item * Blocking : Int

L</"Blocking"> field is set to this value.

If this value is 0, L</"set_blocking"> method is called with 0.

=back

=head1 Instance Methods

=head2 fileno

C<method fileno : int ();>

Returns the value of L</"FD"> field.

=head2 opened

C<method opened : int ();>

If L</"FD"> is greater than or equal to 0, returns 1. Otherwise returns 0.

=head2 autoflush

C<method autoflush : int ();>

Returns the value of L</"AutoFlush"> field.

=head2 set_autoflush

C<method set_autoflush : void ($autoflush : int);>

Sets L</"AutoFlush"> field to $autoflush.

=head1 blocking

C<method blocking : int ();>

Retruns the value of L</"Blocking"> field.

=head2 set_blocking

C<method set_blocking : void ($blocking : int);>

Sets L</"Blocking"> field to $blocking.

If $blocking is a false value, enables the non-blocking mode of the file descriptor L</"FD">.

If $blocking is a true value, disables the non-blocking mode of the file descriptor L</"FD">.

=head2 print

C<method print : void ($string : string);>

Outputs the string $string to the stream associated with the file descriptoer L</"FD">.

Same as the following method call.

  $handle->write($string);

=head2 printf

C<method printf : void ($format : string, $args : object[]...);>

Outputs a string fomatted with the format $format and its parameters $args to the stream associated with the file descriptoer L</"FD">.

Same as the following method call.

  my $formated_string = Format->sprintf($format, $args);
  $handle->print($formated_string);

=head2 say

C<method say : void ($string : string);>

Outputs the string $string and C<\n> to the stream associated with the file descriptoer L</"FD">.

Same as the following method call.

  $handle->print($string);
  $handle->print("\n");

=head2 truncate

C<method truncate : void ($legnth : long);>

Calls L<Sys#truncate|SPVM::Sys/"truncate"> with the file descriptor L</"FD">.

=head2 ioctl

C<static method ioctl : int ($fd : int, $request : int, $request_arg_ref : object of byte[]|short[]|int[]|long[]|float[]|double[]|object = undef);>
Calls L<Sys#ioctl|SPVM::Sys/"ioctl"> with the file descriptor L</"FD">, and returns the return value.

=head2 sync

C<method sync : void ();>

Calls L<Sys#sync|SPVM::Sys/"sync"> with the file descriptor L</"FD">, and returns the return value.

=head2 stat

C<method stat : Sys::IO::Stat ();>

Calls L<Sys#stat|SPVM::Sys/"stat"> with the file descriptor L</"FD">, and returns the return value.

=head2 fcntl

C<method fcntl : int ($command : int, $command_arg : object = undef of Int|Sys::IO::Flock|object);>

Calls L<Sys#fcntl|SPVM::Sys/"fcntl"> with the file descriptor L</"FD">, and returns the return value.

=head2 write

C<method write : int ($string : string, $length : int = -1, $offset : int = 0);>

Writes the string $string from the offset $offset with the length $length to the stream associated with the file descriptoer L</"FD">.

And returns the write length.

This method is implemented in a child class.

=head2 read

C<method read : int ($string : mutable string, $length : int = -1, $offset : int = 0);>

Reads the string $string from the offset $offset with the length $length from the stream associated with the file descriptoer L</"FD">.

And returns the read length.

This method is implemented in a child class.

=head2 close

C<method close : int ();>

Closes the stream associated with the file descriptoer L</"FD">.

This method is implemented in a child class.

=head1 Well Known Child Classes

=over 2

L<IO::File|SPVM::IO::File>

L<IO::Socket|SPVM::IO::Socket>

L<IO::Socket::IP|SPVM::IO::Socket::IP>

L<IO::Socket::INET|SPVM::IO::Socket::INET>

L<IO::Socket::INET6|SPVM::IO::Socket::INET6>

L<IO::Socket::UNIX|SPVM::IO::Socket::UNIX>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


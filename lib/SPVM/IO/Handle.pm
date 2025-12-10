package SPVM::IO::Handle;

1;

=head1 NAME

SPVM::IO::Handle - I/O Handling

=head1 Description

IO::Handle class in L<SPVM> has methods to handle file handles.

=head1 Details

IO::Handle class is an abstract class.

See L</"Well Known Child Classes"> about its child classes.

=head1 Usage
  
  use IO::Handle;

=head1 Details

This class is a Perl's L<IO::Handle> porting.

=head1 Fields

=head2 FD

C<has FD : protected int;>

A file descriptor.

=head2 Blocking

C<has Blocking : protected byte;>

A flag for blocking IO.

=head1 Class Methods

=head1 Instance Methods

=head2 init

C<protected method init : void ($options : object[] = undef);>

Initializes fields given the options $options.

Options:

=over 2

=item * C<FD : Int = -1>

L</"FD"> field is set to this value.

=item * C<Blocking : Int = 1>

L</"Blocking"> field is set to this value.

If this value is 0, L</"set_blocking"> method is called with 0.

=back

=head2 fileno

C<method fileno : int ();>

Returns the value of L</"FD"> field.

=head2 opened

C<method opened : int ();>

If L</"FD"> is greater than or equal to 0, returns 1. Otherwise returns 0.

=head2 blocking

C<method blocking : int ();>

Retruns the value of L</"Blocking"> field.

=head2 set_blocking

C<method set_blocking : void ($blocking : int);>

If $blocking is a false value and L</"Blocking"> field is a true value, enables the non-blocking mode of the file descriptor L</"FD">.

If $blocking is a true value and L</"Blocking"> field is a false value, disables the non-blocking mode of the file descriptor L</"FD">.

And sets L</"Blocking"> field to $blocking.

=head2 close

C<method close : int ();>

Closes the handle associated with the file descriptoer L</"FD">.

This method is implemented in a child class.

=head2 sysread

C<method sysread : int ($string : mutable string, $length : int = -1, $offset : int = 0);>

Reads the length $length of data from the stream associated with the file descriptoer L</"FD"> and store it to the offset $offset position of the string $string.

And returns the read length.

=head2 syswrite

C<method syswrite : int ($string : string, $length : int = -1, $offset : int = 0);>

Writes the length $length from the offset $offset of the string $string to the stream associated with the file descriptoer L</"FD">.

And returns the write length.

=head2 stat

C<method stat : Sys::IO::Stat ();>

Calls L<Sys#stat|SPVM::Sys/"stat"> method with the file descriptor L</"FD">, and returns the return value.

=head2 fcntl

C<method fcntl : int ($command : int, $command_arg : object = undef of Int|Sys::IO::Flock|object);>

Calls L<Sys#fcntl|SPVM::Sys/"fcntl"> method with the file descriptor L</"FD">, and returns the return value.

=head2 ioctl

C<static method ioctl : int ($fd : int, $request : int, $request_arg_ref : object of byte[]|short[]|int[]|long[]|float[]|double[]|object = undef);>

Calls L<Sys#ioctl|SPVM::Sys/"ioctl"> method with the file descriptor L</"FD">, and returns the return value.

=head2 sync

C<method sync : void ();>

Syncs the stream associated with the file descriptoer L</"FD">.

This method is implemented in a child class.

=head2 truncate

C<method truncate : void ($legnth : long);>

Trancates the stream associated with the file descriptoer L</"FD">.

This method is implemented in a child class.

=head2 DESTROY

C<method DESTROY : void ();>

If this handle is opened(L</"opened"> method returns a true value), closes the handle by L</"close"> method.

=head1 Well Known Child Classes

=over 2

=item * L<IO::File|SPVM::IO::File>

=item * L<IO::Socket|SPVM::IO::Socket>

=item * L<IO::Socket::IP|SPVM::IO::Socket::IP>

=item * L<IO::Socket::INET|SPVM::IO::Socket::INET>

=item * L<IO::Socket::INET6|SPVM::IO::Socket::INET6>

=item * L<IO::Socket::UNIX|SPVM::IO::Socket::UNIX>

=back

=head1 See Also

=over 2

=item * L<IO|SPVM::IO>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


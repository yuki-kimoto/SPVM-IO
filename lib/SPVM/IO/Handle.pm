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

=item * AutoFlush : Int

=item * Blocking : Int

=back

=head1 Instance Methods

=head2 autoflush

C<method autoflush : int ();>

=head2 set_autoflush

C<method set_autoflush : void ($autoflush : int);>
  
=head2 opened

C<method opened : int ();>

If the return value of L</"fileno"> is greater than or equal to 0, returns 1. Otherwise returns 0.

=head2 fileno

C<method fileno : int ();>

Gets L</"FD"> field.

=head2 print

C<method print : void ($string : string);>

=head2 printf

C<method printf : void ($format : string, $args : object[]...);>

=head2 say

C<method say : void ($string : string);>

=head2 truncate

C<method truncate : void ($legnth : long);>

Truncates to a size of precisely length bytes.

This method is planed to be implemented in a child class.

This method always throws an exception.

=head2 ioctl

  static method ioctl : int ($fd : int, $request : int, $request_arg_ref : object of byte[]|short[]|int[]|long[]|float[]|double[]|object = undef);>

=head2 sync

C<method sync : void ();>

=head2 stat

C<method stat : Sys::IO::Stat ();>

=head2 fcntl

C<method fcntl : int ($command : int, $command_arg : object = undef of Int|Sys::IO::Flock|object);>

=head2 set_blocking

C<method set_blocking : void ($blocking : int);>

=head2 syswrite

C<method syswrite : int ($string : string, $length : int = -1, $offset : int = 0);>

=head2 sysread

C<method sysread : int ($string : mutable string, $length : int = -1, $offset : int = 0);>

=head2 write

C<method write : int ($string : string, $length : int = -1, $offset : int = 0);>

Exceptions:

Not implemented.

=head2 read

C<method read : int ($string : mutable string, $length : int = -1, $offset : int = 0);>

Exceptions:

Not implemented.

=head2 close

C<method close : int ();>

Exceptions:

Not implemented.

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


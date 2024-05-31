package SPVM::IO::Socket;

1;

=head1 Name

SPVM::IO::Socket - Sockets

=head1 Description

L<SPVM::IO::Socket> class has methods for sockets.

=head1 Usage
  
  use IO::Socket;
  use Sys::Socket::Constant as SOCKET;
  
  # Create a new AF_INET socket
  my $socket = IO::Socket->new({Domain => SOCKET->AF_INET});
  
  # Create a new AF_INET6 socket
  my $socket = IO::Socket->new({Domain => SOCKET->AF_INET6});
  
  # Create a new AF_UNIX socket
  my $socket = IO::Socket->new({Domain => SOCKET->AF_UNIX});

=head1 Details

=head2 Socket Constant Values

See L<Sys::Socket::Constant|SPVM::Sys::Socket::Constant> about constant values for sockets.

=head1 Super Class

L<IO::Handle|SPVM::IO::Handle>

=head1 Fields

=head2 Domain

C<has Domain : protected int;>

A protocol family, like C<AF_INET>, C<AF_INET6>, C<AF_UNIX>.

=head2 Type

C<has Type : protected int;>

A socket type, like C<SOCK_STREAM>, C<SOCK_DGRAM>.

=head2 Proto

C<has Proto : protected ro int;>

A particular protocol, normally this is set to 0.

=head2 Timeout

C<has Timeout : protected double;>

A timeout seconds for system calls that would set C<errno> to C<EWOULDBLOCK>, like C<read()>, C<write()>, C<connect()>, C<accept()>.

=head2 Listen

  has Listen : protected int;

=head1 Class Methods

=head2 new

C<static method new : IO::Socket ($options : object[] = undef);>

The socket is set to non-blocking mode.

Options:

=over 2

=item * Domain : Int

=item * Type : Int

=item * Proto : Int

=item * Timeout : Double

=item * Listen : Int

=back

See also L<SPVM::Sys::Socket::Constant>.

=head1 Instance Methods

=head2 sockdomain

C<method sockdomain : int ();>

Returns the value of L</"Domain"> field.

=head2 socktype

C<method socktype : int ();>

Returns the value of L</"Type"> field.

=head2 protocol

C<method protocol : int ();>

Returns the value of L</"Proto"> field.

=head2 timeout

C<method timeout : double ();>

Returns the value of L</"Timeout"> field.

=head2 set_timeout

C<method set_timeout : void ($timeout : double);>

Sets L</"Timeout"> field to $timeout.

=head2 DESTROY

C<method DESTROY : void ();>

A destructor. This method closes the socket by calling L</"close"> method if the socket is opened.

=head2 socket

C<method socket : void ();>

Opens a socket using L</"Domain"> field, L</"Type"> field, and L</"Protocal"> field.

L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field is set to the file descriptor of the opened socket.

This method calls L<Sys#socket|Sys/"socket"> method.

Exceptions:

Exceptions thrown by L<Sys#socket|Sys/"socket"> method could be thrown.

=head2 recv

C<method recv : int ($buffer : mutable string, $length : int = -1, $flags : int = 0, $buf_offset : int = 0);>

=head2 send

C<method send : int ($buffer : string, $flags : int = 0, $length : int = -1, $buf_offset : int = 0);>

Calls L</"sendto"> method with $to set to C<undef> and returns its return value.

Exceptions:

Exceptions thrown by L</"sendto"> method could be thrown.

=head2 sendto

C<method sendto : int ($buffer : string, $flags : int = 0, $to : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> = undef, $length : int = -1, $buf_offset : int = 0);>

=head2 close

C<method close : int ();>

Closes the socket assciated with the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

Exceptions:

If this socket is not opened or already closed, an excetpion is thrown.

=head2 sockname

C<method sockname : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns the local socket address of the socket assciated with the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#getsockname|SPVM::Sys/"getsockname"> method.

Exceptions:

Exceptions thrown by L<Sys#getsockname|SPVM::Sys/"getsockname"> method could be thrown.

=head2 peername

C<method peername : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns the remote socket address of the socket assciated with the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#getpeername|SPVM::Sys/"getpeername"> method.

Exceptions:

Exceptions thrown by L<Sys#getpeername|SPVM::Sys/"getpeername"> method could be thrown.

=head2 connected

C<method connected : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

If L</"peername"> method does not throw an exception, returns the return value, otherwise returns undef.

=head2 shutdown

C<method shutdown : void ($how : int);>

Shuts down the socket assciated with the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field given the way $how.

This method calls L<Sys#shutdown|SPVM::Sys/"shutdown"> method.

See L<Sys::Socket::Constant|SPVM::Sys::Socket::Constant> about constant values given to $how.

=over 2

=item * C<SHUT_RD>

=item * C<SHUT_WR>

=item * C<SHUT_RDWR>

=back

Exceptions:

Exceptions thrown by L<Sys#shutdown|SPVM::Sys/"shutdown"> method could be thrown.

=head2 atmark

C<method atmark : int ();>

If the socket assciated with the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field is currently positioned at the urgent data mark, returns 1, otherwise returns 0.

This method calls L<Sys::Socket#sockatmark|SPVM::Sys::Socket/"sockatmark"> method.

Exceptions:

Exceptions thrown by L<Sys::Socket#sockatmark|SPVM::Sys::Socket/"sockatmark"> method could be thrown.

=head2 bind

C<method bind : void ($sockaddr : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>);>

Does the same thing that L<bind|https://linux.die.net/man/2/bind> system call does given a socket address $sockaddr and the file descriptor stored in L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#bind|SPVM::Sys|/"bind">.

Exceptions:

Exceptions thrown by L<Sys#bind|SPVM::Sys|/"bind"> method could be thrown.

=head2 listen

C<method listen : void ();>

Does the same thing that L<listen|https://linux.die.net/man/2/listen> system call does given the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#listen|SPVM::Sys|/"listen">.

Exceptions:

Exceptions thrown by L<Sys#listen|SPVM::Sys|/"listen"> method could be thrown.

=head2 peerport

C<method peerport : int ();>

This method is implemented in a child class.

Exceptions:

Not implemented.

=head2 peerhost

C<method peerhost : string ();>

This method is implemented in a child class.

Exceptions:

Not implemented.

=head2 write

C<method write : int ($string : string, $length : int = -1, $offset : int = 0);>

Writes the length $length from the offset $offset of the string $string to the stream associated with the file descriptoer L</"FD">.

This method calls L</"send"> method with $buffer set to $string, $flags set to 0, $length set to $length, and $buf_offset set to $offset.

And returns its return value.

Exceptions:

Exceptions thrown by L</"send"> method could be thrown.

=head2 read

C<method read : int ($string : mutable string, $length : int = -1, $offset : int = 0);>

=head2 sockopt

C<method sockopt : int ($level : int, $optname : int);>

=head2 setsockopt

C<method setsockopt : void ($level : int, $optname : int, $optval : object of string|Int)

=head1 See Also

=head2 Sys::Socket

L<Sys::Socket|SPVM::Sys::Socket>

=head2 Sys::Socket::Constant

L<Sys::Socket::Constant|SPVM::Sys::Socket::Constant>

=head2 IO::Socket::INET

L<IO::Socket::INET|SPVM::IO::Socket::INET>

=head2 Perl's IO::Socket

C<IO::Socket> is a Perl's L<IO::Socket|IO::Socket> porting to L<SPVM>.

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


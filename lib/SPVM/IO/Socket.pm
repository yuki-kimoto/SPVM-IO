package SPVM::IO::Socket;

1;

=head1 Name

SPVM::IO::Socket - Sockets

=head1 Description

IO::Socket class in L<SPVM> represents a socket.

=head1 Usage
  
  use IO::Socket;

=head1 Details

IO::Socket is an abstract class.

See L</"Well Known Child Classes"> about child classes of this class.

=head2 Socket Constant Values

See L<Sys::Socket::Constant|SPVM::Sys::Socket::Constant> about constant values for sockets.

=head2 Goroutine

Connect, accept, read, and write operations in IO::Socket class work with L<goroutines|SPVM::Go>.

Non-blocking mode of a L<IO::Socket|SPVM::IO::Socket> object is enabled.

If an IO wait occurs, control is transferred to another goroutine.

This allows you to write connect, accept, read, and write operations as if they were synchronous.

=head1 Well Known Child Classes

=over 2

=item * L<IO::Socket::IP|SPVM::IO::Socket::IP>

=item * L<IO::Socket::INET|SPVM::IO::Socket::INET>

=item * L<IO::Socket::INET6|SPVM::IO::Socket::INET6>

=back

=head1 Super Class

L<IO::Handle|SPVM::IO::Handle>

=head1 Fields

=head2 Domain

C<has Domain : protected int;>

A protocol family, such as C<AF_INET>, C<AF_INET6>, C<AF_UNIX>.

=head2 Type

C<has Type : protected int;>

A socket type, such as C<SOCK_STREAM>, C<SOCK_DGRAM>, C<SOCK_RAW>.

=head2 Proto

C<has Proto : protected ro int;>

A socket protocol, such as C<IPPROTO_TCP>, C<IPPROTO_UDP>.

=head2 Timeout

C<has Timeout : protected double;>

A timeout seconds for read, write, connect, accept operations.

=head2 Listen

C<has Listen : protected int;>

The number of listen backlog.

=head1 Instance Methods

=head2 init

C<protected method init : void ($options : object[] = undef);>

Options:

The following options are available adding to the options for L<IO::Handle#init|SPVM::IO::Handle/"init"> method.

[Name][Type][Default Value]

=over 2

=item * C<Domain> : Int = 0

=item * C<Type> : Int = 0

=item * C<Proto> : Int = 0

=item * C<Timeout> : Double = 0.0

=item * C<Listen> : Int = 0

=back

See also L<SPVM::Sys::Socket::Constant>.

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

=head2 close

C<method close : int ();>

Closes the socket assciated with the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

Exceptions:

If this socket is not opened or already closed, an excetpion is thrown.

=head2 accept

C<method accept : L<IO::Socket|SPVM::IO::Socket> ($peer_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[] = undef);>

Does the same thing that L<accept|https://linux.die.net/man/2/accept> system call does given the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#accept|SPVM::Sys|/"accept">.

Exceptions:

Exceptions thrown by L<Sys#accept|SPVM::Sys|/"accept"> method could be thrown.

=head2 recvfrom

C<method recvfrom : int ($buffer : mutable string, $length : int, $flags : int, $from_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[], $offset : int = 0)>

=head2 sendto

C<method sendto : int ($buffer : string, $flags : int, $to : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>, $length : int = -1, $offset : int = 0);>

=head2 recv

C<method recv : int ($buffer : mutable string, $length : int = -1, $flags : int = 0, $offset : int = 0);>

Calls L</"recvfrom"> method given the arguments to this method with $from_ref set to C<undef> and returns its return value.

Exceptions:

Exceptions thrown by L</"recvfrom"> method could be thrown.

=head2 send

C<method send : int ($buffer : string, $flags : int = 0, $length : int = -1, $offset : int = 0);>

Calls L</"sendto"> method given the arguments to this method with $to set to C<undef> and returns its return value.

Exceptions:

Exceptions thrown by L</"sendto"> method could be thrown.

=head2 read

C<method read : int ($buffer : mutable string, $length : int = -1, $offset : int = 0);>

Reads the length $length of data from the stream associated with the file descriptoer L</"FD"> and store it to the offset $offset position of the string $string.

And returns the read length.

This method calls L</"recv"> method given the arguments given to this method and returns its return values.

=head2 write

C<method write : int ($buffer : string, $length : int = -1, $offset : int = 0);>

Writes the length $length from the offset $offset of the string $buffer to the stream associated with the file descriptoer L</"FD">.

And returns the write length.

This method calls L</"send"> method given the arguments given to this method and returns its return values.

Exceptions:

Exceptions thrown by L</"send"> method could be thrown.

=head2 sockname

C<method sockname : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns the local socket address of the socket assciated with the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#getsockname|SPVM::Sys/"getsockname"> method.

Exceptions:

Exceptions thrown by L<Sys#getsockname|SPVM::Sys/"getsockname"> method could be thrown.

=head2 peername

C<method peername : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns the peer socket address of the socket assciated with the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#getpeername|SPVM::Sys/"getpeername"> method.

Exceptions:

Exceptions thrown by L<Sys#getpeername|SPVM::Sys/"getpeername"> method could be thrown.

=head2 connected

C<method connected : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

If L</"peername"> method does not throw an exception, returns the return value, otherwise returns undef.

=head2 atmark

C<method atmark : int ();>

If the socket assciated with the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field is currently positioned at the urgent data mark, returns 1, otherwise returns 0.

This method calls L<Sys::Socket#sockatmark|SPVM::Sys::Socket/"sockatmark"> method.

Exceptions:

Exceptions thrown by L<Sys::Socket#sockatmark|SPVM::Sys::Socket/"sockatmark"> method could be thrown.

=head2 sockopt

C<method sockopt : int ($level : int, $option_name : int);>

Gets a socket option of the file descriptor stored in L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field given the socket level $level and the option name $option_name.

This method calls L<Sys#getsockopt|SPVM::Sys/"getsockopt"> method given the arguments given to this method and returns its return value.

Exceptions:

Exceptions thrown by L<Sys#getsockopt|SPVM::Sys/"getsockopt"> method could be thrown.

=head2 setsockopt

C<method setsockopt : void ($level : int, $option_name : int, $option_value : object of string|L<Int|SPVM::Int>);>

Sets a socket option of the file descriptor stored in L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field given the socket level $level, the option name $option_name, and the option value $option_value.

This method calls L<Sys#setsockopt|SPVM::Sys/"setsockopt"> method given the arguments given to this method.

Exceptions:

Exceptions thrown by L<Sys#setsockopt|SPVM::Sys/"setsockopt"> method could be thrown.

=head2 connect

C<protected method connect : void ($sockaddr : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>);>

=head2 socket

C<protected method socket : void ();>

Opens a socket using L</"Domain"> field, L</"Type"> field, and L</"Protocal"> field.

L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field is set to the file descriptor of the opened socket.

This method calls L<Sys#socket|Sys/"socket"> method.

Exceptions:

Exceptions thrown by L<Sys#socket|Sys/"socket"> method could be thrown.

=head2 bind

C<protected method bind : void ($sockaddr : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>);>

Does the same thing that L<bind|https://linux.die.net/man/2/bind> system call does given a socket address $sockaddr and the file descriptor stored in L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#bind|SPVM::Sys|/"bind">.

Exceptions:

Exceptions thrown by L<Sys#bind|SPVM::Sys|/"bind"> method could be thrown.

=head2 listen

C<protected method listen : void ();>

Does the same thing that L<listen|https://linux.die.net/man/2/listen> system call does given the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#listen|SPVM::Sys|/"listen">.

Exceptions:

Exceptions thrown by L<Sys#listen|SPVM::Sys|/"listen"> method could be thrown.

=head2 set_blocking

C<method set_blocking : void ($blocking : int);>

This method is the same as L<IO::Handle#set_blocking|SPVM::IO::Handle/"set_blocking"> method, but if a true value is given to $blocking, an exception is thrown.

Exceptions:

Calling set_blocking method given a true value on an IO::Socket object is forbidden.

=head1 See Also

=over 2

=item * L<Sys::Socket|SPVM::Sys::Socket>

=item * L<Sys::Socket::Constant|SPVM::Sys::Socket::Constant>

=back

=head1 Porting

This class is a Perl's L<IO::Socket|IO::Socket> porting to L<SPVM>.

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


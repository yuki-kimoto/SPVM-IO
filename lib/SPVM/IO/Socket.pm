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

=head2 Sockaddr

C<has Sockaddr : protected L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>;>

A L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> object used by L</"connect"> or L</"bind"> method.

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

The blocking mode of the socket is set to non-blocking mode.

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

=head2 set_blocking

C<method set_blocking : void ($blocking : int);>

This method is the same as L<IO::Handle#set_blocking|SPVM::IO::Handle/"set_blocking"> method, but if a true value is given to $blocking, an exception is thrown.

Exceptions:

Calling set_blocking method given a true value on an IO::Socket object is forbidden.

=head2 socket

C<protected method socket : void ();>

Opens a socket using L</"Domain"> field, L</"Type"> field, and L</"Protocal"> field.

L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field is set to the file descriptor of the socket.

This method calls L<Sys#socket|Sys/"socket"> method.

Exceptions:

Exceptions thrown by L<Sys#socket|Sys/"socket"> method could be thrown.

=head2 connect

C<protected method connect : void ();>

Performs connect operation.

This method calls L<Sys#connect> method given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field and the value of L</"Sockaddr"> field.

If connect operation need to be performed again for IO wait, L<Go#gosched_io_write|SPVM::Go/"gosched_io_write"> method is called given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field and the value of L</"Timeout"> field.

And when the current goroutine is returned, this method retries connect operation.

If timeout occurs, an exception is thrown set C<eval_error_id> to the basic type ID of L<Go::Error::IOTimeout|SPVM::Go::Error::IOTimeout> class.

Exceptions:

Exceptions thrown by L<Sys#connect> method could be thrown.

Exceptions thrown by L<Go#gosched_io_write|SPVM::Go/"gosched_io_write"> method could be thrown.

=head2 bind

C<protected method bind : void ($sockaddr : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>);>

Perform bind operation.

This method calls L<Sys#bind|SPVM::Sys|/"bind"> method given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field and the value of L</"Sockaddr"> field.

Exceptions:

Exceptions thrown by L<Sys#bind|SPVM::Sys|/"bind"> method could be thrown.

=head2 listen

C<protected method listen : void ();>

Does the same thing that L<listen|https://linux.die.net/man/2/listen> system call does given the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#listen|SPVM::Sys|/"listen">.

Exceptions:

Exceptions thrown by L<Sys#listen|SPVM::Sys|/"listen"> method could be thrown.

=head2 accept

C<method accept : L<IO::Socket|SPVM::IO::Socket> ($peer_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[] = undef);>

Performs accept operation and returns a client socket object.

The type of the returned object is the type of this instance.

This method calls L<Sys#accept|SPVM::Sys|/"accept"> method given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field and $peer_ref.

If accept operation need to be performed again for IO wait, L<Go#gosched_io_read|SPVM::Go/"gosched_io_read"> method is called given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field and the value of L</"Timeout"> field.

And when the current goroutine is returned, this method retries accept operation.

If timeout occurs, an exception is thrown set C<eval_error_id> to the basic type ID of L<Go::Error::IOTimeout|SPVM::Go::Error::IOTimeout> class.

$peer_ref at index 0 is set to a client socket address if specified.

Exceptions:

Exceptions thrown by L<Sys#accept|SPVM::Sys|/"accept"> method could be thrown.

Exceptions thrown by L<Go#gosched_io_read|SPVM::Go/"gosched_io_read"> method could be thrown.

=head2 shutdown

C<method shutdown : void ($how : int);>

Performs shutdown operation given the way $how.

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

C<method close : void ();>

Performs close operation.

This method calls L<Sys::Socket#close|SPVM::Sys::Socket/"close"> method

Exceptions:

If this socket is not opened or already closed, an excetpion is thrown.

=head2 recvfrom

C<method recvfrom : int ($buffer : mutable string, $length : int, $flags : int, $from_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[], $offset : int = 0)>

Performs recvfrom operation and returns read length.

This method calls L<Sys#recvfrom|SPVM::Sys/"recvfrom"> method given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field, $buffer, $length, $flags, $from_ref, $offset, and returns its return value.

If recvfrom operation need to be performed again for IO wait, L<Go#gosched_io_read|SPVM::Go/"gosched_io_read"> method is called given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field and the value of L</"Timeout"> field.

And when the current goroutine is returned, this method retries recvfrom operation.

If timeout occurs, an exception is thrown set C<eval_error_id> to the basic type ID of L<Go::Error::IOTimeout|SPVM::Go::Error::IOTimeout> class.

Exceptions:

Exceptions thrown by L<Sys#recvfrom|SPVM::Sys/"recvfrom"> method could be thrown.

Exceptions thrown by L<Go#gosched_io_read|SPVM::Go/"gosched_io_read"> method could be thrown.

=head2 sendto

C<method sendto : int ($buffer : string, $flags : int, $to : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>, $length : int = -1, $offset : int = 0);>

Performs sendto operation and returns write length.

This method calls L<Sys#sendto|SPVM::Sys/"sendto"> method given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field, $buffer, $flags, $to, $length, $offset, and returns its return value.

If sendto operation need to be performed again for IO wait, L<Go#gosched_io_write|SPVM::Go/"gosched_io_write"> method is called given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field and the value of L</"Timeout"> field.

And when the current goroutine is returned, this method retries sendto operation.

If timeout occurs, an exception is thrown set C<eval_error_id> to the basic type ID of L<Go::Error::IOTimeout|SPVM::Go::Error::IOTimeout> class.

Exceptions:

Exceptions thrown by L<Sys#sendto|SPVM::Sys/"sendto"> method could be thrown.

Exceptions thrown by L<Go#gosched_io_write|SPVM::Go/"gosched_io_write"> method could be thrown.

=head2 recv

C<method recv : int ($buffer : mutable string, $length : int = -1, $flags : int = 0, $offset : int = 0);>

Performs recv operation.

Thie method just calls L</"recvfrom"> method given $buffer, $length, $flags, $from_ref set to undef, $offset, and returns its return value.

Exceptions:

Exceptions thrown by L</"recvfrom"> method could be thrown.

=head2 send

C<method send : int ($buffer : string, $flags : int = 0, $length : int = -1, $offset : int = 0);>

Performs send operation.

This method just calls L</"sendto"> method given $buffer, $flags, $to set to 0, $length, $offset, and returns its return value.

Exceptions:

Exceptions thrown by L</"sendto"> method could be thrown.

=head2 read

C<method read : int ($buffer : mutable string, $length : int = -1, $offset : int = 0);>

Perform read operation.

This method just calls L</"recv"> method given $buffer, $length, $flags set to 0, $offset, and returns its return values.

Exceptions:

Exceptions thrown by L</"recv"> method could be thrown.

=head2 syswrite

C<method syswrite : int ($buffer : string, $length : int = -1, $offset : int = 0);>

Perform syswrite operation.

This method just calls L</"send"> method given $buffer, $flags set to 0, $length, $offset, and returns its return values.

Exceptions:

Exceptions thrown by L</"send"> method could be thrown.

=head2 sockname

C<method sockname : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns a L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> for a local address.

This method calls L<Sys#getsockname|SPVM::Sys/"getsockname"> method given the vlaue of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

Exceptions:

Exceptions thrown by L<Sys#getsockname|SPVM::Sys/"getsockname"> method could be thrown.

=head2 peername

C<method peername : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns a L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> for a remote address.

This method calls L<Sys#getpeername|SPVM::Sys/"getpeername"> method given the vlaue of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

Exceptions:

Exceptions thrown by L<Sys#getpeername|SPVM::Sys/"getpeername"> method could be thrown.

=head2 connected

C<method connected : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Checks if the socket is connected.

If L</"peername"> method does not throw an exception, returns a L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> object, otherwise returns undef.

=head2 atmark

C<method atmark : int ();>

Perform atmark operation and returns the result.

This method just calls L<Sys::Socket#sockatmark|SPVM::Sys::Socket/"sockatmark"> method given the vlaue of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

Exceptions:

Exceptions thrown by L<Sys::Socket#sockatmark|SPVM::Sys::Socket/"sockatmark"> method could be thrown.

=head2 sockopt

C<method sockopt : int ($level : int, $option_name : int);>

Perform sockopt operation and returns the result.

Gets a socket option of the file descriptor stored in L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field given the socket level $level and the option name $option_name.

This method just calls L<Sys#getsockopt|SPVM::Sys/"getsockopt"> method given the vlaue of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field, $level, $opton_name, and its return value.

Exceptions:

Exceptions thrown by L<Sys#getsockopt|SPVM::Sys/"getsockopt"> method could be thrown.

=head2 setsockopt

C<method setsockopt : void ($level : int, $option_name : int, $option_value : object of string|L<Int|SPVM::Int>);>

Perform setsockopt operation.

This method just calls L<Sys#setsockopt|SPVM::Sys/"setsockopt"> method given the arguments given the vlaue of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field, $level, $option_name.

Exceptions:

Exceptions thrown by L<Sys#setsockopt|SPVM::Sys/"setsockopt"> method could be thrown.

=head1 See Also

=over 2

=item * L<IO::Handle|SPVM::IO::Handle>

=item * L<IO|SPVM::IO>

=item * L<Sys::Socket|SPVM::Sys::Socket>

=item * L<Sys::Socket::Constant|SPVM::Sys::Socket::Constant>

=back

=head1 Porting

This class is a Perl's L<IO::Socket|IO::Socket> porting to L<SPVM>.

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


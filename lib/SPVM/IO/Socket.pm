package SPVM::IO::Socket;

1;

=head1 Name

SPVM::IO::Socket - Sockets with Goroutines and Deadlines

=head1 Description

L<SPVM::IO::Socket> is an abstract class that represents a network socket. It is designed to work seamlessly with L<SPVM::Go> and provides powerful timeout management using absolute deadlines.

=head1 Usage
  
  use IO::Socket::IP;
  use Go;
  use Go::Time;

  # Create a simple TCP client
  my $socket = IO::Socket::IP->new({
    PeerAddr => "example.com",
    PeerPort => 80,
  });

  # Set an absolute deadline for both read and write (5 seconds from now)
  my $deadline = Go::Time->now->add(Go::Duration_1l->new_from_sec(5.0));
  $socket->set_deadline($deadline);

  # Send a request
  my $payload = "GET / HTTP/1.1\r\nHost: example.com\r\n\r\n";
  $socket->syswrite($payload);

=head1 Details

IO::Socket is an abstract class. For concrete implementations, see L</"Well Known Child Classes">.

=head2 Socket Constant Values

See L<Sys::Socket::Constant|SPVM::Sys::Socket::Constant> for constant values such as C<AF_INET>, C<SOCK_STREAM>, etc.

=head2 Goroutine and Non-blocking I/O

All I/O operations in this class (C<connect>, C<accept>, C<read>, C<write>, etc.) are non-blocking and integrated with L<goroutines|SPVM::Go>.

If an I/O operation cannot be completed immediately, the current goroutine yields control to the Go scheduler, allowing other goroutines to run. When the socket becomes ready, the goroutine is automatically resumed. 

B<Example:>

  # Running a concurrent TCP server
  Go->go(method : void () {
    my $listen = IO::Socket::IP->new({
      LocalAddr => "0.0.0.0",
      LocalPort => 8080,
      Listen    => 10,
    });
    
    while (my $client = $listen->accept) {
      # Handle each connection in a new goroutine
      Go->go([$client : IO::Socket] method : void () {
        my $buf = (mutable string)new_string_len 1024;
        $client->sysread($buf);
        $client->syswrite("Hello from Goroutine!");
        $client->close;
      });
    }
  });
  
  Go->gosched;

=head2 Deadlines and Go::Context

This class provides two types of absolute deadlines for precise I/O control, similar to Go's C<net.Conn>:

=over 2

=item 1. L</"ReadDeadline"> - A specific deadline for read operations (C<accept>, C<recv>, etc.).

=item 2. L</"WriteDeadline"> - A specific deadline for write operations (C<connect>, C<send>, etc.).

=back

B<Example:>

  # Limit only read operations to 3 seconds
  my $read_limit = Go::Time->now->add(Go::Duration_1l->new_from_sec(3.0));
  $socket->set_read_deadline($read_limit);
  
  eval {
    $socket->sysread($buffer);
  };
  if ($@ isa Go::Context::Error::DeadlineExceeded) {
    # Handle the case where no data was received within 3 seconds
  }

These deadlines represent absolute points in time. You can also use L</"set_deadline"> to set both read and write deadlines to the same value at once. This mechanism is designed to be compatible with the cancellation patterns found in C<Go::Context>.

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

C<has Proto : protected int;>

A socket protocol, such as C<IPPROTO_TCP>, C<IPPROTO_UDP>.

=head2 Timeout

C<has Timeout : protected double;>

An B<inactivity timeout> in seconds for read, write, connect, and accept operations. This represents the maximum allowed idle time for a single I/O operation.

=head2 Listen

C<has Listen : protected int;>

The number of listen backlog.

=head2 Sockaddr

C<has Sockaddr : protected L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>;>

A L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> object used by L</"connect"> or L</"bind"> method.

=head2 ReadDeadline

C<has ReadDeadline : protected L<Go::Time|SPVM::Go::Time>;>

An B<absolute deadline> for read operations. If this deadline is reached, the operation is interrupted, and a L<Go::Context::Error::DeadlineExceeded|SPVM::Go::Context::Error::DeadlineExceeded> exception is thrown.

=head2 WriteDeadline

C<has WriteDeadline : protected L<Go::Time|SPVM::Go::Time>;>

An B<absolute deadline> for write operations. If this deadline is reached, the operation is interrupted, and a L<Go::Context::Error::DeadlineExceeded|SPVM::Go::Context::Error::DeadlineExceeded> exception is thrown.

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

=item * C<ReadDeadline> : L<Go::Time|SPVM::Go::Time> = undef

=item * C<WriteDeadline> : L<Go::Time|SPVM::Go::Time> = undef

=back

The blocking mode of the socket is set to non-blocking mode.

Exceptions:

The C<Blocking> option is not allowed in this class or its children.

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

Sets L</"Timeout"> field to $timeout. This value is used as an inactivity timeout.

=head2 set_deadline

C<method set_deadline : void ($deadline : L<Go::Time|SPVM::Go::Time>);>

Sets both L</"ReadDeadline"> and L</"WriteDeadline"> fields to C<$deadline>.

=head2 read_deadline

C<method read_deadline : L<Go::Time|SPVM::Go::Time> ();>

Returns the value of L</"ReadDeadline"> field.

=head2 set_read_deadline

C<method set_read_deadline : void ($deadline : L<Go::Time|SPVM::Go::Time>);>

Sets L</"ReadDeadline"> field to $deadline.

=head2 write_deadline

C<method write_deadline : L<Go::Time|SPVM::Go::Time> ();>

Returns the value of L</"WriteDeadline"> field.

=head2 set_write_deadline

C<method set_write_deadline : void ($deadline : L<Go::Time|SPVM::Go::Time>);>

Sets L</"WriteDeadline"> field to $deadline.

=head2 set_blocking

C<method set_blocking : void ($blocking : int);>

This method is the same as L<IO::Handle#set_blocking|SPVM::IO::Handle/"set_blocking"> method, but if a true value is given to $blocking, an exception is thrown.

Exceptions:

Calling set_blocking method given a true value on an IO::Socket object is forbidden.

=head2 socket

C<protected method socket : void ();>

Opens a socket using L</"Domain"> field, L</"Type"> field, and L</"Proto"> field.

L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field is set to the file descriptor of the socket.

This method calls L<Sys#socket|Sys/"socket"> method.

Exceptions:

Exceptions thrown by L<Sys#socket|Sys/"socket"> method could be thrown.

=head2 connect

C<protected method connect : void ();>

Performs connect operation.

This method supports the inactivity L</"Timeout"> and the absolute L</"WriteDeadline">.

Exceptions:

If the absolute deadline is reached, a L<Go::Context::Error::DeadlineExceeded|SPVM::Go::Context::Error::DeadlineExceeded> exception is thrown.

Exceptions thrown by L<Sys#connect> method could be thrown.

Exceptions thrown by L<Go#gosched_io_write|SPVM::Go/"gosched_io_write"> method could be thrown.

=head2 bind

C<protected method bind : void ();>

Performs bind operation.

This method calls L<Sys#bind|SPVM::Sys|/"bind"> method given the value of L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field and the value of L</"Sockaddr"> field.

Exceptions:

Exceptions thrown by L<Sys#bind|SPVM::Sys|/"bind"> method could be thrown.

=head2 listen

C<protected method listen : void ();>

Does the same thing that L<listen|https://linux.die.net/man/2/listen> system call does given the file descriptor L<IO::Handle#FD|SPVM::IO::Handle/"FD"> field.

This method calls L<Sys#listen|SPVM::Sys|/"listen">.

Exceptions:

L</"Listen"> field must be greater than 0.

Exceptions thrown by L<Sys#listen|SPVM::Sys|/"listen"> method could be thrown.

=head2 accept

C<method accept : L<IO::Socket|SPVM::IO::Socket> ($peer_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[] = undef);>

Performs accept operation and returns a client socket object.

This method respects the inactivity L</"Timeout"> and the absolute L</"ReadDeadline">.

Returns a new client socket instance.

Exceptions:

If the absolute deadline is reached, a L<Go::Context::Error::DeadlineExceeded|SPVM::Go::Context::Error::DeadlineExceeded> exception is thrown.

Exceptions thrown by L<Sys#accept|SPVM::Sys|/"accept"> method could be thrown.

Exceptions thrown by L<Go#gosched_io_read|SPVM::Go/"gosched_io_read"> method could be thrown.

=head2 shutdown

C<method shutdown : void ($how : int);>

Performs shutdown operation given the way $how.

This method calls L<Sys#shutdown|SPVM::Sys/"shutdown"> method.

See L<Sys::Socket::Constant|SPVM::Sys::Socket::Constant> about constant values for $how: C<SHUT_RD>, C<SHUT_WR>, C<SHUT_RDWR>.

Exceptions:

Exceptions thrown by L<Sys#shutdown|SPVM::Sys/"shutdown"> method could be thrown.

=head2 close

C<method close : void ();>

Closes the socket file descriptor.

Exceptions:

If this socket is not opened or already closed, an exception is thrown.

=head2 recvfrom

C<method recvfrom : int ($buffer : mutable string, $length : int, $flags : int, $from_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[], $offset : int = 0)>

Performs recvfrom operation and returns read length.

If no data is available, it yields until the socket is ready, the B<inactivity timeout> (L</"Timeout">) expires, or the B<read deadline> (L</"ReadDeadline">) is reached.

Exceptions:

If the absolute deadline is reached, a L<Go::Context::Error::DeadlineExceeded|SPVM::Go::Context::Error::DeadlineExceeded> exception is thrown.

Exceptions thrown by L<Sys#recvfrom|SPVM::Sys/"recvfrom"> method could be thrown.

Exceptions thrown by L<Go#gosched_io_read|SPVM::Go/"gosched_io_read"> method could be thrown (e.g., L<Go::Error::IOTimeout|SPVM::Go::Error::IOTimeout>).

=head2 sendto

C<method sendto : int ($buffer : string, $flags : int, $to : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>, $length : int = -1, $offset : int = 0);>

Performs sendto operation and returns write length.

If the transmit buffer is full, it yields until space becomes available, the B<inactivity timeout> (L</"Timeout">) expires, or the B<write deadline> (L</"WriteDeadline">) is reached.

Exceptions:

If the absolute deadline is reached, a L<Go::Context::Error::DeadlineExceeded|SPVM::Go::Context::Error::DeadlineExceeded> exception is thrown.

Exceptions thrown by L<Sys#sendto|SPVM::Sys/"sendto"> method could be thrown.

Exceptions thrown by L<Go#gosched_io_write|SPVM::Go/"gosched_io_write"> method could be thrown (e.g., L<Go::Error::IOTimeout|SPVM::Go::Error::IOTimeout>).

=head2 recv

C<method recv : int ($buffer : mutable string, $length : int = -1, $flags : int = 0, $offset : int = 0);>

Performs recv operation by calling L</"recvfrom"> with $from_ref set to undef.

Exceptions:

Exceptions thrown by L</"recvfrom"> method could be thrown.

=head2 send

C<method send : int ($buffer : string, $flags : int = 0, $length : int = -1, $offset : int = 0);>

Performs send operation by calling L</"sendto"> with $to set to undef.

Exceptions:

Exceptions thrown by L</"sendto"> method could be thrown.

=head2 sysread

C<method sysread : int ($buffer : mutable string, $length : int = -1, $offset : int = 0);>

Perform sysread operation by calling L</"recv"> with $flags set to 0.

Exceptions:

Exceptions thrown by L</"recv"> method could be thrown.

=head2 syswrite

C<method syswrite : int ($buffer : string, $length : int = -1, $offset : int = 0);>

Perform syswrite operation by calling L</"send"> with $flags set to 0.

Exceptions:

Exceptions thrown by L</"send"> method could be thrown.

=head2 sockname

C<method sockname : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns a L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> for the local address.

Exceptions:

Exceptions thrown by L<Sys#getsockname|SPVM::Sys/"getsockname"> method could be thrown.

=head2 peername

C<method peername : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns a L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> for the remote address.

Exceptions:

Exceptions thrown by L<Sys#getpeername|SPVM::Sys/"getpeername"> method could be thrown.

=head2 connected

C<method connected : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Checks if the socket is connected. Returns a L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> if L</"peername"> succeeds, otherwise returns undef.

=head2 atmark

C<method atmark : int ();>

Calls L<Sys::Socket#sockatmark|SPVM::Sys::Socket/"sockatmark"> and returns the result.

Exceptions:

Exceptions thrown by L<Sys::Socket#sockatmark|SPVM::Sys::Socket/"sockatmark"> method could be thrown.

=head2 sockopt

C<method sockopt : int ($level : int, $option_name : int);>

Gets a socket option by calling L<Sys#getsockopt|SPVM::Sys/"getsockopt">.

Exceptions:

Exceptions thrown by L<Sys#getsockopt|SPVM::Sys/"getsockopt"> method could be thrown.

=head2 setsockopt

C<method setsockopt : void ($level : int, $option_name : int, $option_value : object of string|L<Int|SPVM::Int>);>

Sets a socket option by calling L<Sys#setsockopt|SPVM::Sys/"setsockopt">.

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

This class is a port of Perl's L<IO::Socket|IO::Socket> to L<SPVM>.

=head1 Copyright & License

Copyright (c) 2026 Yuki Kimoto

MIT License

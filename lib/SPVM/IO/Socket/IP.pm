package SPVM::IO::Socket::IP;

1;

=head1 Name

SPVM::IO::Socket::IP - IPv4/IPv6 Sockets

=head1 Usage

  use IO::Socket::IP;
  use Sys::Socket;
  use Sys::Socket::Constant as SOCKET;

  # Socket
  my $host = "google.com";
  my $port = 80;
  my $io_socket = IO::Socket::IP->new({
    PeerAddr => $host,
    PeerPort => $port
  });
  
  my $io_socket = IO::Socket::IP->new({
    PeerAddr => 'www.perl.org',
    PeerPort => 80,
    Proto    => SOCKET->IPPROTO_TCP
  });
 
  my $io_socket = IO::Socket::IP->new({
    Listen    => 5,
    LocalAddr => 'localhost',
    LocalPort => 9000,
    Proto     => SOCKET->IPPROTO_TCP
  });
   
  my $io_socket = IO::Socket::IP->new({
    PeerPort  => 9999,
    PeerAddr  => Sys::Socket->inet_ntoa(SOCKET->INADDR_BROADCAST),
    Proto     => SOCKET->IPPROTO_UDP,
    LocalAddr => 'localhost',
    Broadcast => 1
  })

=head1 Description

The IO::Socket::INET class in L<SPVM> has methods to create IPv4/IPv6 Sockets.

=head1 Super Class

L<IO::Socket|SPVM::IO::Socket>

=head1 Fields

=head2 LocalAddr

C<has LocalAddr : protected string;>

A local address.

=head2 LocalPort

C<has LocalPort : protected int;>

A local port.

=head2 PeerAddr

C<has PeerAddr : protected string;>

A remote address.

=head2 PeerPort

C<has PeerPort : protected int;>

A remote port

=head2 ReuseAddr

C<has ReuseAddr : protected int;>

If this field is a true value, The L<SO_REUSEADDR|https://linux.die.net/man/3/setsockopt> socket option is set.

=head2 ReusePort

C<has ReusePort : protected int;>

If this field is a true value, The C<SO_REUSEPORT> socket option is set.

=head2 Broadcast

C<has Broadcast : protected int;>

If this field is a true value, The L<SO_BROADCAST|https://linux.die.net/man/3/setsockopt> socket option is set.

=head1 Class Methods

=head2 new

  static method new : IO::Socket::IP ($options : object[] = undef);

Options:

Adding the following options, options in L<IO::Socket#new|SPVM::IO::Socket/new> method can be used.

=over 2

=item * ReuseAddr : string
  
=item * ReusePort : Int
  
=item * Broadcast : Int

=item * PeerAddr : string

=item * PeerPort : Int

=item * LocalAddr : string

=item * LocalPort : Int

=item * Proto : Int

=item * Timeout : Int

=item * Domain : Int

=item * Type : Int

=item * Blocking : Int

=item * Listen : Int

=back

=head1 Instance Methods

=head2 init

C<protected method init : void ($options : object[] = undef);>

=head2 sockaddr

C<method sockaddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

Returns the local address.

=head2 sockhost

C<method sockhost : string ();>

Returns the local host name.

=head2 sockport

C<method sockport : int ();>

Returns the local port.

=head2 peeraddr

C<method peeraddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

Return the remote address.

=head2 peerhost

C<method peerhost : string ();>

Returns the remote host name.

=head2 peerport

C<method peerport : int ();>

Returns the remote port.

=head1 Well Known Child Classes

=over 2

=item * L<IO::Socket::INET|SPVM::IO::Socket::INET>

=item * L<IO::Socket::INET6|SPVM::IO::Socket::INET6>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


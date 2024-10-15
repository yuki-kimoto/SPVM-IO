package SPVM::IO::Socket::IP;

1;

=head1 Name

SPVM::IO::Socket::IP - IPv4/IPv6 Sockets

=head1 Usage

  use IO::Socket::IP;
  use Sys::Socket::Constant as SOCKET;
  
  # Client Socket
  my $host = "www.perl.org";
  my $port = 80;
  my $socket = IO::Socket::IP->new({
    PeerAddr => $host,
    PeerPort => $port
  });
  
  # Server Socket
  my $socket = IO::Socket::IP->new({
    LocalAddr => 'localhost',
    LocalPort => 9000,
    Listen    => 5,
  });
   
  # IPv6 Client Socket
  my $host = "google.com";
  my $port = 80;
  my $socket = IO::Socket::IP->new({
    PeerAddr => $host,
    PeerPort => $port,
    Domain => SOCKET->AF_INET6,
  });

=head1 Description

IO::Socket::INET class in L<SPVM> represents an IPv4 or IPv6 socket.

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

A peer address.

=head2 PeerPort

C<has PeerPort : protected int;>

A peer port.

=head2 ReuseAddr

C<has ReuseAddr : protected int;>

If this field is a true value, L<SO_REUSEADDR|https://linux.die.net/man/3/setsockopt> socket option is set.

=head2 ReusePort

C<has ReusePort : protected int;>

If this field is a true value, C<SO_REUSEPORT> socket option is set.

=head2 Broadcast

C<has Broadcast : protected int;>

If this field is a true value, L<SO_BROADCAST|https://linux.die.net/man/3/setsockopt> socket option is set.

=head1 Class Methods

=head2 new

C<static method new : L<IO::Socket::IP|SPVM::IO::Socket::IP> ($options : object[] = undef);>

Creates a new L<IO::Socket::IP|SPVM::IO::Socket::IP> object given the options $options, and returns it.

This object represents a IPv4 or IPv6 domain socket.

If L</"ReuseAddr"> field is a true value, 1 is set to C<SO_REUSEADD> option of this socket.

If L</"ReusePort"> field is a true value, 1 is set to C<SO_REUSEPORT> option of this socket.

If L</"Broadcast"> field is a true value, 1 is set to C<SO_BROADCAST> option of this socket.

If L</"PeerAddr"> field is specified, this object becomes a client socket. It calls L<connect|SPVM::IO::Socket/"connect"> method.

If L<Listen|SPVM::IO::Socket/"Listen"> field is a positive value, this object becomes a server socket. It calls L<bind|SPVM::IO::Socket/"bind"> method and L<listen|SPVM::IO::Socket/"listen"> method.

See L</"init"> method about the options $options.

The blocking mode of the socket is set to non-blocking mode.

=head1 Instance Methods

=head2 init

C<protected method init : void ($options : object[] = undef);>

Initializes fields of this instance given the option $options.

Options:

The following options are available adding the options for L<IO::Socket#init|SPVM::IO::Socket/"init"> method are available.

[Name][Type][Default Value]

=over 2

=item * C<ReuseAddr> : string = undef

L</"ReuseAddr"> field is set to this value.

=item * C<ReusePort> : Int = 0

L</"ReusePort"> field is set to this value.

=item * C<Broadcast> : Int = 0

L</"Broadcast"> field is set to this value.

=item * C<PeerAddr> : string = undef

L</"PeerAddr"> field is set to this value.

=item * C<PeerPort> : Int = 0

L</"PeerPort"> field is set to this value.

=item * C<LocalAddr> : string = undef

L</"LocalAddr"> field is set to this value.

=item * C<LocalPort> : Int = 0

L</"LocalPort"> field is set to this value.

=back

L<Domain|SPVM::IO::Socket/"Domain"> field is set to C<AF_INET> if C<Domain> option is not specified.

L<Proto|SPVM::IO::Socket/"Proto"> field is set to C<IPPROTO_TCP> if C<Proto> option is not specified.

L<Type|SPVM::IO::Socket/"Type"> field is set to the following value according to the value of L<Proto|SPVM::IO::Socket/"Proto"> field.

If the value of C<Proto> is C<IPPROTO_TCP>, the C<Type> field is set to C<SOCK_STREAM>.

If the value of C<Proto> is C<IPPROTO_UDP>, the C<Type> field is set to C<SOCK_DGRAM>.

=head2 sockaddr

C<method sockaddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

Returns the local address.

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#sockaddr|SPVM::IO::Socket::IP::Import::IPv4/"sockaddr"> method.

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#sockaddr|SPVM::IO::Socket::IP::Import::IPv6/"sockaddr"> method.

=head2 sockhost

C<method sockhost : string ();>

Returns the local host name.

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#sockhost|SPVM::IO::Socket::IP::Import::IPv4/"sockhost"> method.

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#sockhost|SPVM::IO::Socket::IP::Import::IPv6/"sockhost"> method.

=head2 sockport

C<method sockport : int ();>

Returns the local port.

Implementation:

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#sockport|SPVM::IO::Socket::IP::Import::IPv4/"sockport"> method.

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#sockport|SPVM::IO::Socket::IP::Import::IPv6/"sockport"> method.

=head2 peeraddr

C<method peeraddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

Return the peer address.

Implementation:

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#peeraddr|SPVM::IO::Socket::IP::Import::IPv4/"peeraddr"> method.

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#peeraddr|SPVM::IO::Socket::IP::Import::IPv6/"peeraddr"> method.

=head2 peerhost

C<method peerhost : string ();>

Returns the peer host name.

Implementation:

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#peerhost|SPVM::IO::Socket::IP::Import::IPv4/"peerhost"> method.

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#peerhost|SPVM::IO::Socket::IP::Import::IPv6/"peerhost"> method.

=head2 peerport

C<method peerport : int ();>

Returns the peer port.

Implementation:

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#peerport|SPVM::IO::Socket::IP::Import::IPv4/"peerport"> method.

If L<Domain|SPVM::IO::Socket/"Domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#peerport|SPVM::IO::Socket::IP::Import::IPv6/"peerport"> method.

=head2 accept

C<method accept : L<IO::Socket::IP|SPVM::IO::Socket::IP> ($peer_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[] = undef);>

This method is the same as L<accept|SPVM::IO::Socket/"accept"> method, but its return type is different.

=head1 Well Known Child Classes

=over 2

=item * L<IO::Socket::INET|SPVM::IO::Socket::INET>

=item * L<IO::Socket::INET6|SPVM::IO::Socket::INET6>

=back

=head2 See Also

=over 2

=item * L<SPVM::IO::Socket::UNIX>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


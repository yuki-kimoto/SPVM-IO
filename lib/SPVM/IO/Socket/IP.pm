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
    Context => Go->bg,
    PeerAddr => $host,
    PeerPort => $port
  });
  
  # Server Socket
  my $socket = IO::Socket::IP->new({
    Context => Go->bg,
    LocalAddr => 'localhost',
    LocalPort => 9000,
    Listen    => 0, # SOMAXCONN
  });
   
  # IPv6 Client Socket
  my $host = "google.com";
  my $port = 80;
  my $socket = IO::Socket::IP->new({
    Context => Go->bg,
    PeerAddr => $host,
    PeerPort => $port,
    Domain => SOCKET->AF_INET6,
  });

=head1 Description

IO::Socket::INET class in L<SPVM> represents an IPv4 or IPv6 socket.

=head1 Super Class

L<IO::Socket|SPVM::IO::Socket>

=head1 Fields

=head2 local_addr

C<has local_addr : protected string;>

A local address.

=head2 local_port

C<has local_port : protected int;>

A local port.

=head2 peer_addr

C<has peer_addr : protected string;>

A peer address.

=head2 peer_port

C<has peer_port : protected int;>

A peer port.

=head2 reuse_addr

C<has reuse_addr : protected byte;>

The value of L<SO_REUSEADDR|https://linux.die.net/man/3/setsockopt> socket option.

This field expects a boolean value.

=head2 reuse_port

C<has reuse_port : protected byte;>

The value of C<SO_REUSEPORT> socket option.

This field expects a boolean value.

=head2 broadcast

C<has broadcast : protected byte;>

The value of L<SO_BROADCAST|https://linux.die.net/man/3/setsockopt> socket option.

This field expects a boolean value.

=head2 v6_only

  has v6_only : byte;

The value of L<IPV6_V6ONLY|https://man7.org/linux/man-pages/man7/ipv6.7.html> socket option.

This field expects a boolean value.

=head2 v6_only_specified

  has v6_only_specified : byte;

If this field is a true value, C<v6_only> option is specified on L</"init"> method.

=head1 Class Methods

=head2 new

C<static method new : L<IO::Socket::IP|SPVM::IO::Socket::IP> ($options : object[] = undef);>

Creates a new L<IO::Socket::IP|SPVM::IO::Socket::IP> object given the options $options, and returns it.

This object represents a IPv4 or IPv6 domain socket.

If L</"reuse_addr"> field is a true value, C<SO_REUSEADD> option of this socket is set to 1.

If L</"reuse_addr"> field is a true value, C<SO_REUSEADD> option of this socket is set to 1.

If L</"reuse_port"> field is a true value, C<SO_REUSEPORT> option of this socket is set to 1.

If L</"broadcast"> field is a true value, C<SO_BROADCAST> option of this socket is set to 1.

If the value of L</"v6_only_specified"> field is a true value, C<IPV6_V6ONLY> option of this socket is set to the following value.

If the value of L</"v6_only"> field is a true value, it is set to 1, otherwise 0.

If L</"peer_addr"> field is specified, this object becomes a client socket. It calls L<connect|SPVM::IO::Socket/"connect"> method.

If L<Listen|SPVM::IO::Socket/"Listen"> field is specified, this object becomes a server socket. It calls L<listen|SPVM::IO::Socket/"listen"> method. If the value of C<Listen> is 0 or less, C<SOMAXCONN> is automatically used. Furthermore.

The L<bind|SPVM::IO::Socket/"bind"> method is called when either L<local_addr|SPVM::IO::Socket/"local_addr"> or L<local_port|SPVM::IO::Socket/"local_port"> is specified.

See L</"init"> method about the options $options.

=head1 Instance Methods

=head2 init

C<protected method init : void ($options : object[] = undef);>

Initializes fields of this instance given the option $options.

Options:

The following options are available adding the options for L<IO::Socket#init|SPVM::IO::Socket/"init"> method are available.

Nagle algorizm is on over TCP.

[Name][Type][Default Value]

=over 2

=item * C<ReuseAddr> : string = undef

L</"reuse_addr"> field is set to this value.

=item * C<ReusePort> : Int = 0

L</"reuse_port"> field is set to this value.

=item * C<Broadcast> : Int = 0

L</"broadcast"> field is set to this value.

=item * C<PeerAddr> : string = undef

L</"peer_addr"> field is set to this value.

=item * C<PeerPort> : Int = 0

L</"peer_port"> field is set to this value.

=item * C<LocalAddr> : string = undef

L</"local_addr"> field is set to this value.

=item * C<LocalPort> : Int = 0

L</"local_port"> field is set to this value.

=item * C<V6Only> : Int = undef

If this option is specified, L</"v6_only_specified"> is set to 1 and L</"v6_only"> field is set to this value.

=back

L<domain|SPVM::IO::Socket/"domain"> field is set to C<AF_INET> if C<Domain> option is not specified.

If L</"domain"> is not specified and L</"local_addr"> or L</"peer_addr"> is a valid IPv6 address, the default value of L</"domain"> is automatically set to C<AF_INET6>.

L<type|SPVM::IO::Socket/"type"> field is set to C<SOCK_STREAM> if C<Type> option is not specified.

=head2 configure

C<protected method configure : void ();>

Configures the socket.

=head2 sockaddr

C<method sockaddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

Returns the local address.

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#sockaddr|SPVM::IO::Socket::IP::Import::IPv4/"sockaddr"> method.

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#sockaddr|SPVM::IO::Socket::IP::Import::IPv6/"sockaddr"> method.

=head2 sockhost

C<method sockhost : string ();>

Returns the local host name.

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#sockhost|SPVM::IO::Socket::IP::Import::IPv4/"sockhost"> method.

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#sockhost|SPVM::IO::Socket::IP::Import::IPv6/"sockhost"> method.

=head2 sockport

C<method sockport : int ();>

Returns the local port.

Implementation:

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#sockport|SPVM::IO::Socket::IP::Import::IPv4/"sockport"> method.

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#sockport|SPVM::IO::Socket::IP::Import::IPv6/"sockport"> method.

=head2 peeraddr

C<method peeraddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

Return the peer address.

Implementation:

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#peeraddr|SPVM::IO::Socket::IP::Import::IPv4/"peeraddr"> method.

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#peeraddr|SPVM::IO::Socket::IP::Import::IPv6/"peeraddr"> method.

=head2 peerhost

C<method peerhost : string ();>

Returns the peer host name.

Implementation:

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#peerhost|SPVM::IO::Socket::IP::Import::IPv4/"peerhost"> method.

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#peerhost|SPVM::IO::Socket::IP::Import::IPv6/"peerhost"> method.

=head2 peerport

C<method peerport : int ();>

Returns the peer port.

Implementation:

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#peerport|SPVM::IO::Socket::IP::Import::IPv4/"peerport"> method.

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#peerport|SPVM::IO::Socket::IP::Import::IPv6/"peerport"> method.

=head2 accept

C<method accept : L<IO::Socket::IP|SPVM::IO::Socket::IP> ($context : Go::Context, $peer_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[] = undef);>

This method is the same as L<accept|SPVM::IO::Socket/"accept"> method, but its return type is different.

=head2  create_sockaddr

C<protected method create_sockaddr : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ($address : string, $port : int);>

Creates a L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> object given the address $address and the port $port.

$address is allowed to be a domain name, a host name, an IP address. The name resolution is performed in a non-blocking way.

Implementation:

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET>, this method calls L<IO::Socket::IP::Import::IPv4#create_sockaddr|SPVM::IO::Socket::IP::Import::IPv4/"create_sockaddr"> method.

If L<domain|SPVM::IO::Socket/"domain"> field is C<AF_INET6>, this method calls L<IO::Socket::IP::Import::IPv6#create_sockaddr|SPVM::IO::Socket::IP::Import::IPv6/"create_sockaddr"> method.

=head1 Well Known Child Classes

=over 2

=item * L<IO::Socket::INET|SPVM::IO::Socket::INET>

=item * L<IO::Socket::INET6|SPVM::IO::Socket::INET6>

=back

=head2 See Also

=over 2

=item * L<IO::Socket|SPVM::IO::Socket>

=item * L<IO::Handle|SPVM::IO::Handle>

=item * L<IO|SPVM::IO>

=item * L<IO::Socket::UNIX|SPVM::IO::Socket::UNIX>

=item * L<Sys::Socket|SPVM::Sys::Socket>

=item * L<Sys::Socket::Util|SPVM::Sys::Socket::Util>

=item * L<Sys::Socket::Constant|SPVM::Sys::Socket::Constant>

=item * L<Net::DNS::Native|SPVM::Net::DNS::Native>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License

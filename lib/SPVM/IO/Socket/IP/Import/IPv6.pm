package SPVM::IO::Socket::IP::Import::IPv6;



1;

=head1 Name

SPVM::IO::Socket::IP::Import::IPv6 - Importable Methods for IPv6

=head1 Description

IO::Socket::IP::Import::IPv6 interface in L<SPVM> provides importable methods for IPv6.

=head1 Usage

  use IO::Socket::IP::Import::IPv6;

=head1 Interface Methods

=head2 sockname

C<method sockname : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> object containing a local address and a local port.

The type of the returned value is L<Sys::Socket::Sockaddr::In6|SPVM::Sys::Socket::Sockaddr::In6>.

This method must be implemented by the class that declares this interface.

=head2 peername

C<method peername : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

Returns a L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> object containing a remote address and a local port.

The type of the returned value is L<Sys::Socket::Sockaddr::In6|SPVM::Sys::Socket::Sockaddr::In6>.

This method must be implemented by the class that declares this interface.

=head1 Instance Methods

=head2 sockaddr

C<method sockaddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

Returns a local address.

The type of the returned object is L<Sys::Socket::In6_addr|SPVM::Sys::Socket::In6_addr>.

=head2 sockhost

C<method sockhost : string ();>

Returns a local host name.

=head2 sockport

C<method sockport : int ();>

Returns a local port.

=head2 peeraddr

C<method peeraddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

Returns a remote address.

The type of the returned object is L<Sys::Socket::In6_addr|SPVM::Sys::Socket::In6_addr>.

=head2 peerhost

C<method peerhost : string ();>

Returns a remote host name.

=head2 peerport

C<method peerport : int ();>

Returns a remote port.

=head2 create_sockaddr

C<method create_sockaddr : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ($address : string, $port : int);>

Creates a L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> object given the address $address and the port $port.

$address is allowed to be a domain name, a host name, an IP address.

The type of the returned value is L<Sys::Socket::Sockaddr::In6|SPVM::Sys::Socket::Sockaddr::In6>.

Implementation:

This method resolves $address using L<Net::DNS::Native#getaddrinfo|SPVM::Net::DNS::Native/"getaddrinfo"> method in non-blocking way and creates a L<Sys::Socket::Sockaddr::In6|SPVM::Sys::Socket::Sockaddr::In6> object from the resolved IP address and $port.

=head1 Copyright & License

Copyright (c) 2024 Yuki Kimoto

MIT License


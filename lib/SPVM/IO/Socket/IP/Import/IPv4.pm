package SPVM::IO::Socket::IP::Import::IPv4;



1;

=head1 Name

SPVM::IO::Socket::IP::Import::IPv4 - Short Description

=head1 Description

The IO::Socket::IP::Import::IPv4 class in L<SPVM> has methods to do someting.

=head1 Usage

  use IO::Socket::IP::Import::IPv4;

=head1 Interface Methods

=head2 peername

C<method peername : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

An interface method to return the information containing the remote address and port.

=head2 sockname

C<method sockname : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr> ();>

An interface method to return the information containing the local address and port.

=head2 sockaddr

C<method sockaddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

An interface method with a default implementation to return the local address.

The local address is a L<Sys::Socket::In_addr|SPVM::Sys::Socket::In_addr> object.

=head2 sockport

C<method sockport : int ();>

An interface method with a default implementation to return the local port.

=head2 sockhost

C<method sockhost : string ();>

An interface method with a default implementation to return the local host name.

=head2 peeraddr

C<method peeraddr : L<Sys::Socket::In_addr_base|SPVM::Sys::Socket::In_addr_base> ();>

An interface method with a default implementation to return the remote address.

The remote address is a L<Sys::Socket::In_addr|SPVM::Sys::Socket::In_addr> object.

=head2 peerport

C<method peerport : int ();>

An interface method with a default implementation to return the port.

=head2 peerhost

C<method peerhost : string ();>

An interface method with a default implementation to return the remote host name.

=head1 Copyright & License

Copyright (c) 2024 Yuki Kimoto

MIT License


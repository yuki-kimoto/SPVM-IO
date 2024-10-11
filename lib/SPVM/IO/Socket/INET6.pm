package SPVM::IO::Socket::INET6;

1;

=head1 Name

SPVM::IO::Socket::INET6 - IPv6 Sockets

=head1 Usage

  use IO::Socket::INET6;
  
  my $host = "google.com";
  my $port = 80;
  my $socket = IO::Socket::INET6->new({
    PeerAddr => $host,
    PeerPort => $port
  });

=head1 Description

IO::Socket::INET6 class in L<SPVM> represents a IPv6 Socket.

=head1 Super Class

L<IO::Socket::IP|SPVM::IO::Socket::IP>

=head1 Class Methods

=head2 new

C<static method new : L<IO::Socket::INET6|SPVM::IO::Socket::INET6> ($options : object[] = undef);>

This method is the same as L<SPVM::IO::Socket::IP#new> method, but the C<Domain> option is always set to C<AF_INET6>.

=head2 accept

C<method accept : L<IO::Socket::INET6|SPVM::IO::Socket::INET6> ($peer_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[] = undef);>

This method is the same as L<accept|SPVM::IO::Socket/"accept"> method, but its return type is different.

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


package SPVM::IO::Socket::INET;

1;

=head1 Name

SPVM::IO::Socket::INET - IPv4 Sockets

=head1 Usage

  use IO::Socket::INET;
  
  my $host = "google.com";
  my $port = 80;
  my $socket = IO::Socket::INET->new({
    PeerAddr => $host,
    PeerPort => $port
  });

=head1 Description

IO::Socket::INET class in L<SPVM> represents a IPv4 Socket.

=head1 Super Class

L<IO::Socket::IP|SPVM::IO::Socket::IP>

=head1 Class Methods

=head2 new

C<static method new : L<IO::Socket::INET|SPVM::IO::Socket::INET> ($options : object[] = undef);>

This method is the same as L<SPVM::IO::Socket::IP#new> method, but the C<Domain> option is always set to C<AF_INET>.

=head2 accept

C<method accept : L<IO::Socket::INET|SPVM::IO::Socket::INET> ($peer_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[] = undef);>

This method is the same as L<accept|SPVM::IO::Socket/"accept"> method, but its return type is different.

=head2 See Also

=over 2

=item * L<IO::Socket::IP|SPVM::IO::Socket::IP>

=item * L<IO::Socket|SPVM::IO::Socket>

=item * L<IO::Handle|SPVM::IO::Handle>

=item * L<IO|SPVM::IO>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


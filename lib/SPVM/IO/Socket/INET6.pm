package SPVM::IO::Socket::INET6;

1;

=head1 Name

SPVM::IO::Socket::INET6 - IPv6 Sockets

=head1 Usage

  use IO::Socket::INET6;
  
  my $host = "google.com";
  my $port = 80;
  my $io_socket = IO::Socket::INET6->new({
    PeerAddr => $host,
    PeerPort => $port
  });

=head1 Description

The IO::Socket::INET6 class in L<SPVM> has methods to create IPv6 Sockets.

=head1 Super Class

L<IO::Socket::IP|SPVM::IO::Socket::IP>

=head1 Class Methods

=head2 new

C<static method new : L<IO::Socket::INET6|SPVM::IO::Socket::INET6> ($options : object[] = undef);>

Same as L<SPVM::IO::Socket::IP#new> method, but the C<Domain> option is set to the return value of L<Sys::Socket::Constant#AF_INET6|SPVM::Sys::Socket::Constant/AF_INET6> method.

Options:

The options for L<IO::Socket#new|SPVM::IO::Socket/"new"> method are available.

=head2 accept

C<method accept : L<IO::Socket::INET6|SPVM::IO::Socket::INET6> ($peer_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[] = undef);>

Calls L<accept|SPVM::IO::Socke/"new"> method of its super class given the argument given to this method and returns its return value.

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


package SPVM::IO::Socket::INET;

our $VERSION = '0.01';

1;

=head1 Name

SPVM::IO::Socket::INET - IO::Socket::INET provide provides IPv4 socket methods

=head1 Usage

  use IO::Socket::INET;
  use Sys::Socket;
  use Sys::Socket::Constant as SOCKET;

  my $sock = IO::Socket::INET->new(PeerAddr => 'www.perl.org',
                                PeerPort => 80,
                                Proto    => SOCKET->IPPROTO_TCP);
 
  my $sock = IO::Socket::INET->new(Listen    => 5,
                                LocalAddr => 'localhost',
                                LocalPort => 9000,
                                Proto     => SOCKET->IPPROTO_TCP);
   
  my $sock = IO::Socket::INET->new(
                          PeerPort  => 9999,
                          PeerAddr  => Sys::Socket->inet_ntoa(SOCKET->INADDR_BROADCAST),
                          Proto     => SOCKET->IPPROTO_UDP,
                          LocalAddr => 'localhost',
                          Broadcast => 1 )
=head1 Description

C<IO::Socket::INET> is a L<SPVM> module.

=head1 Fields



=head1 Class Methods



=head1 Instance Methods



=head1 Repository



=head1 Author

Yuki Kimoto C<kimoto.yuki@gmail.com>

=head1 Copyright & License

Copyright 2022-2022 Yuki Kimoto, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


package SPVM::IO::Socket::UNIX;



1;

=head1 Name

SPVM::IO::Socket::UNIX - UNIX Domain Socket

=head1 Description

IO::Socket::UNIX class in L<SPVM> represents a UNIX domain socket.

=head1 Usage

  use IO::Socket::UNIX;
  
  # Client
  my $sock_path = "/tmp/test.sock";
  my $socket = IO::Socket::UNIX->new({
    Peer => $sock_path,
  });
  
  # Server
  my $sock_path = "/tmp/test.sock";
  my $socket = IO::Socket::UNIX->new({
    Local => $sock_path,
    Listen    => 5,
  });

=head1 Super Class

L<IO::Socket|SPVM::IO::Socket>

=head1 Fields

=head2 Local

C<has Local : string;>

A local path.

=head2 Peer

C<has Peer : string;>

A peer path.

=head1 Class Methods

=head2 new

C<static method new : L<IO::Socket::UNIX|SPVM::IO::Socket::UNIX> ($options : object[] = undef);>

Creates a new L<IO::Socket::UNIX|SPVM::IO::Socket::UNIX> object given the options $options, and returns it.

This object represents a UNIX domain socket.

If L</"Peer"> field is specified, this object becomes a client socket. It calls L<connect|SPVM::IO::Socket/"connect"> method.

If L</"Local"> field is specified, this object becomes a server socket. It calls L<bind|SPVM::IO::Socket/"bind"> method and L<listen|SPVM::IO::Socket/"listen"> method.

See L</"init"> method about the options $options.

The blocking mode of the socket is set to non-blocking mode.

=head1 Instance Methods

=head2 init

C<protected method init : void ($options : object[] = undef);>

Initializes fields of this instance given the options $options.

Options:

The following options are available adding the options for L<IO::Socket#init|SPVM::IO::Socket/"init"> method are available.

=over 2

=item * C<Peer> : string

L</"Peer"> field is set to this value.

=item * C<Local> : string

L</"Local"> field is set to this value.

=back

L<Domain|IO::Socket#Domain> field is always set to C<AF_UNIX>.

L<Type|IO::Socket#Type> field is set to SOCK_STREAM if C<Type> option is not specified.

L<Proto|IO::Socket#Proto> field is always set to 0.

=head2 hostpath

C<method hostpath : string ();>

Returns the pathname to the fifo at the local end.

=head2 peerpath

C<method peerpath : string ();>

Returns the pathanme to the fifo at the peer end.

=head2 accept

C<method accept : L<IO::Socket::UNIX|SPVM::IO::Socket::UNIX> ($peer_ref : L<Sys::Socket::Sockaddr|SPVM::Sys::Socket::Sockaddr>[] = undef);>

This method is the same as L<accept|SPVM::IO::Socket/"accept"> method, but its return type is different.

=head1 FAQ

=head2 How to create a temporary file for a UNIX domain socket?

Use L<File::Temp|SPVM::File::Temp> class.

  my $tmp_dir = File::Temp->newdir;
  
  my $tmp_dir_name = $tmp_dir->dirname;
  
  my $tmp_file = "$tmp_dir_name/test.sock";

=head2 Does a Unix domain socket work on Windows?

Yes, if Windows is recent.

=head2 See Also

=over 2

=item * L<SPVM::IO::Socket::IP>

=back

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


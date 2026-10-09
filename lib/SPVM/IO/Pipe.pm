package SPVM::IO::Pipe;

1;

=head1 Name

SPVM::IO::Pipe - Non-blocking Pipes with Goroutines

=head1 Description

L<SPVM::IO::Pipe> provides a factory for creating a pair of connected, non-blocking pipe ends. It is designed to work seamlessly with L<SPVM::Go> for asynchronous inter-process or inter-goroutine communication.

=head1 Usage
  
  use IO::Pipe;
  use Go;

  # Create a non-blocking pipe pair
  my $pipe = IO::Pipe->new;
  my $handles = $pipe->handles;
  
  my $reader = $handles->[0];
  my $writer = $handles->[1];

=head1 Fields

=head2 handles

C<has handles : ro L<IO::Pipe::End|SPVM::IO::Pipe::End>[];>

An array containing two L<IO::Pipe::End|SPVM::IO::Pipe::End> instances representing both ends of the pipe.

=head1 Instance Methods

=head2 new

C<static method new : L<IO::Pipe|SPVM::IO::Pipe> ();>

Creates a new non-blocking pipe pair and returns an L<IO::Pipe|SPVM::IO::Pipe> instance containing the two pipe ends.

On Unix-like systems, this method creates a pair of connected non-blocking streams using C<socketpair>. On Windows, it creates a pair of non-blocking connected pipes (such as named pipes).

=head1 See Also

=over 2

=item * L<IO|SPVM::IO>

=back

=head1 Copyright & License

Copyright (c) 2026 Yuki Kimoto

MIT License

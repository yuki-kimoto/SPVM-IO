package SPVM::IO::Pipe::End;

1;

=head1 Name

SPVM::IO::Pipe::End - Pipe End with Goroutines and Deadlines

=head1 Description

L<SPVM::IO::Pipe::End> represents one end of a non-blocking pipe. It inherits from L<SPVM::IO::Handle> and is integrated with L<SPVM::Go> for cooperative scheduling and deadline management.

=head1 Usage
  
  use IO::Pipe;
  use Go;
  use Go::Time;

  my $pipe = IO::Pipe->new;
  my $handles =$pipe->handles;
  
  # Write data to the pipe
  $handles->[1]->syswrite("Hello SPVM Pipe");

  # Read data from the pipe
  my $buffer = (mutable string)new_string_len(100);
  $handles->[0]->sysread($buffer);

=head2 Goroutine and Non-blocking I/O

All I/O operations in this class (`sysread`, `syswrite`, etc.) are non-blocking and integrated with L<goroutines|SPVM::Go>.

If an I/O operation cannot be completed immediately, the current goroutine yields control to the Go scheduler, allowing other goroutines to run. When the pipe becomes ready, the goroutine is automatically resumed.

=head1 Super Class

L<IO::Handle|SPVM::IO::Handle>

=head1 Instance Methods

=head2 new

C<static method new : L<IO::Pipe::End|SPVM::IO::Pipe::End> ($options : object[] = undef);>

Creates a new L<IO::Pipe::End|SPVM::IO::Pipe::End> object by calling L</"init"> method with $options.

=head2 init

C<protected method init : void ($options : object[] = undef);>

Initializes the pipe end handle.

=head2 sysread

C<method sysread : int ($string : mutable string, $length : int = -1,$offset : int = 0);>

Performs non-blocking read operation on the pipe.

If no data is available, it yields until the pipe is ready, the inactivity timeout expires, or the read deadline is reached.

Exceptions:

Exceptions thrown by L<Go#gosched_pipe_read|SPVM::Go/"gosched_pipe_read"> method could be thrown.

=head2 syswrite

C<method syswrite : int ($string : string, $length : int = -1,$offset : int = 0);>

Performs non-blocking write operation on the pipe.

If the buffer is full, it yields until space becomes available, the inactivity timeout expires, or the write deadline is reached.

Exceptions:

Exceptions thrown by L<Go#gosched_pipe_write|SPVM::Go/"gosched_pipe_write"> method could be thrown.

=head2 close

C<method close : void ();>

Closes the pipe file descriptor and cancels any pending I/O operations on it.

Exceptions:

If this handle is not opened or already closed, an exception is thrown.

=head1 See Also

=over 2

=item * L<IO::Pipe|SPVM::IO::Pipe>

=item * L<IO|SPVM::IO>

=back

=head1 Copyright & License

Copyright (c) 2026 Yuki Kimoto

MIT License

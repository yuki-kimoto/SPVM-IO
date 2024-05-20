package SPVM::IO::Select;

1;

=head1 Name

SPVM::IO::Select - select System Call

=head1 Description

IO::Select class in L<SPVM> has methods for C<select> system call.

=head1 Usage

  use IO::Select;
  
  $select = IO::Select->new;
  
  $select->add($fd0);>
  $select->add($fd1);>
  
  my $read_ready_fds = $select->can_read($timeout);
  
  my $write_ready_fds = $select->can_write($timeout);

=head2 Details

This class a Perl's L<IO::Select|IO::Select> porting to L<SPVM>.

=head1 Fields

C<has handles_list : L<IntList|SPVM::IntList>;>

A list of file descriptors.

=head1 Class Methods

=head2 new

C<static method new : L<IO::Select|SPVM::IO::Select> ();>

Creates a new L<IO::Select|SPVM::IO::Select> object and returns it.

=head1 Instance Methods

=head2 add

C<method add : void ($handle : int);>

Adds the new file descriptor $handle.

=head2 remove

C<method remove : void ($handle : int);>

=head2 exists

C<method exists : int ($handle : int);>

=head2 handles

C<method handles : int[] ();>

=head2 can_read

C<method can_read : int[] ($timeout : double);>

=head2 can_write

C<method can_write : int[] ($timeout : double);>

=head2 has_exception

C<method has_exception : int[] ($timeout : double);>

=head1 See Also

=head1 Copyright & License

Copyright (c) 2023 Yuki Kimoto

MIT License


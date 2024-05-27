package SPVM::IO::Poll;



1;

=head1 Name

SPVM::IO::Poll - Short Description

=head1 Description

The IO::Poll class in L<SPVM> has methods to do someting.

=head1 Usage

  use IO::Poll;

=head1 Details



=head1 Inheritance



=head1 Interfaces



=head1 Enumerations



=head1 Fields



=head1 Class Methods



=head1 Instance Methods

  mask ( IO [, EVENT_MASK ] )
  
  If EVENT_MASK is given, then, if EVENT_MASK is non-zero, IO is added to the list of file descriptors and the next call to poll will check for any event specified in EVENT_MASK. If EVENT_MASK is zero then IO will be removed from the list of file descriptors.

  If EVENT_MASK is not given then the return value will be the current event mask value for IO.

  poll ( [ TIMEOUT ] )
  Call the system level poll routine. If TIMEOUT is not specified then the call will block. Returns the number of handles which had events happen, or -1 on error.

  events ( IO )
  Returns the event mask which represents the events that happened on IO during the last call to poll.

  remove ( IO )
  Remove IO from the list of file descriptors for the next poll.

  handles( [ EVENT_MASK ] )
  Returns a list of handles. If EVENT_MASK is not given then a list of all handles known will be returned. If EVENT_MASK is given then a list of handles will be returned which had one of the events specified by EVENT_MASK happen during the last call ti poll  
}



=head1 Repository



=head1 Author

Yuki Kimoto C<kimoto.yuki@gmail.com>

=head1 Copyright & License

Copyright (c) 2024 Yuki Kimoto

MIT License


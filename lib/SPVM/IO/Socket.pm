package SPVM::IO::Socket;

1;

=head1 Name

SPVM::IO::Socket - Socket Communications

=head1 Usage
  
  use IO::Socket;
  use Sys::Socket::Constant as SOCKET;
  
  # Create a new AF_INET socket
  my $sock = IO::Socket->new({Domain => SOCKET->AF_INET});

  # Create a new AF_INET6 socket
  my $sock = IO::Socket->new({Domain => SOCKET->AF_INET6});
  
  # Create a new AF_UNIX socket
  my $sock = IO::Socket->new({Domain => SOCKET->AF_UNIX});

=head1 Description

L<SPVM::IO::Socket> provides socket communications.

=head1 Fields

=head2 timeout

  has timeout : protected ro int;
  
=head2 sockdomain

  has sockdomain : protected ro int;
  
=head2 socktype

  has socktype : protected ro int;
  
=head2 protocol

  has protocol : protected ro int;
  
=head2 peername

  has peername : protected ro Sys::Socket::Sockaddr;

=head2 fd

  has fd : protected int;

=head2 listen_backlog

  has listen_backlog : protected int;

=head1 Class Methods

=head2 new

  static method new : IO::Socket ($options = undef : object[]);

=head1 Instance Methods

=head2 init

  method init : void ($options = undef : object[]);

=head2 

  static method connect : IO::Socket ($host : string, $port : int) {
    
    my $self = new IO::Socket;

    # Socket fd
    my $fd = Sys::Socket->socket(SOCKET->AF_INET, SOCKET->SOCK_STREAM, 0);
    
    $self->{fd} = $fd;
    
    # Socket information
    my $socket_address = Sys::Socket::Sockaddr::In->new;
    $socket_address->set_sin_family((byte)SOCKET->AF_INET);
    $socket_address->set_sin_port(Sys::Socket->htons((short)$port));

    my $res_ref = new Sys::Socket::AddrinfoLinkedList[1];
    Sys::Socket->getaddrinfo($host, undef, undef, $res_ref);
    my $res = $res_ref->[0];
    
    if ($res) {
      my $res_array = $res->to_array;
      $socket_address->set_sin_addr($res_array->[0]->copy_ai_addr->(Sys::Socket::Sockaddr::In)->copy_sin_addr);
    }
    else {
      my $in_addr = Sys::Socket::In_addr->new;
      Sys::Socket->inet_aton($host, $in_addr);
      $socket_address->set_sin_addr($in_addr);
    }
    
    # Connect
    $self->connect_v2($socket_address);
    
    return $self;
  }

  method connect_v2 : int ($address : Sys::Socket::Sockaddr) {
    my $timeout = $self->{timeout};
    
    my $old_blocking = $self->blocking;
    my $restore_blocking_at_end_of_scope : Scope::Guard = undef;
    if ($timeout > 0) {
      $self->set_blocking(0);
      my $this = $self;
      $restore_blocking_at_end_of_scope = Scope::Guard->new([$this : IO::Socket,  $old_blocking : int] method : void () {
        $this->set_blocking($old_blocking);
      });
    }
    
    my $fd = $self->{fd};
    
    my $connect_status = -1;
    eval { $connect_status = Sys::Socket->connect($fd, $address, $address->sizeof); };
    
    my $blocking = $self->blocking;
    if ($blocking) {
      if ($@) {
        die $@;
      }
    }
    else {
      my $errno = Errno->errno;
      if ($errno == Errno->EINPROGRESS || $errno == Errno->EWOULDBLOCK) {
        my $select = IO::Select->new;
        $select->add($fd);
        my $can_write = $select->can_write($timeout);
        
        unless ($can_write) {
          die "connect: timeout";
        }
      }
    }
    
    $self->{peername} = $address;
    
    return $connect_status;
  }

  method connect_v3 : int ($address : Sys::Socket::Sockaddr) {
    my $timeout = $self->{timeout};
    
    my $old_blocking = $self->blocking;
    my $restore_blocking_at_end_of_scope : Scope::Guard = undef;
    if ($timeout > 0) {
      $self->set_blocking(0);
      my $this = $self;
      $restore_blocking_at_end_of_scope = Scope::Guard->new([$this : IO::Socket,  $old_blocking : int] method : void () {
        $this->set_blocking($old_blocking);
      });
    }
    
    my $fd = $self->{fd};
    
    my $connect_status = -1;
    eval { $connect_status = Sys::Socket->connect($fd, $address, $address->sizeof); };
    
    my $blocking = $self->blocking;
    if ($blocking) {
      if ($@) {
        die $@;
      }
    }
    else {
      my $errno = Errno->errno;
      if ($errno == Errno->EINPROGRESS || $errno == Errno->EWOULDBLOCK) {
        my $select = IO::Select->new;
        $select->add($fd);
        my $can_write = $select->can_write($timeout);
        
        unless ($can_write) {
          die "connect: timeout";
        }
      }
    }
    
    $self->{peername} = $address;
    
    return $connect_status;
  }

  method recv : int ($buffer : mutable string, $length = -1 : int, $flags = 0 : int) {
    my $fd = $self->{fd};
    
    if ($length < 0) {
      $length = length $buffer;
    }
    
    my $recv_length = Sys::Socket->recv($fd, $buffer, $length, $flags);
    
    return $recv_length;
  }
  
  method send : int ($buffer : string, $flags = 0 : int, $to = undef : Sys::Socket::Sockaddr) {
    my $fd = $self->{fd};
    
    my $peername = (Sys::Socket::Sockaddr)undef;
    if ($to) {
      $peername = $to;
    }
    else {
      $peername = $self->peername;
    }
    
    unless ($self->peername) {
      die "send: Cannot determine peer address";
    }
    
    my $send_length = 0;
    if ($to) {
      $send_length = IO::Util->sendto($fd, $buffer, length $buffer, $flags, $peername, $peername->sizeof);
    }
    else {
      $send_length = Sys::Socket->send($fd, $buffer, length $buffer, $flags);
    }
    
    $self->{peername} = $peername;
    
    return $send_length;
  }
  
  method close : int () {
    my $fd = $self->{fd};
    
    my $status = 0;
    if ($fd >= 0) {
      $status = Sys::Socket->close($fd);
      $self->{fd} = -1;
      $self->{opened} = 0;
    }
    
    return $status;
  }
  
  method fileno : int () { return $self->{fd}; }
  
  method opened : int () {
    my $fd = $self->{fd};
    
    my $opened = 0;
    if ($fd >= 0) {
      $opened = 1;
    }
    
    return $opened;
  }
  
  method DESTROY : void () {
    $self->{peername} = undef;
    $self->close;
  }
  
  method listen : int ($queue = 5 : int) {
    my $fd = $self->{fd};
    my $status = Sys::Socket->listen($fd, $queue);
    return $status;
  }

  method bind : int ($address : Sys::Socket::Sockaddr) {
    my $fd = $self->{fd};
    my $status = Sys::Socket->bind($fd, $address, $address->sizeof);
    
    return $status;
  }
  
  method sockname : Sys::Socket::Sockaddr () {
    my $fd = $self->{fd};
    my $sockdomain = $self->{sockdomain};
    
    my $addr : Sys::Socket::Sockaddr;
    if ($sockdomain == SOCKET->AF_INET) {
      $addr = Sys::Socket::Sockaddr::In->new;
    }
    elsif ($sockdomain == SOCKET->AF_INET6) {
      $addr = Sys::Socket::Sockaddr::In6->new;
    }
    elsif ($sockdomain == SOCKET->AF_UNIX) {
      $addr = Sys::Socket::Sockaddr::Un->new;
    }
    else {
      die "Unsupported domain";
    }
    
    my $addr_len = $addr->sizeof;
    Sys::Socket->getsockname($fd, $addr, \$addr_len);
    
    return $addr;
  }

  method shutdown : int ($sockfd : int, $how : int) {
    $self->{peername} = undef;
    my $fd = $self->{fd};
    my $status = Sys::Socket->shutdown($fd, $how);
    return $status;
  }


  method atmark : int () {
    my $fd = $self->{fd};
    
    my $status = IO::Util->sockatmark($fd);
    
    return $status;
  }

  method setsockopt : int ($level : int, $optname : int, $optval : int) {
    my $fd = $self->{fd};
    
    my $status = Sys::Socket->setsockopt_int($fd, $level, $optname, $optval);
    
    return $status;
  }

  method getsockopt : int ($level : int, $optname : int) {
    my $fd = $self->{fd};
    my $optval = 0;
    Sys::Socket->getsockopt_int($fd, $level, $optname, \$optval);
    
    return $optval;
  }

  method connected : Sys::Socket::Sockaddr () {
    my $addr = (Sys::Socket::Sockaddr)undef;
    eval { $addr = $self->peername; };
    return $addr;
  }

  method socket : int ($domain : int, $type : int, $protocol = 0 : int) {
    my $fd = Sys::Socket->socket($domain, $type, $protocol);
    
    $self->{fd} = $fd;
    $self->{sockdomain} = $domain;
    $self->{socktype} = $type;
    $self->{protocol} = $protocol;
    
    return $fd;
  }

  method socketpair : int[] ($domain : int, $type : int, $protocol : int) {
    my $sock1 = IO::Socket->new;
    my $sock2 = IO::Socket->new;
    
    my $sock1_fd = $sock1->{fd};
    my $sock2_fd = $sock2->{fd};
    
    my $pair = new int[2];
    Sys::Socket->socketpair($domain, $type, $protocol, $pair);
    
    $sock1->{socktype} = $type;
    $sock1->{protocol} = $protocol;
     
    return $pair;
  }

  method accept : IO::Socket::Interface ($io_socket_builder = undef : IO::Socket::Builder, $peer_ref = undef : Sys::Socket::Sockaddr[]) {
    my $fd = $self->{fd};
    my $timeout = $self->{timeout};
    my $client = (IO::Socket)undef;
    
    my $options = {Timeout => $timeout};
    if ($io_socket_builder) {
      $client = $io_socket_builder->build($options);
    }
    else {
      $client = IO::Socket->new($options);
    }
    
    if ($timeout > 0) {
      my $select = IO::Select->new;
      $select->add($fd);
      
      unless ($select->can_read($timeout)) {
        die "accept: timeout";
      }
    }

    my $client_socket_address = $self->sockname->clone;
    my $client_socket_address_size = $client_socket_address->sizeof;
    
    my $client_fd = Sys::Socket->accept($fd, $client_socket_address, \$client_socket_address_size);
    
    $client->{fd} = $client_fd;
    
    $client->{sockdomain} = $self->{sockdomain};
    $client->{socktype} = $self->{socktype};
    $client->{protocol} = $self->{protocol};
    
    if ($peer_ref) {
      $peer_ref->[0] = $client_socket_address;
    }
    
    return $client;
  }
}


=head1 See Also

=head2 SPVM::Sys::Socket

L<SPVM::Sys::Socket>

=head2 SPVM::Sys::Socket::Constant

L<SPVM::Sys::Socket::Constant>

=head2 SPVM::IO::Socket::INET

L<SPVM::IO::Socket::INET>


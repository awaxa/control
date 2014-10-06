class profile::pe::console {
  class { 'pe_console_timeout':
    timeout_interval => '3600',
  }
  firewall { '100 allow https access':
    port   => '443',
    proto  => 'tcp',
    action => 'accept',
  }
}

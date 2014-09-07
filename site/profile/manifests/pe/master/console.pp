class profile::pe::master::console {
  include request_manager
  class { 'pe_console_timeout':
    timeout_interval => '3600',
    notify           => Service['pe-httpd'],
  }
  firewall { '100 allow https access':
    port   => '443',
    proto  => 'tcp',
    action => 'accept',
  }
}

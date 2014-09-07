class profile::pe::console {
  include request_manager
  class { 'pe_console_timeout':
    timeout_interval => '3600',
    notify           => Service['pe-httpd'],
  }
}

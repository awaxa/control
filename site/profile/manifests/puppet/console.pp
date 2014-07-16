class profile::puppet::console {
  class { '::pe_console_timeout':
    timeout_interval => '3600',
  }
}

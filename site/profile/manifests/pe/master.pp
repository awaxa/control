class profile::pe::master {

  include request_manager # contains Service['pe-httpd']

  class { 'profile::r10k': } ~> Service['pe-httpd']
  Class['r10k::config'] ~> Service['pe-httpd']

  class { 'profile::hiera': } ~> Service['pe-httpd']
  Class['::hiera'] ~> Service['pe-httpd']

  class { 'pe_console_timeout':
    timeout_interval => '3600',
    notify           => Service['pe-httpd']
  }

  include profile::pe::path

  include profile::firewall
  firewall { '100 allow puppet access':
    ensure => present,
    port   => '8140',
    proto  => 'tcp',
    action => 'accept',
  }
  firewall { '100 allow mcollective access':
    ensure => present,
    port   => '61613',
    proto  => 'tcp',
    action => 'accept',
  }
  firewall { '100 allow https access':
    ensure => present,
    port   => '443',
    proto  => 'tcp',
    action => 'accept',
  }
}

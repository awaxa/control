class profile::pe::master {

  if versioncmp($::pe_version, '3.7.0') >= 0 {
    $puppetd = 'pe-puppetserver'
    if ! $::servername { # when masterless
    service { $puppetd:
      ensure => running,
      enable => true,
    }
    }
  }
  else {
    $puppetd = 'pe-httpd'
    service { $puppetd:
      ensure => running,
      enable => true,
    }
  }

  class { 'profile::r10k': } ~> Service[$puppetd]
  Class['r10k::config'] ~> Service[$puppetd]

  class { 'profile::hiera': } ~> Service[$puppetd]
  Class['::hiera'] ~> Service[$puppetd]

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
}

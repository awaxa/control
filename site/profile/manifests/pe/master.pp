class profile::pe::master {

  if versioncmp($::pe_version, '3.7.0') >= 0 {
    # for PE >= 3.7.0, manage puppetd only during bootstrapping
    if $::servername { $_no_manage_puppetd = true }
    $puppetd = 'pe-puppetserver'
  }
  else {
    $puppetd = 'pe-httpd'
  }
  unless $_no_manage_puppetd {
    service { $puppetd:
      ensure => running,
      enable => true,
    }
    service { 'pe-mcollective':
      ensure => running,
      enable => true,
    }
  }

  include pe_repo::platform::el_6_x86_64
  include pe_repo::platform::ubuntu_1404_amd64

  class { 'profile::r10k': } ~> Service[$puppetd]
  Exec['r10k deploy'] -> Service[$puppetd]
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

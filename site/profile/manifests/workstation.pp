class profile::workstation {
  class { 'apt':
    purge_sources_list_d => true,
  }
  apt::source { 'puppetlabs':
    location   => 'http://apt.puppetlabs.com',
    repos      => 'main',
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

  package { 'ubuntu-desktop':
    ensure => present,
  }

  include profile::workstation::chrome
}

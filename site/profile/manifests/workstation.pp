class profile::workstation inherits profile::base {
  class { 'apt':
    purge_sources_list_d => true,
  }
  apt::source { 'puppetlabs':
    location   => 'http://apt.puppetlabs.com',
    repos      => 'main',
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

  if $::is_virtual == 'false' {
    Firewall['100 allow ssh access'] {
      ensure => absent,
    }
  }

  package { 'ubuntu-desktop':
    ensure => present,
  }

  include profile::workstation::chrome
}

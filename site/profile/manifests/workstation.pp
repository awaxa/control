class profile::workstation {
  class { 'apt':
    purge_sources_list_d => true,
  }

  package { 'ubuntu-desktop':
    ensure => present,
  }

  include profile::workstation::chrome
}

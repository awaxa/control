class profile::workstation {
  include apt
  package { 'ubuntu-desktop':
    ensure => present,
  }
  include profile::workstation::chrome
}

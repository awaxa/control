class profile::workstation {
  package { 'ubuntu-desktop':
    ensure => present,
  }
}

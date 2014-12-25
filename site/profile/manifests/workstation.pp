class profile::workstation {
  include profile::base

  class { 'apt':
    purge_sources_list_d => true,
  }
  apt::source { 'puppetlabs':
    location   => 'http://apt.puppetlabs.com',
    repos      => 'main',
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

  # my laptop should disallow sshd access
  if $::is_virtual == 'false' {
    Firewall <| title == '100 allow ssh access' |> {
      ensure => absent,
    }
  }

  package { 'ubuntu-desktop':
    ensure => present,
  }

  include profile::workstation::chrome
}

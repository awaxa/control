class profile::base {

  case $::osfamily {
    'redhat': { include profile::base::redhat }
  }
  include ntp

  include profile::firewall
  firewall { '100 allow ssh access':
    ensure => present,
    port   => '22',
    proto  => 'tcp',
    action => 'accept',
  }

  package { [
    'tree',
    'vim',
  ]:
    ensure => present,
  }

  file { '/etc/motd':
    ensure  => present,
    content => '',
  }
}

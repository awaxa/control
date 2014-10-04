class profile::base {
  include profile::firewall
  include profile::pe::path
  include ntp
  package { [
    'tree',
  ]:
    ensure => present,
  }
  firewall { '100 allow ssh access':
    port   => '22',
    proto  => 'tcp',
    action => 'accept',
  }
}

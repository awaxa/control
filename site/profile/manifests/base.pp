class profile::base {
  include ntp
  include profile::firewall
  package { [
    'tree',
    'vim',
  ]:
    ensure => present,
  }
}

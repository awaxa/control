class profile::base {
  include profile::firewall
  include ntp
  package { [
    'tree',
  ]:
    ensure => latest,
  }
}

class profile::base {
  include ntp
  package { [
    'tree',
  ]:
    ensure => latest,
  }
}

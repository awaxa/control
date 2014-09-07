class profile::firewall {
  include ::firewall
  include profile::firewall::pre
  include profile::firewall::post
  Firewall {
    before  => Class['profile::firewall::post'],
    require => Class['profile::firewall::pre'],
  }
  resources { 'firewall':
    purge => true,
  }
}

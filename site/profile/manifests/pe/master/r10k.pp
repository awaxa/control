class profile::pe::master::r10k {
  include request_manager
  file { "${::settings::confdir}/environments":
    ensure => directory,
  }
  class { '::r10k':
    version                => '1.3.0',
    include_prerun_command => true,
    sources                => {
      'puppet'             => {
        'remote'           => '/vagrant/control',
        'basedir'          => "${::settings::confdir}/environments",
        'prefix'           => false,
      }
    },
    purgedirs => ["${::settings::confdir}/environments"],
    notify    => Service['pe-httpd'],
  }
  ini_setting { 'puppet.conf environmentpath':
    ensure  => present,
    path    => "${::settings::confdir}/puppet.conf",
    section => 'main',
    setting => 'environmentpath',
    value   => "${::settings::confdir}/environments",
    notify  => Service['pe-httpd'],
  }
}

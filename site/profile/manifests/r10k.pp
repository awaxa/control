class profile::r10k {
  file { "${::settings::confdir}/environments":
    ensure => directory,
  }
  class { '::r10k':
    version                => '1.3.0',
    include_prerun_command => true,
    sources                => {
      'puppet'             => {
        'remote'           => 'https://github.com/awaxa/control.git',
        'basedir'          => "${::settings::confdir}/environments",
        'prefix'           => false,
      }
    },
    purgedirs => ["${::settings::confdir}/environments"],
  }
  ini_setting { 'puppet.conf environmentpath':
    ensure  => present,
    path    => "${::settings::confdir}/puppet.conf",
    section => 'main',
    setting => 'environmentpath',
    value   => "${::settings::confdir}/environments",
  }
}

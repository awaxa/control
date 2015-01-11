class profile::r10k {

  $remote = 'https://github.com/awaxa/control.git'
  $environmentpath = "${::settings::confdir}/environments"

  class { '::r10k':
    version       => '1.4.1',
    purgedirs     => [$environmentpath],
    sources       => {
      'puppet'    => {
        'remote'  => $remote,
        'basedir' => $environmentpath,
        'prefix'  => false,
      }
    },
  }

  ini_setting { 'puppet.conf environmentpath':
    ensure  => present,
    path    => "${::settings::confdir}/puppet.conf",
    section => 'main',
    setting => 'environmentpath',
    value   => $environmentpath,
  }

}

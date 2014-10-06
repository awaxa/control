class profile::workstation::chrome {
  apt::source { 'google-chrome':
    location    => 'http://dl.google.com/linux/chrome/deb/',
    release     => 'stable',
    repos       => 'main',
    key         => '7FAC5991',
    include_src => false,
  }
  package { 'google-chrome-stable':
    require => Apt::Source['google-chrome'],
  }
}

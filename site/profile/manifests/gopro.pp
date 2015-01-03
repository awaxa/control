class profile::gopro {

  include apt
  apt::ppa { 'ppa:jon-severinsson/ffmpeg':
    ensure => 'present',
    before => Package['ffmpeg'],
  }

  package { [
    'awscli',
    'ffmpeg',
    'python-pip',
  ]:
    ensure => present,
  }

  package { 'google-api-python-client':
    ensure   => present,
    provider => 'pip',
    require  => Package['python-pip'],
  }

  $awsconfdir = '/root/.aws'
  $awsconf = "${awsconfdir}/config"
  file { $awsconfdir: ensure => directory }
  file { $awsconf: ensure  => file }
  ini_setting { 'aws region':
    ensure  => present,
    path    => $awsconf,
    section => 'default',
    setting => 'region',
    value   => 'us-east-1',
  }

  file { '/usr/local/bin/upload_video.py':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/profile/gopro/upload_video.py',
  }
}

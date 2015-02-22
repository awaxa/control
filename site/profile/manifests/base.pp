class profile::base {

  if $::is_pe { include pe_staging }
  include staging

  case $::osfamily {
    'redhat': { include profile::base::redhat }
  }
  include ntp

  include profile::firewall
  firewall { '100 allow ssh access':
    ensure => present,
    port   => '22',
    proto  => 'tcp',
    action => 'accept',
  }

  package { [
    'tree',
    'vim',
  ]:
    ensure => present,
  }

  file { '/etc/motd':
    ensure  => present,
    content => '',
  }

  profile::homesick::repo { 'root dotfiles':
    repo      => 'https://github.com/awaxa/dotfiles.git',
    repo_name => 'dotfiles',
    user      => 'root',
  }

}

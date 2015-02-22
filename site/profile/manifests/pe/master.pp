class profile::pe::master {

  if versioncmp($::pe_version, '3.7.0') >= 0 {
    $puppetd = 'pe-puppetserver'
    unless $::servername { # for PE >= 3.7.0, manage puppetd only during bootstrapping
      service { [
        $puppetd,
        'pe-mcollective',
        'pe-console-services',
      ]:
        ensure => running,
        enable => true,
      }
    }
    file { '/etc/puppetlabs/console-services/conf.d/rbac-timeout.conf':
      ensure  => file,
      owner   => 'pe-console-services',
      group   => 'pe-console-services',
      mode    => '0640',
      content => "rbac: {\n    session-timeout: 1400\n}\n",
      notify  => Service['pe-console-services'],
    }
  }
  else {
    $puppetd = 'pe-httpd'
    class { 'pe_console_timeout':
      timeout_interval => '86400',
      notify           => Service['pe-httpd']
    }
  }

  include pe_repo::platform::el_6_x86_64
  include pe_repo::platform::ubuntu_1404_amd64

  class { 'profile::r10k': } ~> Service[$puppetd]
  Exec['r10k deploy'] -> Service[$puppetd]
  Class['r10k::config'] ~> Service[$puppetd]

  class { 'profile::hiera': } ~> Service[$puppetd]
  Class['::hiera'] ~> Service[$puppetd]

  include profile::pe::path

  include profile::firewall
  firewall { '100 allow puppet access':
    ensure => present,
    port   => '8140',
    proto  => 'tcp',
    action => 'accept',
  }
  firewall { '100 allow mcollective access':
    ensure => present,
    port   => '61613',
    proto  => 'tcp',
    action => 'accept',
  }

  include profile::admins
  $peadmin_ssh_authorized_key_defaults = {
    ensure => present,
    user   => 'peadmin',
  }
  create_resources(ssh_authorized_key, $profile::admins::keys, $peadmin_ssh_authorized_key_defaults)

}

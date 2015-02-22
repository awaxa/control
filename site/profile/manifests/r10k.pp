class profile::r10k {

  $_ssh = 'git@github.com:'
  $_https = 'https://github.com/'
  $repo = 'awaxa/control'
  $remote = "${_https}${repo}.git"
  $environmentpath = "${::settings::confdir}/environments"

  ini_setting { 'puppet.conf environmentpath':
    ensure  => present,
    path    => "${::settings::confdir}/puppet.conf",
    section => 'main',
    setting => 'environmentpath',
    value   => $environmentpath,
  }

  class { '::r10k':
    remote => $remote,
  }

  exec { 'r10k deploy':
    command     => 'r10k deploy environment -p',
    refreshonly => true,
    subscribe   => Class['::r10k::config'],
  }

  if $::is_pe {

    include r10k::mcollective
    class {'r10k::webhook::config':
      enable_ssl     => false,
      protected      => false,
    } ->
    class {'r10k::webhook': }

    if $::osfamily == 'debian' {
      Service <| title == 'webhook'|> {
        start => '/usr/local/bin/webhook',
      }
    }

    firewall { '100 allow webhook access':
      ensure => present,
      port   => '8088',
      proto  => 'tcp',
      action => 'accept',
    }

    if $::github_api_token {
      git_webhook { 'web_post_receive_webhook' :
        ensure       => present,
        webhook_url  => "http://${::fqdn}:8088/payload",
        token        =>  $::github_api_token,
        project_name => $repo,
        server_url   => 'http://github.com',
        provider     => 'github',
      }
    }

  }

}

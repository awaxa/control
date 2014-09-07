class profile::pe::master::hiera {
  include request_manager
  class { '::hiera':
    datadir   => "\"${::settings::confdir}/environments/%{environment}/hieradata\"",
    hierarchy => [
      'nodes/%{clientcert}',
      '%{environment}',
      'common',
    ],
    notify => Service['pe-httpd'],
  }
}

class profile::hiera {
  class { '::hiera':
    datadir   => "\"${::settings::confdir}/environments/%{environment}/hieradata\"",
    hierarchy => [
      'nodes/%{clientcert}',
      '%{environment}',
      'common',
    ],
  }
}

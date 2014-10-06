class profile::pe::master {

  include request_manager # contains Service['pe-httpd']

  class { 'profile::r10k': }        ~> Service['pe-httpd']
  Class['r10k::config']             ~> Service['pe-httpd']

  class { 'profile::hiera': }       ~> Service['pe-httpd']
  Class['::hiera']                  ~> Service['pe-httpd']

  class { 'profile::pe::console': } ~> Service['pe-httpd']

  include profile::pe::path

  include profile::firewall
  firewall { '100 allow ssh access':
    port   => '22',
    proto  => 'tcp',
    action => 'accept',
  }
  firewall { '100 allow puppet access':
    port   => '8140',
    proto  => 'tcp',
    action => 'accept',
  }
  firewall { '100 allow mcollective access':
    port   => '61613',
    proto  => 'tcp',
    action => 'accept',
  }
}

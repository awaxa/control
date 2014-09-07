class profile::pe::master {
  include profile::pe::master::r10k
  include profile::pe::master::hiera
  include profile::pe::master::console
  include profile::pe::path
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

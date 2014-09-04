class role::puppet::master {
  include profile::puppet::r10k
  include profile::puppet::hiera
  include profile::puppet::console
  include profile::base
}

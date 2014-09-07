class role::pe::master {
  include profile::pe::r10k
  include profile::pe::hiera
  include profile::pe::console
  include profile::pe::path
  include profile::base
}

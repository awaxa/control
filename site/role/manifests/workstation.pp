class role::workstation {
  include profile::hiera
  include profile::r10k
  include profile::workstation
}

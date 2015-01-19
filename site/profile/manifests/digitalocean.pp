class profile::digitalocean {

  include profile::cloud
  $pe_username = $profile::cloud::pe_username
  $pe_password = $profile::cloud::pe_password
  $pe_version_string = $profile::cloud::pe_version_string
  $pe_altnames = undef
  $cloud = 'digitalocean'

  Droplet {
    backups            => false,
    ipv6               => false,
    private_networking => false,
    region             => 'sfo1',
    ssh_keys           => [13711],
  }

  droplet { 'puppet':
    ensure    => present,
    size      => '2gb',
    image     => 6372108,
    # user_data => template("${module_name}/master-pe-userdata.erb"),
  }

}

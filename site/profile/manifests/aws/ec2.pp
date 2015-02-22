class profile::aws::ec2 {

  # require profile::aws::ec2::vpc
  # $subnet = $profile::aws::ec2::vpc::subnet

  include profile::aws
  $ensure = $profile::cloud::ensure
  $region = $profile::aws::region
  $prefix = $profile::aws::prefix
  $tags = $profile::aws::tags

  include profile::aws::ec2::amis
  $amis = $profile::aws::ec2::amis::all

  $sg = "${prefix}_puppet"
  ec2_securitygroup { $sg:
    ensure           => $ensure,
    description      => 'fort kitson',
    region           => $region,
    tags             => $tags,
    ingress          => [{
      security_group => $sg,
      },{
        protocol => 'tcp',
        port     => '22',
        cidr     => '0.0.0.0/0',
      },{
        protocol => 'tcp',
        port     => '8088',
        cidr     => '0.0.0.0/0',
      },{
        protocol => 'tcp',
        port     => '8140',
        cidr     => '0.0.0.0/0',
      },{
        protocol => 'tcp',
        port     => '61613',
        cidr     => '0.0.0.0/0',
      }],
  }

  Ec2_instance {
    key_name        => $prefix,
    monitoring      => false,
    region          => $region,
    security_groups => [ $sg ],
    tags            => $tags,
  }

  $pe_username = $profile::cloud::pe_username
  $pe_password = $profile::cloud::pe_password
  $pe_version_string = $profile::cloud::pe_version_string
  $pe_altnames = $profile::cloud::pe_altnames
  $cloud = $profile::aws::cloud
  ec2_instance { "${prefix}_master0":
    ensure        => $ensure,
    image_id      => $amis['rhel']['6'][$region],
    instance_type => 'm3.medium',
    user_data     => template("${module_name}/master-pe-userdata.erb"),
  }

}

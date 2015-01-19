class profile::aws {

  include profile::cloud
  $pe_username = $profile::cloud::pe_username
  $pe_password = $profile::cloud::pe_password
  $pe_version_string = $profile::cloud::pe_version_string
  $pe_altnames = $profile::cloud::pe_altnames
  $cloud = 'aws'

  $region = 'us-west-2'

  Ec2_instance {
    key_name        => 'greg.kitson',
    monitoring      => false,
    region          => $region,
    security_groups => ['greg.kitson_puppet'],
    tags            => {
      'created_by'  => 'greg.kitson',
      'department'  => 'prosvcs',
      'project'     => 'testing puppetlabs-aws',
    }
  }

  ec2_securitygroup { 'greg.kitson_puppet':
    ensure           => present,
    description      => 'testing puppetlabs-aws module',
    region           => $region,
    ingress          => [{
      security_group => 'greg.kitson_puppet',
      },{
        protocol => 'tcp',
        port     => 22,
        cidr     => '0.0.0.0/0',
      },{
        protocol => 'tcp',
        port     => 8140,
        cidr     => '0.0.0.0/0',
      },{
        protocol => 'tcp',
        port     => 61613,
        cidr     => '0.0.0.0/0',
      }],
  }

  ec2_instance { 'greg.kitson_master0':
    ensure        => present,
    image_id      => 'ami-e08efbd0', # rhel 6
    instance_type => 'm3.medium',
    user_data     => template("${module_name}/master-pe-userdata.erb"),
  }

  # ec2_instance { 'greg.kitson_ubuntu':
  #   ensure        => present,
  #   image_id      => 'ami-898dd9b9', # trusty hvm ebs-ssd
  #   instance_type => 'm3.medium',
  #   user_data     => template("${module_name}/agent-pe-userdata.erb"),
  # }

}

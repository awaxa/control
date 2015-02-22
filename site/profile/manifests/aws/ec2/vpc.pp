class profile::aws::ec2::vpc {

  include profile::aws
  $ensure = $profile::aws::ensure
  $region = $profile::aws::region
  $prefix = $profile::aws::prefix
  $tags = $profile::aws::tags

  $vpc = "${prefix}_vpc"
  $table = "${prefix}_routetable"
  $subnet = "${prefix}_subnet_private"
  $igw = "${prefix}_igw"

  ec2_vpc { $vpc:
    ensure     => $ensure,
    region     => $region,
    cidr_block => '172.20.0.0/16',
    tags       => $tags,
  }

  ec2_vpc_routetable { $table:
    ensure => $ensure,
    region => $region,
    vpc    => $vpc,
    tags   => $tags,
    routes => [
      {
        destination_cidr_block => '172.20.0.0/16',
        gateway                => 'local',
      },
      {
        destination_cidr_block => '0.0.0.0/0',
        gateway                => $igw,
      },
    ],
  }

  ec2_vpc_subnet { $subnet:
    ensure            => $ensure,
    region            => $region,
    vpc               => $vpc,
    cidr_block        => '172.20.1.0/24',
    availability_zone => "${region}c",
    route_table       => $table,
    tags              => $tags,
  }

  ec2_vpc_internet_gateway { $igw:
    ensure => $ensure,
    region => $region,
    vpcs   => $vpc,
    tags   => $tags,
  }

  case $ensure {
    'absent': {
      Ec2_vpc_internet_gateway[$igw] -> Ec2_vpc[$vpc]
      Ec2_vpc_subnet[$subnet] -> Ec2_vpc[$vpc]
      Ec2_vpc_subnet[$subnet] -> Ec2_vpc_routetable[$table]
      Ec2_vpc_routetable[$table] -> Ec2_vpc[$vpc]
    }
  }

}

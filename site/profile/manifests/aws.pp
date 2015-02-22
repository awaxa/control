class profile::aws {

  include profile::cloud
  $cloud = 'aws'
  $region = 'us-west-2'

  $tags = {
    'created_by' => 'greg.kitson',
    'department' => 'prosvcs',
    'project'    => 'puppetlabs-aws',
  }

  $prefix = $tags['created_by']

}

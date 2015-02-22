class profile::aws::route53 {

  include profile::aws
  $ensure = $profile::cloud::ensure
  $zone = 'pl.awaxa.com.'

  Route53_a_record {
    ttl  => '60',
    zone => $zone,
  }

  Route53_txt_record {
    ttl  => '60',
    zone => $zone,
  }

  route53_zone { $zone:
    ensure => $ensure,
  }

  route53_a_record { 'test.pl.awaxa.com.':
    ensure => absent,
    values => ['127.127.127.127'],
  }

  $txttagdefaults = {
    'ttl'  => '3600',
    'zone' => $zone,
  }
  create_resources(route53_txt_record, tags2values($profile::aws::tags, $zone), $txttagdefaults)

}

class profile::aws::ec2::amis {

  $all = {
    'rhel' => {
      '7' => { # https://aws.amazon.com/marketplace/pp/B00KWBZVK6
        'us-east-1' => 'ami-a8d369c0',
        'us-west-2' => 'ami-99bef1a9',
      },
      '6' => { # https://aws.amazon.com/marketplace/pp/B00CFQWLS6
        'us-east-1' => 'ami-aed06ac6',
        'us-west-2' => 'ami-5fbcf36f',
      },
    },
    'centos' => { # http://wiki.centos.org/Cloud/AWS
      '7' => { # https://aws.amazon.com/marketplace/pp/B00O7WM7QW
        'us-east-1' => 'ami-96a818fe',
        'us-west-2' => 'ami-c7d092f7',
      },
      '6' => { # https://aws.amazon.com/marketplace/pp/B00NQAYLWO
        'us-east-1' => 'ami-c2a818aa',
        'us-west-2' => 'ami-81d092b1',
      },
    },
  }

}

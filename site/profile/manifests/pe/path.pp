class profile::pe::path {
  case $::osfamily {
    'redhat': {
      file_line { 'root bash_profile PATH':
        path  => '/root/.bash_profile',
        line  => 'PATH=$HOME/bin:$PATH:/opt/puppet/bin',
        match => 'PATH=',
      }
    }
  }
}

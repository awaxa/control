class profile::base {
  include '::ntp'
  file_line { 'root bash_profile PATH':
    path  => '/root/.bash_profile',
    line  => 'PATH=$HOME/bin:$PATH:/opt/puppet/bin',
    match => 'PATH=',
  }
}

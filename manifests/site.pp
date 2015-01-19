filebucket { 'main':
  server => $::settings::server,
  path   => false,
}
File {
  backup => 'main',
  owner  => '0',
  group  => '0',
  mode   => '0644',
}

Package { allow_virtual => true }

$_opt_puppet_bin = $::is_pe ? {
  true  => '/opt/puppet/bin',
  false => undef,
}
Exec { path => "${::path}:${_opt_puppet_bin}" }

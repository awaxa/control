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

$_pathappend = $::is_pe ? {
  'true'  => ':/opt/puppet/bin',
  default => '',
}
Exec { path => "${::path}${_pathappend}" }

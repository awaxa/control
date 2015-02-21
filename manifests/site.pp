filebucket { 'main':
  server => $::settings::server,
  path   => false,
}
File {
  backup => 'main',
  mode   => '0644',
}

Package { allow_virtual => true }

$_pathappend = $::is_pe ? {
  'true'  => ':/opt/puppet/bin',
  default => '',
}
Exec { path => "${::path}${_pathappend}" }

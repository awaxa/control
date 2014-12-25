filebucket { 'main':
  server => $::settings::server,
  path   => false,
}
File { backup => 'main' }

Package { allow_virtual => true }

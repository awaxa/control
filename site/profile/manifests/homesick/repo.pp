define profile::homesick::repo (
  $repo,
  $repo_name,
  $user,
  $manage_symlink_exec = true,
  $revision = 'master',
) {

  case $user {
    'root':  { $home = '/root' }
    default: { $home = "/home/${user}" }
  }
  $homesick = "${home}/.homesick/repos/homeshick"
  $bin = "${homesick}/bin/homeshick"

  unless defined(Vcsrepo[$homesick]) {
    vcsrepo { $homesick:
      ensure   => latest,
      provider => 'git',
      revision => 'master',
      source   => 'https://github.com/andsens/homeshick.git',
    }
  }

  vcsrepo { "${home}/.homesick/repos/${repo_name}":
    ensure   => latest,
    provider => 'git',
    revision => $revision,
    source   => $repo,
  }

  if $manage_symlink_exec {
    exec { "${bin} symlink --force dotfiles":
      user        => $_user,
      refreshonly => true,
      require     => Vcsrepo[$homesick],
      subscribe   => Vcsrepo["${home}/.homesick/repos/${repo_name}"],
    }
  }

}

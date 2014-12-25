node default {
  if $::role {
    notify { "dynamically assigned ${::role} to ${::clientcert}": }
    include $::role
  }
  else {
    notify { "node '${::clientcert}' has not been classified": }
  }
}

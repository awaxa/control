node default {
  if $::role {
    include "role::${::role}"
  }
  else {
    notify { "node '${::clientcert}' has not been classified": }
  }
}

node default {
  notify { "node '${::clientcert}' has not been classified": }
}

class profile::admins {

  $usernames = [ # github users
    'awaxa',
  ]

  $keys = gitssh_import($usernames)

}

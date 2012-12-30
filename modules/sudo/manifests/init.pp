class sudo {
  file { 'sudoers': # a common title for all platforms
    path => $operatingsystem ? {
      solaris => "/usr/local/etc/sudoers",
      default => "/etc/sudoers"
    },
    owner => root,
    group => root,
    mode => 440,
    content => template("sudo/sudoers.erb"),
  }
}

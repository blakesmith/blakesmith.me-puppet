class ssh {
  package { "openssh-server":
    ensure => latest
  }
  
  # define the service to restart
  service { "ssh":
    ensure  => running,
    enable  => true,
    require => Package["openssh-server"],
  }

  # add a notify to the file resource
  file { "/etc/ssh/sshd_config":
    notify  => Service["ssh"],  # this sets up the relationship
    mode    => 600,
    owner   => "root",
    group   => "root",
    require => Package["openssh-server"],
    content => template("ssh/sshd_config.erb"),
  }
}

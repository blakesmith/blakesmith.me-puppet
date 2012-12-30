class myapt {
  class { 'apt':
    always_apt_update    => true,
    disable_keys => true
  }
    
  apt::source { 'blakesmith':
    location   => 'http://blakesmith-me-apt.s3.amazonaws.com',
    release    => 'precise',
    repos      => 'main',
    include_src => false
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    require => Apt::Source['blakesmith']
  }
  
  Exec["apt-update"] -> Package <| |> 
}

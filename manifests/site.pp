node default, "stiletto.blakesmith.me" {
  include users
  include myapt
  include defaultfirewall
  include ssh
  include sudo
  include miscpackages
  
  class { 'jekyll':
    repo => "blakesmith.me.git",
    deploy_user => "deploy",
    deploy_group => "www-data",
    path => ["/var/lib/gems/1.8/bin"],
  }

  firewall { '100 allow httpd:80':
    state => ['NEW'],
    dport => '80',
    proto => 'tcp',
    action  => 'accept',
  }
  
  class { 'nginx': }

  nginx::resource::upstream { 'metra':
    ensure  => present,
    members => ['127.0.0.1:9002'],
  }

  nginx::resource::upstream { 'skeeter':
    ensure  => present,
    members => ['127.0.0.1:9001'],
  }

  nginx::resource::vhost { 'localhost':
    ensure   => present,
    www_root  => '/var/www/blakesmith.me.git'
  }

  nginx::resource::vhost { 'blakesmith.me':
    ensure   => present,
    www_root  => '/var/www/blakesmith.me.git'
  }
  
  nginx::resource::vhost { 'metra.blakesmith.me':
    ensure   => present,
    proxy  => 'http://metra',
  }
  
  nginx::resource::vhost { 'skeeter.blakesmith.me':
    ensure   => present,
    proxy  => 'http://skeeter',
  }
  
  duplicity { 'blake_homedir_backup':
    directory => '/home/blake/',
    bucket => 'my-s3-bucket-name',
    dest_id => 'AWS_ACCESS_KEY_GOES_HERE',
    dest_key => 'AWS_SECRET_KEY_GOES_HERE',
    remove_older_than => '6M',
  }

  class { "java": }
  class { "irssi": }
  
  package { ['skeeter', 'iphone-metra']:
    ensure => latest
  }

  service { 'skeeter':
    ensure => running,
    pattern => 'skeeter',
    require => Package['skeeter']
  }
  
  service { 'iphone-metra':
    ensure => running,
    pattern => 'iphone-metra',
    require => Package['iphone-metra']
  }
}

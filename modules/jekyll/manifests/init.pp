class jekyll (
  $deploy_user = "deploy",
  $deploy_group = "www-data",
  $path = ["/usr/local/bin"],
  $repo = "jekyll.git",
  $www_root = "/var/www"
) {
	$repo_path = "/home/$deploy_user/$repo"
	
	# Resource Defaults
	
	File {
		owner	=> $deploy_user,
		group	=> $deploy_user
	}
	
	Exec {
		user	=> $deploy_user,
		group	=> $deploy_user,
		path	=> ["/usr/bin", "/usr/sbin"]
	}
        
	# Jekyll packages
	
	package { ["ruby1.9.1", "rubygems", "python-pygments", "libocamlgsl-ocaml-dev", "libgsl-ruby1.8"]:
          ensure  => latest,
        }

	package { ["jekyll", "rdiscount", "RedCloth"]:
	  provider	=> "gem",
	  require	=> Package["rubygems"]
	}

	# Setup deploy repository and post-receive hook
	
	package { "git": }
	
	exec { "jekyll-bare-repo":
	  command	=> "git init --bare $repo_path",
	  creates	=> $repo_path,
	  require	=> [ Package["git"], Add_user[$deploy_user] ],
	}
        
        file { $www_root:
          ensure => "directory",
          mode   => 775,
          owner  => $deploy_user,
          group  => $deploy_group
        }
	
	file { "$repo_path/hooks/post-receive":
	  mode	=> 0755,
	  content	=> template("jekyll/post-receive.erb"),
	  require	=> [ Exec["jekyll-bare-repo"], Add_user[$deploy_user] ],
	}
}

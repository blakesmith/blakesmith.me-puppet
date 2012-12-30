set :upload_dir, "/tmp"
set :base_dir, "blakesmith.me"
set :default_environment, {
  'PATH' => "/var/lib/gems/1.8/bin:$PATH"
}
set :puppet_site, "#{upload_dir}/#{base_dir}/manifests/site.pp"
set :modulepath, "#{upload_dir}/#{base_dir}/modules"

role :server, "stiletto.blakesmith.me"
set :user, "blake"
set :use_sudo, true

desc "Bootstrap puppet"
task :bootstrap, :role => :server do
  sudo "apt-get update"
  sudo "apt-get -y install ruby rubygems"
  sudo "gem install puppet"
end

# Example usage: NAME='test.blakesmith.me' HOSTS=ubuntu@ec2-50-17-112-94.compute-1.amazonaws.com cap rename
desc "Rename a host"
task :rename, :role => :server do
  sudo "hostname #{ENV['NAME']}"
  run "echo #{ENV['NAME']} > /tmp/hostname"
  sudo "mv /tmp/hostname /etc/hostname"
end

desc "Apply the puppet config"
task :apply, :role => :server do
  system "git archive --prefix=#{base_dir}/ -o #{base_dir}.tar HEAD"
  upload "#{base_dir}.tar", "#{upload_dir}", :via => :scp
  run "tar xvf #{upload_dir}/#{base_dir}.tar -C /tmp"
  sudo "puppet apply -v --modulepath=#{modulepath} #{puppet_site} --pluginsync"
  run "rm -rf #{upload_dir}/#{base_dir}.tar"
  run "rm -rf #{upload_dir}/#{base_dir}"
end


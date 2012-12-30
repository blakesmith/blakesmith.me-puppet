# Vagrant / Puppet Configuration for blakesmith.me

This is the Vagrant & Puppet setup I use for my personal VPS, blakesmith.me. Several modules are used in concert to setup everything fully automated. [Puppet](http://puppetlabs.com/) is a declarative configuration language for server automation and [Vagrant](http://vagrantup.com/) is a tool that helps with local VM development. Together, it's really easy to build and manage servers the same way you manage other code.

## Run this box locally

[Install Vagrant](http://vagrantup.com/v1/docs/getting-started/index.html). I just run it as a gem with rvm - `gem install vagrant`. Make sure VirtualBox is installed as well.

Then, in the root of this repo do:

```
vagrant box add ubuntu32 http://dl.dropbox.com/u/4031118/Vagrant/ubuntu-12.04.1-server-i686-virtual.box
vagrant up
```

This will download the base ubuntu box I use from Vagrant. This is a bare ubuntu box that has Puppet and Chef preinstalled.

All the packages and configurations should install, go ahead and login to the box:

```
vagrant ssh
```

If you'd like to make a change to site.pp or any of the modules, make the change, then run:

```
vagrant reload
```

This will reboot the VM and reapply the configurations. Note that all Puppet commands should be idempotent, so repeated runs will not harm the VM. After the initial application, subsequent runs should be quite quick.

When you're done with the box, go ahead and:

```
vagrant destroy
```

Or, you can suspend it for later:

```
vagrant suspend
vagrant resume
```

## Running in production

When I've tested the box locally, I use the `cap apply` Capistrano task to upload the puppet modules and apply them remotely.

## Modules

1. add_user - A simple function wrapper to create users, homedirs and add authorized_keys
2. apt - Used to manage aptitude (apt) settings
3. defaultfirewall - Custom mixin that defines my standard firewall
4. duplicity - Automated incremental nightly backups via a crontab. Custom modifications that place restore and status scripts in /root/backup as well
5. firewall - Puppet firewall package. Used to define iptables rules and persist them.
6. java - Basic java jdk packages
7. jekyll - Blogging engine packages, sets up a git push-to-publish repo automatically
8. miscpackages - Custom packages I want installed on all my hosts
9. myapt - Custom module that adds my own custom deb repo to sources.list
10. nginx - Installs nginx, sets up vhosts, proxies.
11. ssh - Configures sshd
12. stdlib - Library functions used by other modules
13. sudo - Configures /etc/sudoers
14. users - My custom users that should be on all hosts

The entry point for the configuration is in `manifests/site.pp`

## Services

1. nginx
2. skeeter - golang image processing web service
3. iphone-metra - jruby iphone rails app with metra schedule
4. blakesmith.me jekyll blog - a push to publish repo in /home/deploy/blakesmith.me that accepts a jekyll blog
